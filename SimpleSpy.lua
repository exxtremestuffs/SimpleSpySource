--- # SimpleSpy.lua <br/>
--- An experimental, lightweight testing tool that logs Roblox RemoteEvent & RemoteFunction calls.
--- @author exxtremestuffs
--- @version paygammy-2.3

local environment
if type(getgenv) == "function" then
	environment = getgenv()
elseif type(_G) == "table" then
	environment = _G
end
if
	type(environment.SimpleSpyExecuted) == "boolean"
	and environment.SimpleSpyExecuted == true
	and type(environment.SimpleSpyShutdown) == "function"
then
	coroutine.resume(coroutine.create(environment.SimpleSpyShutdown))
end
environment.SimpleSpy = {
	--- How many events should be logged until the oldest is removed?
	--- @type number
	MaxLogs = 0,
	--- How large can generated tables be?
	--- @type number
	MaxTableSize = 1000,
	--- How large can generated string be?
	--- @type number
	MaxStringSize = 0,
	--- Are return values recorded?
	--- @type boolean
	RecordReturnValues = false,
}

local v2s, v2v, t2s

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ContentProvider = game:GetService("ContentProvider")
local TextService = game:GetService("TextService")
local Mouse

--- Highlight class constructor.
--- @version 1.0
local Highlight = {}

--- Create a new Highlight object.<br/>
function Highlight.new()
	local highlight = {}
	local parentFrame
	local scrollingFrame
	local textFrame
	local lineNumbersFrame

	-- canvas top shit
	local onFrameSizeChange, updateCanvasSize, updateZIndex

	local tableContents = {}

	local line = 0
	local largestX = 0

	local lineSpace = 15
	local font = Enum.Font.Ubuntu
	local textSize = 14

	local backgroundColor = Color3.fromRGB(40, 44, 52)
	local operatorColor = Color3.fromRGB(187, 85, 255)
	local functionColor = Color3.fromRGB(97, 175, 239)
	local stringColor = Color3.fromRGB(152, 195, 121)
	local numberColor = Color3.fromRGB(209, 154, 102)
	local booleanColor = numberColor
	local objectColor = Color3.fromRGB(229, 192, 123)
	local defaultColor = Color3.fromRGB(224, 108, 117)
	local commentColor = Color3.fromRGB(148, 148, 148)
	local lineNumberColor = commentColor
	local genericColor = Color3.fromRGB(240, 240, 240)

	--- A list of crucial operators used by the internal function.
	--- @type {}
	local operators = {
		"^(function)[^%w_]",
		"^(local)[^%w_]",
		"^(if)[^%w_]",
		"^(for)[^%w_]",
		"^(while)[^%w_]",
		"^(then)[^%w_]",
		"^(do)[^%w_]",
		"^(else)[^%w_]",
		"^(elseif)[^%w_]",
		"^(return)[^%w_]",
		"^(end)[^%w_]",
		"^(continue)[^%w_]",
		"^(and)[^%w_]",
		"^(not)[^%w_]",
		"^(or)[^%w_]",
		"[^%w_](or)[^%w_]",
		"[^%w_](and)[^%w_]",
		"[^%w_](not)[^%w_]",
		"[^%w_](continue)[^%w_]",
		"[^%w_](function)[^%w_]",
		"[^%w_](local)[^%w_]",
		"[^%w_](if)[^%w_]",
		"[^%w_](for)[^%w_]",
		"[^%w_](while)[^%w_]",
		"[^%w_](then)[^%w_]",
		"[^%w_](do)[^%w_]",
		"[^%w_](else)[^%w_]",
		"[^%w_](elseif)[^%w_]",
		"[^%w_](return)[^%w_]",
		"[^%w_](end)[^%w_]",
	}

	local strings = { { '"', '"' }, { "'", "'" }, { "%[%[", "%]%]", true } }
	local comments = { "%-%-%[%[[^%]%]]+%]?%]?", "(%-%-[^\n]+)" }
	local functions = { "[^%w_]([%a_][%a%d_]*)%s*%(", "^([%a_][%a%d_]*)%s*%(", "[:%.%(%[%p]([%a_][%a%d_]*)%s*%(" }
	local numbers = {
		"[^%w_](%d+[eE]?%d*)",
		"[^%w_](%.%d+[eE]?%d*)",
		"[^%w_](%d+%.%d+[eE]?%d*)",
		"^(%d+[eE]?%d*)",
		"^(%.%d+[eE]?%d*)",
		"^(%d+%.%d+[eE]?%d*)",
	}
	local booleans = { "[^%w_](true)", "^(true)", "[^%w_](false)", "^(false)", "[^%w_](nil)", "^(nil)" }
	local objects = { "[^%w_:]([%a_][%a%d_]*):", "^([%a_][%a%d_]*):" }
	local other = { "[^_%s%w=>~<%-%+%*]", ">", "~", "<", "%-", "%+", "=", "%*" }
	local offLimits = {}

	local function isOffLimits(index)
		for _, v in pairs(offLimits) do
			if index >= v[1] and index <= v[2] then
				return true
			end
		end
		return false
	end

	local function gfind(str, pattern)
		return coroutine.wrap(function()
			local start = 0
			while true do
				local findStart, findEnd = str:find(pattern, start)
				if findStart and findEnd ~= #str then
					start = findEnd + 1
					coroutine.yield(findStart, findEnd)
				else
					return
				end
			end
		end)
	end

	local function renderComments()
		local str = highlight:getRaw()
		local step = 1
		for _, pattern in pairs(comments) do
			for commentStart, commentEnd in gfind(str, pattern) do
				if step % 1000 == 0 then
					RunService.Heartbeat:Wait()
				end
				step = step + 1
				if not isOffLimits(commentStart) then
					for i = commentStart, commentEnd do
						table.insert(offLimits, { commentStart, commentEnd })
						if tableContents[i] then
							tableContents[i].Color = commentColor
						end
					end
				end
			end
		end
	end

	local function renderStrings()
		local stringType
		local stringEndType
		local ignoreBackslashes
		local stringStart
		local stringEnd
		local offLimitsIndex
		local skip = false
		for i, char in pairs(tableContents) do
			if stringType then
				char.Color = stringColor
				local possibleString = ""
				for k = stringStart, i do
					possibleString = possibleString .. tableContents[k].Char
				end
				if
					char.Char:match(stringEndType) and not not ignoreBackslashes
					or (
						possibleString:match("(\\*)" .. stringEndType .. "$")
						and #possibleString:match("(\\*)" .. stringEndType .. "$") % 2 == 0
					)
				then
					skip = true
					stringType = nil
					stringEndType = nil
					ignoreBackslashes = nil
					stringEnd = i
					offLimits[offLimitsIndex][2] = stringEnd
				end
			end
			if not skip then
				for _, v in pairs(strings) do
					if char.Char:match(v[1]) and not isOffLimits(i) then
						stringType = v[1]
						stringEndType = v[2]
						ignoreBackslashes = v[3]
						char.Color = stringColor
						stringStart = i
						offLimitsIndex = #offLimits + 1
						offLimits[offLimitsIndex] = { stringStart, math.huge }
					end
				end
			end
			skip = false
		end
	end

	--- Highlight a pattern in a color of your choosing.<br/>
	--- <i>(Will become asynchronous after 1,000 threads)</i>
	--- @param pattern string[]
	--- @param color userdata
	local function highlightPattern(pattern, color)
		local str = highlight:getRaw()
		local step = 1
		for _, pattern in pairs(pattern) do
			for findStart, findEnd in gfind(str, pattern) do
				if step % 1000 == 0 then
					RunService.Heartbeat:Wait()
				end
				step = step + 1
				if not isOffLimits(findStart) and not isOffLimits(findEnd) then
					for i = findStart, findEnd do
						if tableContents[i] then
							tableContents[i].Color = color
						end
					end
				end
			end
		end
	end

	--- Automatically replace reversed characters with escape characters.
	--- @param s string
	--- @return string
	local function autoEscape(s)
		for i = 0, #s do
			local char = string.sub(s, i, i)
			if char == "<" then
				s = string.format("%s%s%s", string.sub(s, 0, i - 1), "&lt;", string.sub(s, i + 1, -1))
				i = i + 3
			elseif char == ">" then
				s = string.format("%s%s%s", string.sub(s, 0, i - 1), "&gt;", string.sub(s, i + 1, -1))
				i = i + 3
			elseif char == '"' then
				s = string.format("%s%s%s", string.sub(s, 0, i - 1), "&quot;", string.sub(s, i + 1, -1))
				i = i + 5
			elseif char == "'" then
				s = string.format("%s%s%s", string.sub(s, 0, i - 1), "&apos;", string.sub(s, i + 1, -1))
				i = i + 5
			elseif char == "&" then
				s = string.format("%s%s%s", string.sub(s, 0, i - 1), "&amp;", string.sub(s, i + 1, -1))
				i = i + 4
			end
		end
		return s
	end

	--- Main function for syntax highlighting tableContents
	local function render()
		offLimits = {}
		textFrame:ClearAllChildren()
		lineNumbersFrame:ClearAllChildren()

		highlightPattern(functions, functionColor)
		highlightPattern(numbers, numberColor)
		highlightPattern(operators, operatorColor)
		highlightPattern(objects, objectColor)
		highlightPattern(booleans, booleanColor)
		highlightPattern(other, genericColor)
		renderComments()
		renderStrings()

		local lastColor
		local lineStr = ""
		local rawStr = ""
		largestX = 0
		line = 1

		for i = 1, #tableContents + 1 do
			local char = tableContents[i]
			if i == #tableContents + 1 or char.Char == "\n" then
				lineStr = lineStr .. (lastColor and "</font>" or "")

				local lineText = Instance.new("TextLabel")
				local x = TextService:GetTextSize(rawStr, textSize, font, Vector2.new(math.huge, math.huge)).X + 60

				if x > largestX then
					largestX = x
				end

				lineText.TextXAlignment = Enum.TextXAlignment.Left
				lineText.TextYAlignment = Enum.TextYAlignment.Top
				lineText.Position = UDim2.new(0, 0, 0, line * lineSpace - lineSpace / 2)
				lineText.Size = UDim2.new(0, x, 0, textSize)
				lineText.RichText = true
				lineText.Font = font
				lineText.TextSize = textSize
				lineText.BackgroundTransparency = 1
				lineText.Text = lineStr
				lineText.Parent = textFrame

				if i ~= #tableContents + 1 then
					local lineNumber = Instance.new("TextLabel")
					lineNumber.Text = line
					lineNumber.Font = font
					lineNumber.TextSize = textSize
					lineNumber.Size = UDim2.new(1, 0, 0, lineSpace)
					lineNumber.TextXAlignment = Enum.TextXAlignment.Right
					lineNumber.TextColor3 = lineNumberColor
					lineNumber.Position = UDim2.new(0, 0, 0, line * lineSpace - lineSpace / 2)
					lineNumber.BackgroundTransparency = 1
					lineNumber.Parent = lineNumbersFrame
				end

				lineStr = ""
				rawStr = ""
				lastColor = nil
				line = line + 1
				updateZIndex()
				updateCanvasSize()
				if line % 5 == 0 then
					RunService.Heartbeat:Wait()
				end
			elseif char.Char == " " then
				lineStr = lineStr .. char.Char
				rawStr = rawStr .. char.Char
			elseif char.Char == "\t" then
				lineStr = lineStr .. string.rep(" ", 4)
				rawStr = rawStr .. char.Char
			else
				if char.Color == lastColor then
					lineStr = lineStr .. autoEscape(char.Char)
				else
					lineStr = lineStr
						.. string.format(
							'%s<font color="rgb(%d,%d,%d)">',
							lastColor and "</font>" or "",
							char.Color.R * 255,
							char.Color.G * 255,
							char.Color.B * 255
						)
					lineStr = lineStr .. autoEscape(char.Char)
					lastColor = char.Color
				end
				rawStr = rawStr .. char.Char
			end
		end
		updateZIndex()
		updateCanvasSize()
	end

	-- canvas shit

	function onFrameSizeChange()
		local newSize = parentFrame.AbsoluteSize
		scrollingFrame.Size = UDim2.new(0, newSize.X, 0, newSize.Y)
	end

	function updateCanvasSize()
		-- local codeSize = Vector2.new(TextService:GetTextSize(highlight:getRaw(), textSize, font, Vector2.new(math.huge, math.huge)).X + 60, #lines * lineSpace + 60)
		scrollingFrame.CanvasSize = UDim2.new(0, largestX, 0, line * lineSpace)
	end

	function updateZIndex()
		for _, v in pairs(parentFrame:GetDescendants()) do
			if v:IsA("GuiObject") then
				v.ZIndex = parentFrame.ZIndex
			end
		end
	end

	-- PUBLIC METHODS --

	--- Runs when a new object is instantiated
	--- @param frame userdata
	function highlight:init(frame)
		if typeof(frame) == "Instance" and frame:IsA("Frame") then
			frame:ClearAllChildren()

			parentFrame = frame
			scrollingFrame = Instance.new("ScrollingFrame")
			textFrame = Instance.new("Frame")
			lineNumbersFrame = Instance.new("Frame")

			local parentSize = frame.AbsoluteSize
			scrollingFrame.Name = "HIGHLIGHT_IDE"
			scrollingFrame.Size = UDim2.new(0, parentSize.X, 0, parentSize.Y)
			scrollingFrame.BackgroundColor3 = backgroundColor
			scrollingFrame.BorderSizePixel = 0
			scrollingFrame.ScrollBarThickness = 4

			textFrame.Name = ""
			textFrame.Size = UDim2.new(1, -40, 1, 0)
			textFrame.Position = UDim2.new(0, 40, 0, 0)
			textFrame.BackgroundTransparency = 1

			lineNumbersFrame.Name = ""
			lineNumbersFrame.Size = UDim2.new(0, 25, 1, 0)
			lineNumbersFrame.BackgroundTransparency = 1

			textFrame.Parent = scrollingFrame
			lineNumbersFrame.Parent = scrollingFrame
			scrollingFrame.Parent = parentFrame

			render()
			parentFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(onFrameSizeChange)
			parentFrame:GetPropertyChangedSignal("ZIndex"):Connect(updateZIndex)
		else
			error("Initialization error: argument " .. typeof(frame) .. " is not a Frame Instance")
		end
	end

	--- Sets the raw text of the code box (\n = new line, \t converted to spaces)
	--- @param raw string
	function highlight:setRaw(raw)
		raw = raw .. "\n"
		tableContents = {}
		local line = 1
		for i = 1, #raw do
			table.insert(tableContents, {
				Char = raw:sub(i, i),
				Color = defaultColor,
				-- Line = line
			})
			if i % 1000 == 0 then
				RunService.Heartbeat:Wait()
			end
			-- if raw:sub(i, i) == "\n" then
			--     line = line + 1
			-- end
		end
		render()
	end

	--- Returns the (string) raw text of the code box (\n = new line). This includes placeholder characters so it should only be used internally.
	--- @return string
	function highlight:getRaw()
		local result = ""
		for _, char in pairs(tableContents) do
			result = result .. char.Char
		end
		return result
	end

	--- Returns the (string) text of the code box (\n = new line)
	--- @return string
	function highlight:getString()
		local result = ""
		for _, char in pairs(tableContents) do
			result = result .. char.Char:sub(1, 1)
		end
		return result
	end

	--- Returns the (char[]) array that holds all the lines in order as strings
	--- @return table[]
	function highlight:getTable()
		return tableContents
	end

	--- Returns the (int) number of lines in the code box
	--- @return number
	function highlight:getSize()
		return #tableContents
	end

	--- Returns the (string) line of the specified line number
	--- @param line number
	--- @return string
	function highlight:getLine(line)
		local currentline = 0
		local rightLine = false
		local result = ""
		for _, v in pairs(tableContents) do
			currentline = currentline + 1
			if v.Char == "\n" and not rightLine then
				rightLine = true
			end
			if rightLine and v.Char ~= "\n" then
				result = result .. v.Char
			elseif rightLine then
				break
			end
		end
		return result
	end

	--- Replaces the specified line number with the specified string (\n will overwrite further lines)
	--- @param line number
	--- @param text string
	function highlight:setLine(line, text)
		if #tableContents and line >= tableContents[#tableContents].Line then
			for i = tableContents[#tableContents].Line, line do
				table.insert(tableContents, {
					Char = "\n",
					Line = i,
					Color = defaultColor,
				})
				local str = highlight:getRaw()
				str = str:sub(0, #str) .. text
				highlight:setRaw(str)
				return
			end
		elseif not #tableContents then
			return
		end
		local str = highlight:getRaw()
		local lastStart = 0
		local currentLine = 0
		for i in gfind(str, "\n") do
			currentLine = currentLine + 1
			if line == currentLine then
				str = str:sub(0, lastStart) .. text .. str:sub(i, #str)
				highlight:setRaw(str)
				return
			end
		end
		error("Unable to set line")
	end

	--- Inserts a line made from the specified string and moves all existing lines down (\n will insert further lines)
	--- @param line number
	---@param text string
	function highlight:insertLine(line, text)
		if #tableContents and line >= tableContents[#tableContents].Line then
			highlight:setLine(line, text)
		elseif not #tableContents then
			return
		end
		local str = highlight:getRaw()
		local lastStart = 0
		local currentLine = 0
		for i in gfind(str, "\n") do
			currentLine = currentLine + 1
			if line == currentLine then
				str = str:sub(0, lastStart) .. "\n" .. text .. "\n" .. str:sub(i, #str)
				highlight:setRaw(str)
				return
			end
		end
		error("Unable to insert line")
	end

	return highlight
end

local SimpleSpy2 = Instance.new("ScreenGui")
local Background = Instance.new("Frame")
local LeftPanel = Instance.new("Frame")
local LogList = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local RemoteTemplate = Instance.new("Frame")
local ColorBar = Instance.new("Frame")
local Text = Instance.new("TextLabel")
local Button = Instance.new("TextButton")
local RightPanel = Instance.new("Frame")
local CodeBox = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIGridLayout = Instance.new("UIGridLayout")
local FunctionTemplate = Instance.new("Frame")
local ColorBar_2 = Instance.new("Frame")
local Text_2 = Instance.new("TextLabel")
local Button_2 = Instance.new("TextButton")
local TopBar = Instance.new("Frame")
local Simple = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local ImageLabel = Instance.new("ImageLabel")
local MaximizeButton = Instance.new("TextButton")
local ImageLabel_2 = Instance.new("ImageLabel")
local MinimizeButton = Instance.new("TextButton")
local ImageLabel_3 = Instance.new("ImageLabel")
local ToolTip = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")

--Properties:

SimpleSpy2.Name = "SimpleSpy2"
SimpleSpy2.ResetOnSpawn = false

Background.Name = "Background"
Background.Parent = SimpleSpy2
Background.BackgroundColor3 = Color3.new(1, 1, 1)
Background.BackgroundTransparency = 1
Background.Position = UDim2.new(0, 500, 0, 200)
Background.Size = UDim2.new(0, 450, 0, 268)

LeftPanel.Name = "LeftPanel"
LeftPanel.Parent = Background
LeftPanel.BackgroundColor3 = Color3.fromRGB(53, 52, 55)
LeftPanel.BorderSizePixel = 0
LeftPanel.Position = UDim2.new(0, 0, 0, 19)
LeftPanel.Size = UDim2.new(0, 131, 0, 249)

LogList.Name = "LogList"
LogList.Parent = LeftPanel
LogList.Active = true
LogList.BackgroundColor3 = Color3.new(1, 1, 1)
LogList.BackgroundTransparency = 1
LogList.BorderSizePixel = 0
LogList.Position = UDim2.new(0, 0, 0, 9)
LogList.Size = UDim2.new(0, 131, 0, 232)
LogList.CanvasSize = UDim2.new(0, 0, 0, 0)
LogList.ScrollBarThickness = 4

UIListLayout.Parent = LogList
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

RemoteTemplate.Name = "RemoteTemplate"
RemoteTemplate.Parent = LogList
RemoteTemplate.BackgroundColor3 = Color3.new(1, 1, 1)
RemoteTemplate.BackgroundTransparency = 1
RemoteTemplate.Size = UDim2.new(0, 117, 0, 27)

ColorBar.Name = "ColorBar"
ColorBar.Parent = RemoteTemplate
ColorBar.BackgroundColor3 = Color3.fromRGB(255, 242, 0)
ColorBar.BorderSizePixel = 0
ColorBar.Position = UDim2.new(0, 0, 0, 1)
ColorBar.Size = UDim2.new(0, 7, 0, 18)
ColorBar.ZIndex = 2

Text.Name = "Text"
Text.Parent = RemoteTemplate
Text.BackgroundColor3 = Color3.new(1, 1, 1)
Text.BackgroundTransparency = 1
Text.Position = UDim2.new(0, 12, 0, 1)
Text.Size = UDim2.new(0, 105, 0, 18)
Text.ZIndex = 2
Text.Font = Enum.Font.SourceSans
Text.Text = "TEXT"
Text.TextColor3 = Color3.new(1, 1, 1)
Text.TextSize = 14
Text.TextXAlignment = Enum.TextXAlignment.Left
Text.TextWrapped = true

Button.Name = "Button"
Button.Parent = RemoteTemplate
Button.BackgroundColor3 = Color3.new(0, 0, 0)
Button.BackgroundTransparency = 0.75
Button.BorderColor3 = Color3.new(1, 1, 1)
Button.Position = UDim2.new(0, 0, 0, 1)
Button.Size = UDim2.new(0, 117, 0, 18)
Button.AutoButtonColor = false
Button.Font = Enum.Font.SourceSans
Button.Text = ""
Button.TextColor3 = Color3.new(0, 0, 0)
Button.TextSize = 14

RightPanel.Name = "RightPanel"
RightPanel.Parent = Background
RightPanel.BackgroundColor3 = Color3.fromRGB(37, 36, 38)
RightPanel.BorderSizePixel = 0
RightPanel.Position = UDim2.new(0, 131, 0, 19)
RightPanel.Size = UDim2.new(0, 319, 0, 249)

CodeBox.Name = "CodeBox"
CodeBox.Parent = RightPanel
CodeBox.BackgroundColor3 = Color3.new(0.0823529, 0.0745098, 0.0784314)
CodeBox.BorderSizePixel = 0
CodeBox.Size = UDim2.new(0, 319, 0, 119)

ScrollingFrame.Parent = RightPanel
ScrollingFrame.Active = true
ScrollingFrame.BackgroundColor3 = Color3.new(1, 1, 1)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.Position = UDim2.new(0, 0, 0.5, 0)
ScrollingFrame.Size = UDim2.new(1, 0, 0.5, -9)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.ScrollBarThickness = 4

UIGridLayout.Parent = ScrollingFrame
UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 0)
UIGridLayout.CellSize = UDim2.new(0, 94, 0, 27)

FunctionTemplate.Name = "FunctionTemplate"
FunctionTemplate.Parent = ScrollingFrame
FunctionTemplate.BackgroundColor3 = Color3.new(1, 1, 1)
FunctionTemplate.BackgroundTransparency = 1
FunctionTemplate.Size = UDim2.new(0, 117, 0, 23)

ColorBar_2.Name = "ColorBar"
ColorBar_2.Parent = FunctionTemplate
ColorBar_2.BackgroundColor3 = Color3.new(1, 1, 1)
ColorBar_2.BorderSizePixel = 0
ColorBar_2.Position = UDim2.new(0, 7, 0, 10)
ColorBar_2.Size = UDim2.new(0, 7, 0, 18)
ColorBar_2.ZIndex = 3

Text_2.Name = "Text"
Text_2.Parent = FunctionTemplate
Text_2.BackgroundColor3 = Color3.new(1, 1, 1)
Text_2.BackgroundTransparency = 1
Text_2.Position = UDim2.new(0, 19, 0, 10)
Text_2.Size = UDim2.new(0, 69, 0, 18)
Text_2.ZIndex = 2
Text_2.Font = Enum.Font.SourceSans
Text_2.Text = "TEXT"
Text_2.TextColor3 = Color3.new(1, 1, 1)
Text_2.TextSize = 14
Text_2.TextStrokeColor3 = Color3.new(0.145098, 0.141176, 0.14902)
Text_2.TextXAlignment = Enum.TextXAlignment.Left
Text_2.TextWrapped = true

Button_2.Name = "Button"
Button_2.Parent = FunctionTemplate
Button_2.BackgroundColor3 = Color3.new(0, 0, 0)
Button_2.BackgroundTransparency = 0.69999998807907
Button_2.BorderColor3 = Color3.new(1, 1, 1)
Button_2.Position = UDim2.new(0, 7, 0, 10)
Button_2.Size = UDim2.new(0, 80, 0, 18)
Button_2.AutoButtonColor = false
Button_2.Font = Enum.Font.SourceSans
Button_2.Text = ""
Button_2.TextColor3 = Color3.new(0, 0, 0)
Button_2.TextSize = 14

TopBar.Name = "TopBar"
TopBar.Parent = Background
TopBar.BackgroundColor3 = Color3.fromRGB(37, 35, 38)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(0, 450, 0, 19)

Simple.Name = "Simple"
Simple.Parent = TopBar
Simple.BackgroundColor3 = Color3.new(1, 1, 1)
Simple.AutoButtonColor = false
Simple.BackgroundTransparency = 1
Simple.Position = UDim2.new(0, 5, 0, 0)
Simple.Size = UDim2.new(0, 57, 0, 18)
Simple.Font = Enum.Font.SourceSansBold
Simple.Text = "SimpleSpy"
Simple.TextColor3 = Color3.new(1, 1, 1)
Simple.TextSize = 14
Simple.TextXAlignment = Enum.TextXAlignment.Left

CloseButton.Name = "CloseButton"
CloseButton.Parent = TopBar
CloseButton.BackgroundColor3 = Color3.new(0.145098, 0.141176, 0.14902)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -19, 0, 0)
CloseButton.Size = UDim2.new(0, 19, 0, 19)
CloseButton.Font = Enum.Font.SourceSans
CloseButton.Text = ""
CloseButton.TextColor3 = Color3.new(0, 0, 0)
CloseButton.TextSize = 14

ImageLabel.Parent = CloseButton
ImageLabel.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel.BackgroundTransparency = 1
ImageLabel.Position = UDim2.new(0, 5, 0, 5)
ImageLabel.Size = UDim2.new(0, 9, 0, 9)
ImageLabel.Image = "http://www.roblox.com/asset/?id=5597086202"

MaximizeButton.Name = "MaximizeButton"
MaximizeButton.Parent = TopBar
MaximizeButton.BackgroundColor3 = Color3.new(0.145098, 0.141176, 0.14902)
MaximizeButton.BorderSizePixel = 0
MaximizeButton.Position = UDim2.new(1, -38, 0, 0)
MaximizeButton.Size = UDim2.new(0, 19, 0, 19)
MaximizeButton.Font = Enum.Font.SourceSans
MaximizeButton.Text = ""
MaximizeButton.TextColor3 = Color3.new(0, 0, 0)
MaximizeButton.TextSize = 14

ImageLabel_2.Parent = MaximizeButton
ImageLabel_2.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel_2.BackgroundTransparency = 1
ImageLabel_2.Position = UDim2.new(0, 5, 0, 5)
ImageLabel_2.Size = UDim2.new(0, 9, 0, 9)
ImageLabel_2.Image = "http://www.roblox.com/asset/?id=5597108117"

MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TopBar
MinimizeButton.BackgroundColor3 = Color3.new(0.145098, 0.141176, 0.14902)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(1, -57, 0, 0)
MinimizeButton.Size = UDim2.new(0, 19, 0, 19)
MinimizeButton.Font = Enum.Font.SourceSans
MinimizeButton.Text = ""
MinimizeButton.TextColor3 = Color3.new(0, 0, 0)
MinimizeButton.TextSize = 14

ImageLabel_3.Parent = MinimizeButton
ImageLabel_3.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel_3.BackgroundTransparency = 1
ImageLabel_3.Position = UDim2.new(0, 5, 0, 5)
ImageLabel_3.Size = UDim2.new(0, 9, 0, 9)
ImageLabel_3.Image = "http://www.roblox.com/asset/?id=5597105827"

ToolTip.Name = "ToolTip"
ToolTip.Parent = SimpleSpy2
ToolTip.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
ToolTip.BackgroundTransparency = 0.1
ToolTip.BorderColor3 = Color3.new(1, 1, 1)
ToolTip.Size = UDim2.new(0, 200, 0, 50)
ToolTip.ZIndex = 3
ToolTip.Visible = false

TextLabel.Parent = ToolTip
TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.new(0, 2, 0, 2)
TextLabel.Size = UDim2.new(0, 196, 0, 46)
TextLabel.ZIndex = 3
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "This is some slightly longer text."
TextLabel.TextColor3 = Color3.new(1, 1, 1)
TextLabel.TextSize = 14
TextLabel.TextWrapped = true
TextLabel.TextXAlignment = Enum.TextXAlignment.Left
TextLabel.TextYAlignment = Enum.TextYAlignment.Top

local selectedColor = Color3.new(0.321569, 0.333333, 1)
local deselectedColor = Color3.new(0.8, 0.8, 0.8)
--- So things are descending
local layoutOrderNum = 999999999
--- Whether or not the gui is closing
local mainClosing = false
--- Whether or not the gui is closed (defaults to false)
local closed = false
--- Whether or not the sidebar is closing
local sideClosing = false
--- Whether or not the sidebar is closed (defaults to true but opens automatically on remote selection)
local sideClosed = false
--- Whether or not the code box is maximized (defaults to false)
local maximized = false

--- The event logs to be read from
local logs = {}

--- The event currently selected.Log (defaults to nil)
local selected = nil

--- The blacklist (can be a string name or the Remote Instance)
local blacklist = {}

--- The block list (can be a string name or the Remote Instance)
local blocklist = {}

--- Whether or not to add getNil function.
--- @type boolean
local getNil = false

--- Array of remotes (and original functions) connected to
local connectedRemotes = {}

--- True = hookfunction, false = namecall
local toggle = false
local gm
local original

--- Used to prevent recursive execution.
--- @deprecated
local prevTables = {}

--- Queues logs for deletion.
--- @type {[any]: {[number]: userdata}}
local remoteLogs = {}

--- This local is required for `hookfunction`, do not remove it!
local remoteEvent = Instance.new("RemoteEvent")

--- This local is required for `hookfunction`, do not remove it!
local remoteFunction = Instance.new("RemoteFunction")

--- RBXScriptSignal belonging to local remotes.
local originalEvent, originalFunction = remoteEvent.FireServer, remoteFunction.InvokeServer

environment.SimpleSpy = {
	--- How many events should be logged until the oldest is removed?
	--- @type number
	MaxLogs = 0,
	--- How large can generated tables be?
	--- @type number
	MaxTableSize = 1000,
	--- How large can generated string be?
	--- @type number
	MaxStringSize = 0,
}

--- how many spaces to indent
local indent = 4
--- used for task scheduler
local scheduled = {}
--- RBXScriptConnect of the task scheduler
local schedulerconnect
local topstr = ""
local bottomstr = ""
local remotesFadeIn
local rightFadeIn
local codebox
local p
local getnilrequired = false

-- autoblock variables
local autoblock = false
local history = {}
local excluding = {}

-- function info variables
local funcEnabled = true

-- remote hooking/connecting api variables
local remoteSignals = {}
local remoteHooks = {}

-- original mouse icon
local oldIcon

-- if mouse inside gui
local mouseInGui = false

-- handy array of RBXScriptConnections to disconnect on shutdown
local connections = {}

-- whether or not SimpleSpy uses 'getcallingscript()' to get the script (default is false because detection)
local useGetCallingScript = false

--- used to enable/disable SimpleSpy's keyToString for remotes
local keyToString = false
local recordReturnValues = environment.SimpleSpy.RecordReturnValues

--- Converts arguments to a string and generates code that calls the specified method with them, recommended to be used in conjunction with ValueToString (method must be a string, e.g. `game:GetService("ReplicatedStorage").Remote.remote:FireServer`)
--- @param method string
--- @param args any[]
--- @return string
function SimpleSpy:ArgsToString(method, args)
	assert(typeof(method) == "string", "string expected, got " .. typeof(method))
	assert(typeof(args) == "table", "table expected, got " .. typeof(args))
	return v2v({ args = args }) .. "\n\n" .. method .. "(unpack(args))"
end

--- Converts a value to variables with the specified index as the variable name (if nil/invalid then the name will be assigned automatically)
--- @param t any[]
--- @return string
function SimpleSpy:TableToVars(t)
	assert(typeof(t) == "table", "table expected, got " .. typeof(t))
	return v2v(t)
end

--- Converts a value to a variable with the specified `variablename` (if nil/invalid then the name will be assigned automatically)
--- @param value any
--- @return string
function SimpleSpy:ValueToVar(value, variablename)
	assert(variablename == nil or typeof(variablename) == "string", "string expected, got " .. typeof(variablename))
	if not variablename then
		variablename = 1
	end
	return v2v({ [variablename] = value })
end

--- Converts any value to a string, cannot preserve function contents
--- @param value any
--- @return string
function SimpleSpy:ValueToString(value)
	return v2s(value)
end

--- Generates the simplespy function info
--- @param func function
--- @return string
function SimpleSpy:GetFunctionInfo(func)
	assert(typeof(func) == "function", "Instance expected, got " .. typeof(func))
	warn("Function info currently unavailable due to crashing in Synapse X")
	return v2v({ functionInfo = {
		info = debug.getinfo(func),
		constants = debug.getconstants(func),
	} })
end

--- Gets the ScriptSignal for a specified remote being fired
--- @param remote Instance
function SimpleSpy:GetRemoteFiredSignal(remote)
	assert(typeof(remote) == "Instance", "Instance expected, got " .. typeof(remote))
	if not remoteSignals[remote] then
		remoteSignals[remote] = newSignal()
	end
	return remoteSignals[remote]
end

--- Allows for direct hooking of remotes **THIS CAN BE VERY DANGEROUS**
--- @param remote Instance
--- @param f function
function SimpleSpy:HookRemote(remote, f)
	assert(typeof(remote) == "Instance", "Instance expected, got " .. typeof(remote))
	assert(typeof(f) == "function", "function expected, got " .. typeof(f))
	remoteHooks[remote] = f
end

--- Blocks the specified remote instance/string
--- @param remote any
function SimpleSpy:BlockRemote(remote)
	assert(
		typeof(remote) == "Instance" or typeof(remote) == "string",
		"Instance | string expected, got " .. typeof(remote)
	)
	blocklist[remote] = true
end

--- Excludes the specified remote from logs (instance/string)
--- @param remote any
function SimpleSpy:ExcludeRemote(remote)
	assert(
		typeof(remote) == "Instance" or typeof(remote) == "string",
		"Instance | string expected, got " .. typeof(remote)
	)
	blacklist[remote] = true
end

--- Creates a new ScriptSignal that can be connected to and fired
--- @return table
function newSignal()
	local connected = {}
	return {
		Connect = function(self, f)
			assert(connected, "Signal is closed")
			connected[tostring(f)] = f
			return {
				Connected = true,
				Disconnect = function(self)
					if not connected then
						warn("Signal is already closed")
					end
					self.Connected = false
					connected[tostring(f)] = nil
				end,
			}
		end,
		Wait = function(self)
			local thread = coroutine.running()
			local connection
			connection = self:Connect(function()
				connection:Disconnect()
				if coroutine.status(thread) == "suspended" then
					coroutine.resume(thread)
				end
			end)
			coroutine.yield()
		end,
		Fire = function(self, ...)
			for _, f in pairs(connected) do
				coroutine.wrap(f)(...)
			end
		end,
	}
end

function clean()
	local max = environment.SimpleSpy.MaxLogs
	if not typeof(max) == "number" and math.floor(max) ~= max then
		max = 500
	end
	if #remoteLogs > max then
		for i = 100, #remoteLogs do
			local v = remoteLogs[i]
			if typeof(v[1]) == "RBXScriptConnection" then
				v[1]:Disconnect()
			end
			if typeof(v[2]) == "Instance" then
				v[2]:Destroy()
			end
		end
		local newLogs = {}
		for i = 1, 100 do
			table.insert(newLogs, remoteLogs[i])
		end
		remoteLogs = newLogs
	end
end

--- Scales the ToolTip to fit containing text
function scaleToolTip()
	local size =
		TextService:GetTextSize(TextLabel.Text, TextLabel.TextSize, TextLabel.Font, Vector2.new(196, math.huge))
	TextLabel.Size = UDim2.new(0, size.X, 0, size.Y)
	ToolTip.Size = UDim2.new(0, size.X + 4, 0, size.Y + 4)
end

--- Executed when the toggle button (the SimpleSpy logo) is hovered over
function onToggleButtonHover()
	if not toggle then
		TweenService:Create(Simple, TweenInfo.new(0.5), { TextColor3 = Color3.fromRGB(252, 51, 51) }):Play()
	else
		TweenService:Create(Simple, TweenInfo.new(0.5), { TextColor3 = Color3.fromRGB(68, 206, 91) }):Play()
	end
end

--- Executed when the toggle button is unhovered over
function onToggleButtonUnhover()
	TweenService:Create(Simple, TweenInfo.new(0.5), { TextColor3 = Color3.fromRGB(255, 255, 255) }):Play()
end

--- Executed when the X button is hovered over
function onXButtonHover()
	TweenService:Create(CloseButton, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(255, 60, 60) }):Play()
end

--- Executed when the X button is unhovered over
function onXButtonUnhover()
	TweenService:Create(CloseButton, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(37, 36, 38) }):Play()
end

--- Toggles the remote spy method (when button clicked)
function onToggleButtonClick()
	if toggle then
		TweenService:Create(Simple, TweenInfo.new(0.5), { TextColor3 = Color3.fromRGB(252, 51, 51) }):Play()
	else
		TweenService:Create(Simple, TweenInfo.new(0.5), { TextColor3 = Color3.fromRGB(68, 206, 91) }):Play()
	end
	toggleSpyMethod()
end

--- Reconnects bringBackOnResize if the current viewport changes and also connects it initially
function connectResize()
	local lastCam = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(bringBackOnResize)
	workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
		lastCam:Disconnect()
		if workspace.CurrentCamera then
			lastCam = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(bringBackOnResize)
		end
	end)
end

--- Brings gui back if it gets lost offscreen (connected to the camera viewport changing)
function bringBackOnResize()
	validateSize()
	if sideClosed then
		minimizeSize()
	else
		maximizeSize()
	end
	local currentX = Background.AbsolutePosition.X
	local currentY = Background.AbsolutePosition.Y
	local viewportSize = workspace.CurrentCamera.ViewportSize
	if (currentX < 0) or (currentX > (viewportSize.X - (sideClosed and 131 or Background.AbsoluteSize.X))) then
		if currentX < 0 then
			currentX = 0
		else
			currentX = viewportSize.X - (sideClosed and 131 or Background.AbsoluteSize.X)
		end
	end
	if (currentY < 0) or (currentY > (viewportSize.Y - (closed and 19 or Background.AbsoluteSize.Y) - 36)) then
		if currentY < 0 then
			currentY = 0
		else
			currentY = viewportSize.Y - (closed and 19 or Background.AbsoluteSize.Y) - 36
		end
	end
	TweenService.Create(
		TweenService,
		Background,
		TweenInfo.new(0.1),
		{ Position = UDim2.new(0, currentX, 0, currentY) }
	)
		:Play()
end

--- Drags gui (so long as mouse is held down)
--- @param input InputObject
function onBarInput(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		local lastPos = UserInputService.GetMouseLocation(UserInputService)
		local mainPos = Background.AbsolutePosition
		local offset = mainPos - lastPos
		local currentPos = offset + lastPos
		RunService.BindToRenderStep(RunService, "drag", 1, function()
			local newPos = UserInputService.GetMouseLocation(UserInputService)
			if newPos ~= lastPos then
				local currentX = (offset + newPos).X
				local currentY = (offset + newPos).Y
				local viewportSize = workspace.CurrentCamera.ViewportSize
				if
					(currentX < 0 and currentX < currentPos.X)
					or (
						currentX > (viewportSize.X - (sideClosed and 131 or TopBar.AbsoluteSize.X))
						and currentX > currentPos.X
					)
				then
					if currentX < 0 then
						currentX = 0
					else
						currentX = viewportSize.X - (sideClosed and 131 or TopBar.AbsoluteSize.X)
					end
				end
				if
					(currentY < 0 and currentY < currentPos.Y)
					or (
						currentY > (viewportSize.Y - (closed and 19 or Background.AbsoluteSize.Y) - 36)
						and currentY > currentPos.Y
					)
				then
					if currentY < 0 then
						currentY = 0
					else
						currentY = viewportSize.Y - (closed and 19 or Background.AbsoluteSize.Y) - 36
					end
				end
				currentPos = Vector2.new(currentX, currentY)
				lastPos = newPos
				TweenService.Create(
					TweenService,
					Background,
					TweenInfo.new(0.1),
					{ Position = UDim2.new(0, currentPos.X, 0, currentPos.Y) }
				):Play()
			end
			-- if input.UserInputState ~= Enum.UserInputState.Begin then
			--     RunService.UnbindFromRenderStep(RunService, "drag")
			-- end
		end)
		table.insert(
			connections,
			UserInputService.InputEnded:Connect(function(inputE)
				if input == inputE then
					RunService:UnbindFromRenderStep("drag")
				end
			end)
		)
	end
end

--- Fades out the table of elements (and makes them invisible), returns a function to make them visible again
function fadeOut(elements)
	local data = {}
	for _, v in pairs(elements) do
		if typeof(v) == "Instance" and v:IsA("GuiObject") and v.Visible then
			coroutine.wrap(function()
				data[v] = {
					BackgroundTransparency = v.BackgroundTransparency,
				}
				TweenService:Create(v, TweenInfo.new(0.5), { BackgroundTransparency = 1 }):Play()
				if v:IsA("TextBox") or v:IsA("TextButton") or v:IsA("TextLabel") then
					data[v].TextTransparency = v.TextTransparency
					TweenService:Create(v, TweenInfo.new(0.5), { TextTransparency = 1 }):Play()
				elseif v:IsA("ImageButton") or v:IsA("ImageLabel") then
					data[v].ImageTransparency = v.ImageTransparency
					TweenService:Create(v, TweenInfo.new(0.5), { ImageTransparency = 1 }):Play()
				end
				wait(0.5)
				v.Visible = false
				for i, x in pairs(data[v]) do
					v[i] = x
				end
				data[v] = true
			end)()
		end
	end
	return function()
		for i, _ in pairs(data) do
			coroutine.wrap(function()
				local properties = {
					BackgroundTransparency = i.BackgroundTransparency,
				}
				i.BackgroundTransparency = 1
				TweenService
					:Create(i, TweenInfo.new(0.5), { BackgroundTransparency = properties.BackgroundTransparency })
					:Play()
				if i:IsA("TextBox") or i:IsA("TextButton") or i:IsA("TextLabel") then
					properties.TextTransparency = i.TextTransparency
					i.TextTransparency = 1
					TweenService:Create(i, TweenInfo.new(0.5), { TextTransparency = properties.TextTransparency })
						:Play()
				elseif i:IsA("ImageButton") or i:IsA("ImageLabel") then
					properties.ImageTransparency = i.ImageTransparency
					i.ImageTransparency = 1
					TweenService:Create(i, TweenInfo.new(0.5), { ImageTransparency = properties.ImageTransparency })
						:Play()
				end
				i.Visible = true
			end)()
		end
	end
end

--- Expands and minimizes the gui (closed is the toggle boolean)
function toggleMinimize(override)
	if mainClosing and not override or maximized then
		return
	end
	mainClosing = true
	closed = not closed
	if closed then
		if not sideClosed then
			toggleSideTray(true)
		end
		LeftPanel.Visible = true
		TweenService:Create(LeftPanel, TweenInfo.new(0.5), { Size = UDim2.new(0, 131, 0, 0) }):Play()
		wait(0.5)
		remotesFadeIn = fadeOut(LeftPanel:GetDescendants())
		wait(0.5)
	else
		TweenService:Create(LeftPanel, TweenInfo.new(0.5), { Size = UDim2.new(0, 131, 0, 249) }):Play()
		wait(0.5)
		if remotesFadeIn then
			remotesFadeIn()
			remotesFadeIn = nil
		end
		bringBackOnResize()
	end
	mainClosing = false
end

--- Expands and minimizes the sidebar (sideClosed is the toggle boolean)
function toggleSideTray(override)
	if sideClosing and not override or maximized then
		return
	end
	sideClosing = true
	sideClosed = not sideClosed
	if sideClosed then
		rightFadeIn = fadeOut(RightPanel:GetDescendants())
		wait(0.5)
		minimizeSize(0.5)
		wait(0.5)
		RightPanel.Visible = false
	else
		if closed then
			toggleMinimize(true)
		end
		RightPanel.Visible = true
		maximizeSize(0.5)
		wait(0.5)
		if rightFadeIn then
			rightFadeIn()
		end
		bringBackOnResize()
	end
	sideClosing = false
end

--- Expands code preview to fit screen for more convenient viewing.<br/>
--- @deprecated
function toggleMaximize()
	if not sideClosed and not maximized then
		maximized = true
		local disable = Instance.new("TextButton")
		local prevSize = UDim2.new(0, CodeBox.AbsoluteSize.X, 0, CodeBox.AbsoluteSize.Y)
		local prevPos = UDim2.new(0, CodeBox.AbsolutePosition.X, 0, CodeBox.AbsolutePosition.Y)
		disable.Size = UDim2.new(1, 0, 1, 0)
		disable.BackgroundColor3 = Color3.new()
		disable.BorderSizePixel = 0
		disable.Text = 0
		disable.ZIndex = 3
		disable.BackgroundTransparency = 1
		disable.AutoButtonColor = false
		CodeBox.ZIndex = 4
		CodeBox.Position = prevPos
		CodeBox.Size = prevSize
		TweenService:Create(
			CodeBox,
			TweenInfo.new(0.5),
			{ Size = UDim2.new(0.5, 0, 0.5, 0), Position = UDim2.new(0.25, 0, 0.25, 0) }
		):Play()
		TweenService:Create(disable, TweenInfo.new(0.5), { BackgroundTransparency = 0.5 }):Play()
		disable.MouseButton1Click:Connect(function()
			if
				UserInputService:GetMouseLocation().Y + 36 >= CodeBox.AbsolutePosition.Y
				and UserInputService:GetMouseLocation().Y + 36 <= CodeBox.AbsolutePosition.Y + CodeBox.AbsoluteSize.Y
				and UserInputService:GetMouseLocation().X >= CodeBox.AbsolutePosition.X
				and UserInputService:GetMouseLocation().X <= CodeBox.AbsolutePosition.X + CodeBox.AbsoluteSize.X
			then
				return
			end
			TweenService:Create(CodeBox, TweenInfo.new(0.5), { Size = prevSize, Position = prevPos }):Play()
			TweenService:Create(disable, TweenInfo.new(0.5), { BackgroundTransparency = 1 }):Play()
			maximized = false
			wait(0.5)
			disable:Destroy()
			CodeBox.Size = UDim2.new(1, 0, 0.5, 0)
			CodeBox.Position = UDim2.new(0, 0, 0, 0)
			CodeBox.ZIndex = 0
		end)
	end
end

--- Validate cursor's proximity to resize range
--- @param position userdata
function isInResizeRange(position)
	local relativeP = position - Background.AbsolutePosition
	local range = 5
	if
		relativeP.X >= TopBar.AbsoluteSize.X - range
		and relativeP.Y >= Background.AbsoluteSize.Y - range
		and relativeP.X <= TopBar.AbsoluteSize.X
		and relativeP.Y <= Background.AbsoluteSize.Y
	then
		return true, "B"
	elseif relativeP.X >= TopBar.AbsoluteSize.X - range and relativeP.X <= Background.AbsoluteSize.X then
		return true, "X"
	elseif relativeP.Y >= Background.AbsoluteSize.Y - range and relativeP.Y <= Background.AbsoluteSize.Y then
		return true, "Y"
	end
	return false
end

--- Checks if cursor is within dragging range
--- @param position userdata
function isInDragRange(position)
	local relativeP = position - Background.AbsolutePosition
	if
		relativeP.X <= TopBar.AbsoluteSize.X - CloseButton.AbsoluteSize.X * 3
		and relativeP.X >= 0
		and relativeP.Y <= TopBar.AbsoluteSize.Y
		and relativeP.Y >= 0
	then
		return true
	end
	return false
end

--- SimpleSpy mouse entry callback.
function mouseEntered()
	local existingCursor = SimpleSpy2:FindFirstChild("Cursor")
	while existingCursor do
		existingCursor:Destroy()
		existingCursor = SimpleSpy2:FindFirstChild("Cursor")
	end
	local customCursor = Instance.new("ImageLabel")
	customCursor.Name = "Cursor"
	customCursor.Size = UDim2.fromOffset(200, 200)
	customCursor.ZIndex = 1e5
	customCursor.BackgroundTransparency = 1
	customCursor.Image = ""
	customCursor.Parent = SimpleSpy2
	UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceHide
	RunService:BindToRenderStep("SIMPLESPY_CURSOR", 1, function()
		if mouseInGui and environment.SimpleSpyExecuted then
			local mouseLocation = UserInputService:GetMouseLocation() - Vector2.new(0, 36)
			customCursor.Position = UDim2.fromOffset(
				mouseLocation.X - customCursor.AbsoluteSize.X / 2,
				mouseLocation.Y - customCursor.AbsoluteSize.Y / 2
			)
			local inRange, type = isInResizeRange(mouseLocation)
			if inRange and not sideClosed and not closed then
				customCursor.Image = type == "B" and "rbxassetid://6065821980"
					or type == "X" and "rbxassetid://6065821086"
					or type == "Y" and "rbxassetid://6065821596"
			elseif inRange and not closed and type == "Y" or type == "B" then
				customCursor.Image = "rbxassetid://6065821596"
			elseif customCursor.Image ~= "rbxassetid://6065775281" then
				customCursor.Image = "rbxassetid://6065775281"
			end
		else
			UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.None
			customCursor:Destroy()
			RunService:UnbindFromRenderStep("SIMPLESPY_CURSOR")
		end
	end)
end

--- When the mouse is moved.
function mouseMoved()
	local mousePos = UserInputService:GetMouseLocation() - Vector2.new(0, 36)
	if
		not closed
		and mousePos.X >= TopBar.AbsolutePosition.X
		and mousePos.X <= TopBar.AbsolutePosition.X + TopBar.AbsoluteSize.X
		and mousePos.Y >= Background.AbsolutePosition.Y
		and mousePos.Y <= Background.AbsolutePosition.Y + Background.AbsoluteSize.Y
	then
		if not mouseInGui then
			mouseInGui = true
			mouseEntered()
		end
	else
		mouseInGui = false
	end
end

--- Maximize UI size.
function maximizeSize(speed)
	if not speed then
		speed = 0.05
	end
	TweenService:Create(
		LeftPanel,
		TweenInfo.new(speed),
		{ Size = UDim2.fromOffset(LeftPanel.AbsoluteSize.X, Background.AbsoluteSize.Y - TopBar.AbsoluteSize.Y) }
	):Play()
	TweenService:Create(RightPanel, TweenInfo.new(speed), {
		Size = UDim2.fromOffset(
			Background.AbsoluteSize.X - LeftPanel.AbsoluteSize.X,
			Background.AbsoluteSize.Y - TopBar.AbsoluteSize.Y
		),
	}):Play()
	TweenService
		:Create(
			TopBar,
			TweenInfo.new(speed),
			{ Size = UDim2.fromOffset(Background.AbsoluteSize.X, TopBar.AbsoluteSize.Y) }
		)
		:Play()
	TweenService:Create(ScrollingFrame, TweenInfo.new(speed), {
		Size = UDim2.fromOffset(Background.AbsoluteSize.X - LeftPanel.AbsoluteSize.X, 110),
		Position = UDim2.fromOffset(0, Background.AbsoluteSize.Y - 119 - TopBar.AbsoluteSize.Y),
	}):Play()
	TweenService:Create(CodeBox, TweenInfo.new(speed), {
		Size = UDim2.fromOffset(
			Background.AbsoluteSize.X - LeftPanel.AbsoluteSize.X,
			Background.AbsoluteSize.Y - 119 - TopBar.AbsoluteSize.Y
		),
	}):Play()
	TweenService:Create(
		LogList,
		TweenInfo.new(speed),
		{ Size = UDim2.fromOffset(LogList.AbsoluteSize.X, Background.AbsoluteSize.Y - TopBar.AbsoluteSize.Y - 18) }
	):Play()
end

--- Minimize UI size.
function minimizeSize(speed)
	if not speed then
		speed = 0.05
	end
	TweenService:Create(
		LeftPanel,
		TweenInfo.new(speed),
		{ Size = UDim2.fromOffset(LeftPanel.AbsoluteSize.X, Background.AbsoluteSize.Y - TopBar.AbsoluteSize.Y) }
	):Play()
	TweenService:Create(
		RightPanel,
		TweenInfo.new(speed),
		{ Size = UDim2.fromOffset(0, Background.AbsoluteSize.Y - TopBar.AbsoluteSize.Y) }
	):Play()
	TweenService
		:Create(
			TopBar,
			TweenInfo.new(speed),
			{ Size = UDim2.fromOffset(LeftPanel.AbsoluteSize.X, TopBar.AbsoluteSize.Y) }
		)
		:Play()
	TweenService:Create(ScrollingFrame, TweenInfo.new(speed), {
		Size = UDim2.fromOffset(0, 119),
		Position = UDim2.fromOffset(0, Background.AbsoluteSize.Y - 119 - TopBar.AbsoluteSize.Y),
	}):Play()
	TweenService:Create(
		CodeBox,
		TweenInfo.new(speed),
		{ Size = UDim2.fromOffset(0, Background.AbsoluteSize.Y - 119 - TopBar.AbsoluteSize.Y) }
	):Play()
	TweenService:Create(
		LogList,
		TweenInfo.new(speed),
		{ Size = UDim2.fromOffset(LogList.AbsoluteSize.X, Background.AbsoluteSize.Y - TopBar.AbsoluteSize.Y - 18) }
	):Play()
end

--- Validate safe-zone boundaries.
function validateSize()
	local x, y = Background.AbsoluteSize.X, Background.AbsoluteSize.Y
	local screenSize = workspace.CurrentCamera.ViewportSize
	if x + Background.AbsolutePosition.X > screenSize.X then
		if screenSize.X - Background.AbsolutePosition.X >= 450 then
			x = screenSize.X - Background.AbsolutePosition.X
		else
			x = 450
		end
	elseif y + Background.AbsolutePosition.Y > screenSize.Y then
		if screenSize.X - Background.AbsolutePosition.Y >= 268 then
			y = screenSize.Y - Background.AbsolutePosition.Y
		else
			y = 268
		end
	end
	Background.Size = UDim2.fromOffset(x, y)
end

--- Function called while mouse is in range of UI.
--- @param input userdata
function backgroundUserInput(input)
	local mousePos = UserInputService:GetMouseLocation() - Vector2.new(0, 36)
	local inResizeRange, type = isInResizeRange(mousePos)
	if input.UserInputType == Enum.UserInputType.MouseButton1 and inResizeRange then
		local lastPos = UserInputService:GetMouseLocation()
		local offset = Background.AbsoluteSize - lastPos
		local currentPos = lastPos + offset
		RunService:BindToRenderStep("SIMPLESPY_RESIZE", 1, function()
			local newPos = UserInputService:GetMouseLocation()
			if newPos ~= lastPos then
				local currentX = (newPos + offset).X
				local currentY = (newPos + offset).Y
				if currentX < 450 then
					currentX = 450
				end
				if currentY < 268 then
					currentY = 268
				end
				currentPos = Vector2.new(currentX, currentY)
				Background.Size = UDim2.fromOffset(
					(not sideClosed and not closed and (type == "X" or type == "B")) and currentPos.X
						or Background.AbsoluteSize.X,
					(--[[(not sideClosed or currentPos.X <= LeftPanel.AbsolutePosition.X + LeftPanel.AbsoluteSize.X) and]]not closed and (type == "Y" or type == "B"))
							and currentPos.Y
						or Background.AbsoluteSize.Y
				)
				validateSize()
				if sideClosed then
					minimizeSize()
				else
					maximizeSize()
				end
				lastPos = newPos
			end
		end)
		table.insert(
			connections,
			UserInputService.InputEnded:Connect(function(inputE)
				if input == inputE then
					RunService:UnbindFromRenderStep("SIMPLESPY_RESIZE")
				end
			end)
		)
	elseif isInDragRange(mousePos) then
		onBarInput(input)
	end
end

--- Gets the player an instance is descended from
--- @param instance userdata
function getPlayerFromInstance(instance)
	for _, v in pairs(Players:GetPlayers()) do
		if v.Character and (instance:IsDescendantOf(v.Character) or instance == v.Character) then
			return v
		end
	end
end

--- Runs on MouseButton1Click of an event frame
--- @param frame userdata
function eventSelect(frame)
	if selected and selected.Log and selected.Log.Button then
		TweenService:Create(selected.Log.Button, TweenInfo.new(0.5), { BackgroundColor3 = Color3.fromRGB(0, 0, 0) })
			:Play()
		selected = nil
	end
	for _, v in pairs(logs) do
		if frame == v.Log then
			selected = v
		end
	end
	if selected and selected.Log then
		TweenService:Create(frame.Button, TweenInfo.new(0.5), { BackgroundColor3 = Color3.fromRGB(92, 126, 229) })
			:Play()
		codebox:setRaw(selected.GenScript)
	end
	if sideClosed then
		toggleSideTray()
	end
end

--- Updates the canvas size to fit the current amount of function buttons
function updateFunctionCanvas()
	ScrollingFrame.CanvasSize = UDim2.fromOffset(UIGridLayout.AbsoluteContentSize.X, UIGridLayout.AbsoluteContentSize.Y)
end

--- Updates the canvas size to fit the amount of current remotes
function updateRemoteCanvas()
	LogList.CanvasSize = UDim2.fromOffset(UIListLayout.AbsoluteContentSize.X, UIListLayout.AbsoluteContentSize.Y)
end

--- Allows for toggling of the tooltip and easy setting of le description
--- @param enable boolean
--- @param text string?
function makeToolTip(enable, text)
	if enable then
		if ToolTip.Visible then
			ToolTip.Visible = false
			RunService:UnbindFromRenderStep("ToolTip")
		end
		local first = true
		RunService:BindToRenderStep("ToolTip", 1, function()
			local topLeft = Vector2.new(Mouse.X + 20, Mouse.Y + 20)
			local bottomRight = topLeft + ToolTip.AbsoluteSize
			if topLeft.X < 0 then
				topLeft = Vector2.new(0, topLeft.Y)
			elseif bottomRight.X > workspace.CurrentCamera.ViewportSize.X then
				topLeft = Vector2.new(workspace.CurrentCamera.ViewportSize.X - ToolTip.AbsoluteSize.X, topLeft.Y)
			end
			if topLeft.Y < 0 then
				topLeft = Vector2.new(topLeft.X, 0)
			elseif bottomRight.Y > workspace.CurrentCamera.ViewportSize.Y - 35 then
				topLeft = Vector2.new(topLeft.X, workspace.CurrentCamera.ViewportSize.Y - ToolTip.AbsoluteSize.Y - 35)
			end
			if topLeft.X <= Mouse.X and topLeft.Y <= Mouse.Y then
				topLeft = Vector2.new(Mouse.X - ToolTip.AbsoluteSize.X - 2, Mouse.Y - ToolTip.AbsoluteSize.Y - 2)
			end
			if first then
				ToolTip.Position = UDim2.fromOffset(topLeft.X, topLeft.Y)
				first = false
			else
				ToolTip:TweenPosition(UDim2.fromOffset(topLeft.X, topLeft.Y), "Out", "Linear", 0.1)
			end
		end)
		TextLabel.Text = text or ""
		ToolTip.Visible = true
	else
		if ToolTip.Visible then
			ToolTip.Visible = false
			RunService:UnbindFromRenderStep("ToolTip")
		end
	end
end

--- Creates a new button.
--- @param name string
--- @param description function
--- @param onClick function
function newButton(name, description, onClick)
	local button = FunctionTemplate:Clone()
	button.Text.Text = name
	button.Button.MouseEnter:Connect(function()
		makeToolTip(true, description())
	end)
	button.Button.MouseLeave:Connect(function()
		makeToolTip(false)
	end)
	button.AncestryChanged:Connect(function()
		makeToolTip(false)
	end)
	button.Button.MouseButton1Click:Connect(function(...)
		onClick(button, ...)
	end)
	button.Parent = ScrollingFrame
	updateFunctionCanvas()
end

--- Generates a script from the provided arguments.
--- @param remote userdata The RemoteEvent or RemoteFunction in question.
--- @param args {} The arguments passed to `RemoteEvent:FireServer(...)` or `RemoteFunction:InvokeServer(...)`
function genScript(remote, args)
	prevTables = {}
	local gen = ""
	if #args > 0 then
		if not pcall(function()
			gen = v2v({ args = args }) .. "\n"
		end) then
			gen = gen
				.. "-- TableToString failure! Reverting to legacy functionality (results may vary)\nlocal args = {"
			if
				not pcall(function()
					for i, v in pairs(args) do
						if type(i) ~= "Instance" and type(i) ~= "userdata" then
							gen = gen .. "\n    [object] = "
						elseif type(i) == "string" then
							gen = gen .. '\n    ["' .. i .. '"] = '
						elseif type(i) == "userdata" and typeof(i) ~= "Instance" then
							gen = gen .. "\n    [" .. string.format("nil --[[%s]]", typeof(v)) .. ")] = "
						elseif type(i) == "userdata" then
							gen = gen .. "\n    [game." .. i:GetFullName() .. ")] = "
						end
						if type(v) ~= "Instance" and type(v) ~= "userdata" then
							gen = gen .. "object"
						elseif type(v) == "string" then
							gen = gen .. '"' .. v .. '"'
						elseif type(v) == "userdata" and typeof(v) ~= "Instance" then
							gen = gen .. string.format("nil --[[%s]]", typeof(v))
						elseif type(v) == "userdata" then
							gen = gen .. "game." .. v:GetFullName()
						end
					end
					gen = gen .. "\n}\n\n"
				end)
			then
				gen = gen .. "}\n-- Legacy tableToString failure! Unable to decompile."
			end
		end
		if not remote:IsDescendantOf(game) and not getnilrequired then
			gen = "function getNil(name, class) for i, v in pairs(getnilinstances()) do if typeof(v) == 'Instance' and v:IsA(class) and v.Name == name then return v; end; end;\n\n"
				.. gen
		end
		if remote:IsA("RemoteEvent") then
			gen = gen .. v2s(remote) .. ":FireServer(unpack(args))"
		elseif remote:IsA("RemoteFunction") then
			gen = gen .. v2s(remote) .. ":InvokeServer(unpack(args))"
		end
	else
		if remote:IsA("RemoteEvent") then
			gen = gen .. v2s(remote) .. ":FireServer()"
		elseif remote:IsA("RemoteFunction") then
			gen = gen .. v2s(remote) .. ":InvokeServer()"
		end
	end
	gen = "-- Script generated by SimpleSpy - credits to exx#9394\n\n" .. gen
	prevTables = {}
	return gen
end

--- Adds new Remote to logs
--- @param name string The name of the remote being logged
--- @param type string The type of the remote being logged (either 'function' or 'event')
--- @param args any
--- @param remote any
--- @param function_info string
--- @param blocked any
function newRemote(type, name, args, remote, function_info, blocked, src, returnValue)
	local remoteFrame = RemoteTemplate:Clone()
	remoteFrame.Text.Text = string.sub(name, 1, 50)
	remoteFrame.ColorBar.BackgroundColor3 = type == "event" and Color3.new(255, 242, 0) or Color3.fromRGB(99, 86, 245)
	local id = Instance.new("IntValue")
	id.Name = "ID"
	id.Value = #logs + 1
	id.Parent = remoteFrame
	local weakRemoteTable = setmetatable({ remote = remote }, { __mode = "v" })
	local log = {
		Name = name,
		Function = function_info,
		Remote = weakRemoteTable,
		Log = remoteFrame,
		Blocked = blocked,
		Source = src,
		GenScript = "-- Generating, please wait... (click to reload)\n-- (If this message persists, the remote args are likely extremely long)",
		ReturnValue = returnValue,
	}
	logs[#logs + 1] = log
	schedule(function()
		log.GenScript = genScript(remote, args)
		if blocked then
			logs[#logs].GenScript = "-- THIS REMOTE WAS PREVENTED FROM FIRING THE SERVER BY SIMPLESPY\n\n"
				.. logs[#logs].GenScript
		end
	end)
	local connect = remoteFrame.Button.MouseButton1Click:Connect(function()
		eventSelect(remoteFrame)
	end)
	if layoutOrderNum < 1 then
		layoutOrderNum = 999999999
	end
	remoteFrame.LayoutOrder = layoutOrderNum
	layoutOrderNum = layoutOrderNum - 1
	remoteFrame.Parent = LogList
	table.insert(remoteLogs, 1, { connect, remoteFrame })
	clean()
	updateRemoteCanvas()
end

--- value-to-string: value, string (out), level (indentation), parent table, var name, is from tovar

--- any-to-string function.<br/>
--- Attempts to convert values to string.
function v2s(v, l, p, n, vtv, i, pt, path, tables, tI)
	if not tI then
		tI = { 0 }
	else
		tI[1] = tI[1] + 1
	end
	if typeof(v) == "number" then
		if v == math.huge then
			return "math.huge"
		elseif v ~= v or tostring(v):match("nan") then
			return "0 / 0; --[=[ NaN ]=]"
		end
		return tostring(v)
	elseif typeof(v) == "boolean" then
		return tostring(v)
	elseif typeof(v) == "string" then
		return formatstr(v, l)
	elseif typeof(v) == "function" then
		return f2s(v)
	elseif typeof(v) == "table" then
		return t2s(v, l, p, n, vtv, i, pt, path, tables, tI)
	elseif typeof(v) == "Instance" then
		return i2p(v)
	elseif typeof(v) == "userdata" then
		return "newproxy(true)"
	elseif type(v) == "userdata" then
		return u2s(v)
	elseif type(v) == "vector" then
		return string.format("Vector3.new(%s, %s, %s)", v2s(v.X), v2s(v.Y), v2s(v.Z))
	else
		return "nil --[[" .. typeof(v) .. "]]"
	end
end

--- value-to-variable
--- @param t any
function v2v(t)
	topstr = ""
	bottomstr = ""
	getnilrequired = false
	local ret = ""
	local count = 1
	for i, v in pairs(t) do
		if type(i) == "string" and i:match("^[%a_]+[%w_]*$") then
			ret = ret .. "local " .. i .. " = " .. v2s(v, nil, nil, i, true) .. "\n"
		elseif tostring(i):match("^[%a_]+[%w_]*$") then
			ret = ret
				.. "local "
				.. tostring(i):lower()
				.. "_"
				.. tostring(count)
				.. " = "
				.. v2s(v, nil, nil, tostring(i):lower() .. "_" .. tostring(count), true)
				.. "\n"
		else
			ret = ret
				.. "local "
				.. type(v)
				.. "_"
				.. tostring(count)
				.. " = "
				.. v2s(v, nil, nil, type(v) .. "_" .. tostring(count), true)
				.. "\n"
		end
		count = count + 1
	end
	if getnilrequired then
		topstr = "function getNil(name,class) for _,v in pairs(getnilinstances())do if v.ClassName==class and v.Name==name then return v;end end end\n"
			.. topstr
	end
	if #topstr > 0 then
		ret = topstr .. "\n" .. ret
	end
	if #bottomstr > 0 then
		ret = ret .. bottomstr
	end
	return ret
end

--- table-to-string
--- @param t table
--- @param l number
--- @param p table
--- @param n string
--- @param vtv boolean
--- @param i any
--- @param pt table
--- @param path string
--- @param tables table
--- @param tI table
function t2s(t, l, p, n, vtv, i, pt, path, tables, tI)
	local globalIndex = table.find(getgenv(), t) -- checks if table is a global
	if type(globalIndex) == "string" then
		return globalIndex
	end
	if not tI then
		tI = { 0 }
	end
	if not path then -- sets path to empty string (so it doesn't have to manually provided every time)
		path = ""
	end
	if not l then -- sets the level to 0 (for indentation) and tables for logging tables it already serialized
		l = 0
		tables = {}
	end
	if not p then -- p is the previous table but doesn't really matter if it's the first
		p = t
	end
	for _, v in pairs(tables) do -- checks if the current table has been serialized before
		if n and rawequal(v, t) then
			bottomstr = bottomstr
				.. "\n"
				.. tostring(n)
				.. tostring(path)
				.. " = "
				.. tostring(n)
				.. tostring(({ v2p(v, p) })[2])
			return "{} --[[DUPLICATE]]"
		end
	end
	table.insert(tables, t) -- logs table to past tables
	local s = "{" -- start of serialization
	local size = 0
	l = l + indent -- set indentation level
	for k, v in pairs(t) do -- iterates over table
		size = size + 1 -- changes size for max limit
		if size > (environment.SimpleSpy.MaxTableSize or 1000) then
			s = s
				.. "\n"
				.. string.rep(" ", l)
				.. "-- MAXIMUM TABLE SIZE REACHED, CHANGE 'environment.SimpleSpy.MaxTableSize' TO ADJUST MAXIMUM SIZE "
			break
		end
		if rawequal(k, t) then -- checks if the table being iterated over is being used as an index within itself (yay, lua)
			bottomstr = bottomstr
				.. "\n"
				.. tostring(n)
				.. tostring(path)
				.. "["
				.. tostring(n)
				.. tostring(path)
				.. "]"
				.. " = "
				.. (
					rawequal(v, k) and tostring(n) .. tostring(path)
					or v2s(v, l, p, n, vtv, k, t, path .. "[" .. tostring(n) .. tostring(path) .. "]", tables)
				)
			size = size - 1
		else
			local currentPath = "" -- initializes the path of 'v' within 't'
			if type(k) == "string" and k:match("^[%a_]+[%w_]*$") then -- cleanly handles table path generation (for the first half)
				currentPath = "." .. k
			else
				currentPath = "[" .. k2s(k, l, p, n, vtv, k, t, path .. currentPath, tables, tI) .. "]"
			end
			if size % 100 == 0 then
				scheduleWait()
			end
			-- actually serializes the member of the table
			s = s
				.. "\n"
				.. string.rep(" ", l)
				.. "["
				.. k2s(k, l, p, n, vtv, k, t, path .. currentPath, tables, tI)
				.. "] = "
				.. v2s(v, l, p, n, vtv, k, t, path .. currentPath, tables, tI)
				.. ","
		end
	end
	if #s > 1 then -- removes the last comma because it looks nicer (no way to tell if it's done 'till it's done so...)
		s = s:sub(1, #s - 1)
	end
	if size > 0 then -- cleanly indents the last curly bracket
		s = s .. "\n" .. string.rep(" ", l - indent)
	end
	return s .. "}"
end

--- key-to-string
function k2s(v, ...)
	if keyToString then
		if typeof(v) == "userdata" and getrawmetatable(v) then
			return string.format(
				'"<void> (%s)" --[[Potentially hidden data (tostring in SimpleSpy:HookRemote/GetRemoteFiredSignal at your own risk)]]',
				safetostring(v)
			)
		elseif typeof(v) == "userdata" then
			return string.format('"<void> (%s)"', safetostring(v))
		elseif type(v) == "userdata" and typeof(v) ~= "Instance" then
			return string.format('"<%s> (%s)"', typeof(v), tostring(v))
		elseif type(v) == "function" then
			return string.format('"<Function> (%s)"', tostring(v))
		end
	end
	return v2s(v, ...)
end

--- function-to-string
function f2s(f)
	for k, x in pairs(getgenv()) do
		local isgucci, gpath
		if rawequal(x, f) then
			isgucci, gpath = true, ""
		elseif type(x) == "table" then
			isgucci, gpath = v2p(f, x)
		end
		if isgucci and type(k) ~= "function" then
			if type(k) == "string" and k:match("^[%a_]+[%w_]*$") then
				return k .. gpath
			else
				return "getgenv()[" .. v2s(k) .. "]" .. gpath
			end
		end
	end
	if funcEnabled and debug.getinfo(f).name:match("^[%a_]+[%w_]*$") then
		return "function()end --[[" .. debug.getinfo(f).name .. "]]"
	end
	return "function()end --[[" .. tostring(f) .. "]]"
end

--- instance-to-path
--- @param i userdata
function i2p(i)
	local player = getplayer(i)
	local parent = i
	local out = ""
	if parent == nil then
		return "nil"
	elseif player then
		while true do
			if parent and parent == player.Character then
				if player == Players.LocalPlayer then
					return 'game:GetService("Players").LocalPlayer.Character' .. out
				else
					return i2p(player) .. ".Character" .. out
				end
			else
				if parent.Name:match("[%a_]+[%w+]*") ~= parent.Name then
					out = ":FindFirstChild(" .. formatstr(parent.Name) .. ")" .. out
				else
					out = "." .. parent.Name .. out
				end
			end
			parent = parent.Parent
		end
	elseif parent ~= game then
		while true do
			if parent and parent.Parent == game then
				local service = game:FindService(parent.ClassName)
				if service then
					if parent.ClassName == "Workspace" then
						return "workspace" .. out
					else
						return 'game:GetService("' .. service.ClassName .. '")' .. out
					end
				else
					if parent.Name:match("[%a_]+[%w_]*") then
						return "game." .. parent.Name .. out
					else
						return "game:FindFirstChild(" .. formatstr(parent.Name) .. ")" .. out
					end
				end
			elseif parent.Parent == nil then
				getnilrequired = true
				return "getNil(" .. formatstr(parent.Name) .. ', "' .. parent.ClassName .. '")' .. out
			elseif parent == Players.LocalPlayer then
				out = ".LocalPlayer" .. out
			else
				if parent.Name:match("[%a_]+[%w_]*") ~= parent.Name then
					out = ":FindFirstChild(" .. formatstr(parent.Name) .. ")" .. out
				else
					out = "." .. parent.Name .. out
				end
			end
			parent = parent.Parent
		end
	else
		return "game"
	end
end

--- userdata-to-string: userdata
--- @param u userdata
function u2s(u)
	if typeof(u) == "TweenInfo" then
		-- TweenInfo
		return "TweenInfo.new("
			.. tostring(u.Time)
			.. ", Enum.EasingStyle."
			.. tostring(u.EasingStyle)
			.. ", Enum.EasingDirection."
			.. tostring(u.EasingDirection)
			.. ", "
			.. tostring(u.RepeatCount)
			.. ", "
			.. tostring(u.Reverses)
			.. ", "
			.. tostring(u.DelayTime)
			.. ")"
	elseif typeof(u) == "Ray" then
		-- Ray
		return "Ray.new(" .. u2s(u.Origin) .. ", " .. u2s(u.Direction) .. ")"
	elseif typeof(u) == "NumberSequence" then
		-- NumberSequence
		local ret = "NumberSequence.new("
		for i, v in pairs(u.KeyPoints) do
			ret = ret .. tostring(v)
			if i < #u.Keypoints then
				ret = ret .. ", "
			end
		end
		return ret .. ")"
	elseif typeof(u) == "DockWidgetPluginGuiInfo" then
		-- DockWidgetPluginGuiInfo
		return "DockWidgetPluginGuiInfo.new(Enum.InitialDockState" .. tostring(u) .. ")"
	elseif typeof(u) == "ColorSequence" then
		-- ColorSequence
		local ret = "ColorSequence.new("
		for i, v in pairs(u.KeyPoints) do
			ret = ret .. "Color3.new(" .. tostring(v) .. ")"
			if i < #u.Keypoints then
				ret = ret .. ", "
			end
		end
		return ret .. ")"
	elseif typeof(u) == "BrickColor" then
		-- BrickColor
		return "BrickColor.new(" .. tostring(u.Number) .. ")"
	elseif typeof(u) == "NumberRange" then
		-- NumberRange
		return "NumberRange.new(" .. tostring(u.Min) .. ", " .. tostring(u.Max) .. ")"
	elseif typeof(u) == "Region3" then
		-- Region3
		local center = u.CFrame.Position
		local size = u.CFrame.Size
		local vector1 = center - size / 2
		local vector2 = center + size / 2
		return "Region3.new(" .. u2s(vector1) .. ", " .. u2s(vector2) .. ")"
	elseif typeof(u) == "Faces" then
		-- Faces
		local faces = {}
		if u.Top then
			table.insert(faces, "Enum.NormalId.Top")
		end
		if u.Bottom then
			table.insert(faces, "Enum.NormalId.Bottom")
		end
		if u.Left then
			table.insert(faces, "Enum.NormalId.Left")
		end
		if u.Right then
			table.insert(faces, "Enum.NormalId.Right")
		end
		if u.Back then
			table.insert(faces, "Enum.NormalId.Back")
		end
		if u.Front then
			table.insert(faces, "Enum.NormalId.Front")
		end
		return "Faces.new(" .. table.concat(faces, ", ") .. ")"
	elseif typeof(u) == "EnumItem" then
		return tostring(u)
	elseif typeof(u) == "Enums" then
		return "Enum"
	elseif typeof(u) == "Enum" then
		return "Enum." .. tostring(u)
	elseif typeof(u) == "RBXScriptSignal" then
		return "nil --[[RBXScriptSignal]]"
	elseif typeof(u) == "Vector3" then
		return string.format("Vector3.new(%s, %s, %s)", v2s(u.X), v2s(u.Y), v2s(u.Z))
	elseif typeof(u) == "CFrame" then
		local xAngle, yAngle, zAngle = u:ToEulerAnglesXYZ()
		return string.format(
			"CFrame.new(%s, %s, %s) * CFrame.Angles(%s, %s, %s)",
			v2s(u.X),
			v2s(u.Y),
			v2s(u.Z),
			v2s(xAngle),
			v2s(yAngle),
			v2s(zAngle)
		)
	elseif typeof(u) == "DockWidgetPluginGuiInfo" then
		return string.format(
			"DockWidgetPluginGuiInfo(%s, %s, %s, %s, %s, %s, %s)",
			"Enum.InitialDockState.Right",
			v2s(u.InitialEnabled),
			v2s(u.InitialEnabledShouldOverrideRestore),
			v2s(u.FloatingXSize),
			v2s(u.FloatingYSize),
			v2s(u.MinWidth),
			v2s(u.MinHeight)
		)
	elseif typeof(u) == "PathWaypoint" then
		return string.format("PathWaypoint.new(%s, %s)", v2s(u.Position), v2s(u.Action))
	elseif typeof(u) == "UDim" then
		return string.format("UDim.new(%s, %s)", v2s(u.Scale), v2s(u.Offset))
	elseif typeof(u) == "UDim2" then
		return string.format(
			"UDim2.new(%s, %s, %s, %s)",
			v2s(u.X.Scale),
			v2s(u.X.Offset),
			v2s(u.Y.Scale),
			v2s(u.Y.Offset)
		)
	elseif typeof(u) == "Rect" then
		return string.format("Rect.new(%s, %s)", v2s(u.Min), v2s(u.Max))
	else
		return string.format("nil --[[%s]]", typeof(u))
	end
end

--- Gets the player an instance is descended from
function getplayer(instance)
	for _, v in pairs(Players:GetPlayers()) do
		if v.Character and (instance:IsDescendantOf(v.Character) or instance == v.Character) then
			return v
		end
	end
end

--- value-to-path (in table)
function v2p(x, t, path, prev)
	if not path then
		path = ""
	end
	if not prev then
		prev = {}
	end
	if rawequal(x, t) then
		return true, ""
	end
	for i, v in pairs(t) do
		if rawequal(v, x) then
			if type(i) == "string" and i:match("^[%a_]+[%w_]*$") then
				return true, (path .. "." .. i)
			else
				return true, (path .. "[" .. v2s(i) .. "]")
			end
		end
		if type(v) == "table" then
			local duplicate = false
			for _, y in pairs(prev) do
				if rawequal(y, v) then
					duplicate = true
				end
			end
			if not duplicate then
				table.insert(prev, t)
				local found
				found, p = v2p(x, v, path, prev)
				if found then
					if type(i) == "string" and i:match("^[%a_]+[%w_]*$") then
						return true, "." .. i .. p
					else
						return true, "[" .. v2s(i) .. "]" .. p
					end
				end
			end
		end
	end
	return false, ""
end

--- format s: string, byte encrypt (for weird symbols)
function formatstr(s, indentation)
	if not indentation then
		indentation = 0
	end
	local handled, reachedMax = handlespecials(s, indentation)
	return '"'
		.. handled
		.. '"'
		.. (
			reachedMax
				and " --[[ MAXIMUM STRING SIZE REACHED, CHANGE 'environment.SimpleSpy.MaxStringSize' TO ADJUST MAXIMUM SIZE ]]"
			or ""
		)
end

--- Adds \'s to the text as a replacement to whitespace chars and other things because string.format can't yayeet
function handlespecials(value, indentation)
	local buildStr = {}
	local i = 1
	local char = string.sub(value, i, i)
	local indentStr
	while char ~= "" do
		if char == '"' then
			buildStr[i] = '\\"'
		elseif char == "\\" then
			buildStr[i] = "\\\\"
		elseif char == "\n" then
			buildStr[i] = "\\n"
		elseif char == "\t" then
			buildStr[i] = "\\t"
		elseif string.byte(char) > 126 or string.byte(char) < 32 then
			buildStr[i] = string.format("\\%d", string.byte(char))
		else
			buildStr[i] = char
		end
		i = i + 1
		char = string.sub(value, i, i)
		if i % 200 == 0 then
			indentStr = indentStr or string.rep(" ", indentation + indent)
			table.move({ '"\n', indentStr, '... "' }, 1, 3, i, buildStr)
			i += 3
		end
	end
	return table.concat(buildStr), false
end

-- safe (ish) tostring
function safetostring(v: any)
	if typeof(v) == "userdata" or type(v) == "table" then
		local mt = getrawmetatable(v)
		local badtostring = mt and rawget(mt, "__tostring")
		if mt and badtostring then
			rawset(mt, "__tostring", nil)
			local out = tostring(v)
			rawset(mt, "__tostring", badtostring)
			return out
		end
	end
	return tostring(v)
end

--- finds script from 'src' from getinfo, returns nil if not found
--- @param src string
function getScriptFromSrc(src)
	local realPath
	local runningTest
	--- @type number
	local s, e
	local match = false
	if src:sub(1, 1) == "=" then
		realPath = game
		s = 2
	else
		runningTest = src:sub(2, e and e - 1 or -1)
		for _, v in pairs(getnilinstances()) do
			if v.Name == runningTest then
				realPath = v
				break
			end
		end
		s = #runningTest + 1
	end
	if realPath then
		e = src:sub(s, -1):find("%.")
		local i = 0
		repeat
			i += 1
			if not e then
				runningTest = src:sub(s, -1)
				local test = realPath.FindFirstChild(realPath, runningTest)
				if test then
					realPath = test
				end
				match = true
			else
				runningTest = src:sub(s, e)
				local test = realPath.FindFirstChild(realPath, runningTest)
				local yeOld = e
				if test then
					realPath = test
					s = e + 2
					e = src:sub(e + 2, -1):find("%.")
					e = e and e + yeOld or e
				else
					e = src:sub(e + 2, -1):find("%.")
					e = e and e + yeOld or e
				end
			end
		until match or i >= 50
	end
	return realPath
end

--- schedules the provided function (and calls it with any args after)
function schedule(f, ...)
	table.insert(scheduled, { f, ... })
end

--- yields the current thread until the scheduler gives the ok
function scheduleWait()
	local thread = coroutine.running()
	schedule(function()
		coroutine.resume(thread)
	end)
	coroutine.yield()
end

--- the big (well tbh small now) boi task scheduler himself, handles p much anything as quicc as possible
function taskscheduler()
	if not toggle then
		scheduled = {}
		return
	end
	if #scheduled > 1000 then
		table.remove(scheduled, #scheduled)
	end
	if #scheduled > 0 then
		local currentf = scheduled[1]
		table.remove(scheduled, 1)
		if type(currentf) == "table" and type(currentf[1]) == "function" then
			pcall(unpack(currentf))
		end
	end
end

--- Handles remote logs
function remoteHandler(hookfunction, methodName, remote, args, funcInfo, calling, returnValue)
	local validInstance, validClass = pcall(function()
		return remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction")
	end)
	if validInstance and validClass then
		local func = funcInfo.func
		if not calling then
			_, calling = pcall(getScriptFromSrc, funcInfo.source)
		end
		coroutine.wrap(function()
			if remoteSignals[remote] then
				remoteSignals[remote]:Fire(args)
			end
		end)()
		if autoblock then
			if excluding[remote] then
				return
			end
			if not history[remote] then
				history[remote] = { badOccurances = 0, lastCall = tick() }
			end
			if tick() - history[remote].lastCall < 1 then
				history[remote].badOccurances += 1
				return
			else
				history[remote].badOccurances = 0
			end
			if history[remote].badOccurances > 3 then
				excluding[remote] = true
				return
			end
			history[remote].lastCall = tick()
		end
		local functionInfoStr
		local src
		if func and islclosure(func) then
			local functionInfo = {}
			functionInfo.info = funcInfo
			pcall(function()
				functionInfo.constants = debug.getconstants(func)
			end)
			pcall(function()
				functionInfoStr = v2v({ functionInfo = functionInfo })
			end)
			pcall(function()
				if type(calling) == "userdata" then
					src = calling
				end
			end)
		end
		if methodName:lower() == "fireserver" then
			newRemote(
				"event",
				remote.Name,
				args,
				remote,
				functionInfoStr,
				(blocklist[remote] or blocklist[remote.Name]),
				src
			)
		elseif methodName:lower() == "invokeserver" then
			newRemote(
				"function",
				remote.Name,
				args,
				remote,
				functionInfoStr,
				(blocklist[remote] or blocklist[remote.Name]),
				src,
				returnValue
			)
		end
	end
end

--- Used for hookfunction
function hookRemote(remoteType, remote, ...)
	if typeof(remote) == "Instance" then
		local args = { ... }
		local validInstance, remoteName = pcall(function()
			return remote.Name
		end)
		if validInstance and not (blacklist[remote] or blacklist[remoteName]) then
			local funcInfo = {}
			local calling
			if funcEnabled then
				funcInfo = debug.getinfo(4) or funcInfo
				calling = useGetCallingScript and getcallingscript() or nil
			end
			if recordReturnValues and remoteType == "RemoteFunction" then
				local thread = coroutine.running()
				local args = { ... }
				task.defer(function()
					local returnValue
					if remoteHooks[remote] then
						args = { remoteHooks[remote](unpack(args)) }
						returnValue = originalFunction(remote, unpack(args))
					else
						returnValue = originalFunction(remote, unpack(args))
					end
					schedule(
						remoteHandler,
						true,
						remoteType == "RemoteEvent" and "fireserver" or "invokeserver",
						remote,
						args,
						funcInfo,
						calling,
						returnValue
					)
					if blocklist[remote] or blocklist[remoteName] then
						coroutine.resume(thread)
					else
						coroutine.resume(thread, unpack(returnValue))
					end
				end)
			else
				schedule(
					remoteHandler,
					true,
					remoteType == "RemoteEvent" and "fireserver" or "invokeserver",
					remote,
					args,
					funcInfo,
					calling
				)
				if blocklist[remote] or blocklist[remoteName] then
					return
				end
			end
		end
	end
	if recordReturnValues and remoteType == "RemoteFunction" then
		return coroutine.yield()
	elseif remoteType == "RemoteEvent" then
		if remoteHooks[remote] then
			return originalEvent(remote, remoteHooks[remote](...))
		end
		return originalEvent(remote, ...)
	else
		if remoteHooks[remote] then
			return originalFunction(remote, remoteHooks[remote](...))
		end
		return originalFunction(remote, ...)
	end
end

local newnamecall = newcclosure(function(remote, ...)
	if typeof(remote) == "Instance" then
		local args = { ... }
		local methodName = getnamecallmethod()
		local validInstance, remoteName = pcall(function()
			return remote.Name
		end)
		if
			validInstance
			and (methodName == "FireServer" or methodName == "fireServer" or methodName == "InvokeServer" or methodName == "invokeServer")
			and not (blacklist[remote] or blacklist[remoteName])
		then
			local funcInfo = {}
			local calling
			if funcEnabled then
				funcInfo = debug.getinfo(3) or funcInfo
				calling = useGetCallingScript and getcallingscript() or nil
			end
			if recordReturnValues and (methodName == "InvokeServer" or methodName == "invokeServer") then
				local namecallThread = coroutine.running()
				local args = { ... }
				task.defer(function()
					local returnValue
					setnamecallmethod(methodName)
					if remoteHooks[remote] then
						args = { remoteHooks[remote](unpack(args)) }
						returnValue = { original(remote, unpack(args)) }
					else
						returnValue = { original(remote, unpack(args)) }
					end
					coroutine.resume(namecallThread, unpack(returnValue))
					coroutine.wrap(function()
						schedule(remoteHandler, false, methodName, remote, args, funcInfo, calling, returnValue)
					end)()
				end)
			else
				coroutine.wrap(function()
					schedule(remoteHandler, false, methodName, remote, args, funcInfo, calling)
				end)()
			end
		end
		if recordReturnValues and (methodName == "InvokeServer" or methodName == "invokeServer") then
			return coroutine.yield()
		elseif
			validInstance
			and (methodName == "FireServer" or methodName == "fireServer" or methodName == "InvokeServer" or methodName == "invokeServer")
			and (blocklist[remote] or blocklist[remoteName])
		then
			return nil
		elseif
			(not recordReturnValues or methodName ~= "InvokeServer" or methodName ~= "invokeServer")
			and validInstance
			and (methodName == "FireServer" or methodName == "fireServer" or methodName == "InvokeServer" or methodName == "invokeServer")
			and remoteHooks[remote]
		then
			return original(remote, remoteHooks[remote](...))
		else
			return original(remote, ...)
		end
	end
	return original(remote, ...)
end, original)

local newFireServer = newcclosure(function(...)
	return hookRemote("RemoteEvent", ...)
end, originalEvent)

local newInvokeServer = newcclosure(function(...)
	return hookRemote("RemoteFunction", ...)
end, originalFunction)

--- Toggles on and off the remote spy
function toggleSpy()
	if not toggle then
		if hookmetamethod then
			local oldNamecall = hookmetamethod(game, "__namecall", newnamecall)
			original = original or function(...)
				return oldNamecall(...)
			end
		else
			gm = gm or getrawmetatable(game)
			original = original or function(...)
				return gm.__namecall(...)
			end
			setreadonly(gm, false)
			if not original then
				warn("SimpleSpy: namecall method not found!")
				onToggleButtonClick()
				return
			end
			gm.__namecall = newnamecall
			setreadonly(gm, true)
		end
		originalEvent = hookfunction(remoteEvent.FireServer, newFireServer)
		originalFunction = hookfunction(remoteFunction.InvokeServer, newInvokeServer)
	else
		if hookmetamethod then
			if original then
				hookmetamethod(game, "__namecall", original)
			end
		else
			gm = gm or getrawmetatable(game)
			setreadonly(gm, false)
			gm.__namecall = original
			setreadonly(gm, true)
		end
		hookfunction(remoteEvent.FireServer, originalEvent)
		hookfunction(remoteFunction.InvokeServer, originalFunction)
	end
end

--- Toggles between the two remotespy methods (hookfunction currently = disabled)
function toggleSpyMethod()
	toggleSpy()
	toggle = not toggle
end

--- Shuts down the remote spy
function shutdown()
	if schedulerconnect then
		schedulerconnect:Disconnect()
	end
	for _, connection in pairs(connections) do
		coroutine.wrap(function()
			connection:Disconnect()
		end)()
	end
	SimpleSpy2:Destroy()
	hookfunction(remoteEvent.FireServer, originalEvent)
	hookfunction(remoteFunction.InvokeServer, originalFunction)
	if hookmetamethod then
		if original then
			hookmetamethod(game, "__namecall", original)
		end
	else
		gm = gm or getrawmetatable(game)
		setreadonly(gm, false)
		gm.__namecall = original
		setreadonly(gm, true)
	end
	environment.SimpleSpyExecuted = false
end

-- main
if not environment.SimpleSpyExecuted then
	local succeeded, err = pcall(function()
		if not RunService:IsClient() then
			error("SimpleSpy cannot run on the server!")
		end
		if
			not hookfunction
			or not getrawmetatable
			or getrawmetatable and not getrawmetatable(game).__namecall
			or not setreadonly
		then
			local missing = {}
			if not hookfunction then
				table.insert(missing, "hookfunction")
			end
			if not getrawmetatable then
				table.insert(missing, "getrawmetatable")
			end
			if getrawmetatable and not getrawmetatable(game).__namecall then
				table.insert(missing, "getrawmetatable(game).__namecall")
			end
			if not setreadonly then
				table.insert(missing, "setreadonly")
			end
			shutdown()
			error(
				"This environment does not support method hooks!\n(Your exploit is not capable of running SimpleSpy)\nMissing: "
					.. table.concat(missing, ", ")
			)
		end
		environment.SimpleSpyShutdown = shutdown
		ContentProvider:PreloadAsync({
			"rbxassetid://6065821980",
			"rbxassetid://6065774948",
			"rbxassetid://6065821086",
			"rbxassetid://6065821596",
			ImageLabel,
			ImageLabel_2,
			ImageLabel_3,
		})
		-- if gethui then funcEnabled = false end
		onToggleButtonClick()
		RemoteTemplate.Parent = nil
		FunctionTemplate.Parent = nil
		codebox = Highlight.new()
		codebox:init(CodeBox)
		codebox:setRaw("")
		TextLabel:GetPropertyChangedSignal("Text"):Connect(scaleToolTip)
		-- TopBar.InputBegan:Connect(onBarInput)
		MinimizeButton.MouseButton1Click:Connect(toggleMinimize)
		MaximizeButton.MouseButton1Click:Connect(toggleSideTray)
		Simple.MouseButton1Click:Connect(onToggleButtonClick)
		CloseButton.MouseEnter:Connect(onXButtonHover)
		CloseButton.MouseLeave:Connect(onXButtonUnhover)
		Simple.MouseEnter:Connect(onToggleButtonHover)
		Simple.MouseLeave:Connect(onToggleButtonUnhover)
		CloseButton.MouseButton1Click:Connect(shutdown)
		table.insert(connections, UserInputService.InputBegan:Connect(backgroundUserInput))
		connectResize()
		SimpleSpy2.Enabled = true
		coroutine.wrap(function()
			wait(1)
			onToggleButtonUnhover()
		end)()
		schedulerconnect = RunService.Heartbeat:Connect(taskscheduler)
		if syn and syn.protect_gui then
			pcall(syn.protect_gui, SimpleSpy2)
		end
		bringBackOnResize()
		SimpleSpy2.Parent = --[[gethui and gethui() or]]
			CoreGui
		environment.SimpleSpyExecuted = true
		if not Players.LocalPlayer then
			Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
		end
		Mouse = Players.LocalPlayer:GetMouse()
		oldIcon = Mouse.Icon
		table.insert(connections, Mouse.Move:Connect(mouseMoved))
	end)
	if not succeeded then
		warn(
			"A fatal error has occured, SimpleSpy was unable to launch properly.\nPlease DM this error message to @exx#9394:\n\n"
				.. tostring(err)
		)
		SimpleSpy2:Destroy()
		hookfunction(remoteEvent.FireServer, originalEvent)
		hookfunction(remoteFunction.InvokeServer, originalFunction)
		if hookmetamethod then
			if original then
				hookmetamethod(game, "__namecall", original)
			end
		else
			setreadonly(gm, false)
			gm.__namecall = original
			setreadonly(gm, true)
		end
		return
	end
else
	SimpleSpy2:Destroy()
	return
end

--- The function that creates buttons.<br/><br/>
function CreateButtons()
	if type(setclipboard) == "function" then
		--#region
		--- Self-explanatory
		newButton("Copy Code", function()
			return "Click to copy code"
		end, function()
			TextLabel.Text = "Copying..."
			if pcall(setclipboard, codebox:getString()) == true then
				TextLabel.Text = "Copied to clipboard"
			else
				TextLabel.Text = "Failed to copy"
			end
		end)
		--#region
		--- Self-explanatory
		newButton("Copy Remote", function()
			return "Copy the remote's path"
		end, function()
			if selected then
				if pcall(setclipboard(v2s(selected.Remote.remote))) then
					TextLabel.Text = "Copied to clipboard"
				else
					TextLabel.Text = "Failed to copy"
				end
			end
		end)
		--#endregion
		--#region
		--- Retrieve calling script
		newButton("Get Script", function()
			return "Click to copy calling script to clipboard\nWARNING: Not super reliable, nil == could not find"
		end, function()
			if selected then
				setclipboard(SimpleSpy:ValueToString(selected.Source))
				TextLabel.Text = "Done!"
			end
		end)
		--#endregion
	end
	--#endregion
	--#region
	--- Execute the code preview (if loadstring is available)
	newButton("Run Code", function()
		return "Click to execute code"
	end, function()
		local orText = "Click to execute code"
		TextLabel.Text = "Executing..."
		local f = pcall(loadstring, codebox:getString())
		if type(f) == "function" and pcall(f) == true then
			TextLabel.Text = "Loadstring successful"
		else
			TextLabel.Text = "Failed to execute"
		end
	end)
	--#endregion
	--#region
	--- Decompiles the script that fired the remote and outputs into code preview
	newButton("Function Info", function()
		return "Click to view calling function information"
	end, function()
		if selected then
			if selected.Function then
				codebox:setRaw(
					"-- Calling function info\n-- Generated by the SimpleSpy serializer\n\n"
						.. tostring(selected.Function)
				)
			end
			TextLabel.Text = "Done! Function info generated by the SimpleSpy Serializer."
		end
	end)
	--#endregion
	--#region
	--- Self-explanatory
	newButton("Clr Logs", function()
		return "Click to clear logs"
	end, function()
		TextLabel.Text = "Clearing..."
		logs = {}
		for _, v in pairs(LogList:GetChildren()) do
			if not v:IsA("UIListLayout") then
				v:Destroy()
			end
		end
		codebox:setRaw("")
		selected = nil
		TextLabel.Text = "Logs cleared!"
	end)
	--#endregion
	--#region
	--- Excludes the selected.Log Remote from the RemoteSpy
	newButton("Exclude (i)", function()
		return "Click to exclude this Remote.\nExcluding a remote makes SimpleSpy ignore it, but it will continue to be usable."
	end, function()
		if selected then
			blacklist[selected.Remote.remote] = true
			TextLabel.Text = "Excluded!"
		end
	end)
	--#endregion
	--#region
	--- Excludes all Remotes that share the same name as the selected.Log remote from the RemoteSpy
	newButton("Exclude (n)", function()
		return "Click to exclude all remotes with this name.\nExcluding a remote makes SimpleSpy ignore it, but it will continue to be usable."
	end, function()
		if selected then
			blacklist[selected.Name] = true
			TextLabel.Text = "Excluded!"
		end
	end)
	--#endregion
	--#region
	--- clears blacklist
	newButton("Clr Blacklist", function()
		return "Click to clear the blacklist.\nExcluding a remote makes SimpleSpy ignore it, but it will continue to be usable."
	end, function()
		blacklist = {}
		TextLabel.Text = "Blacklist cleared!"
	end)
	--#endregion
	--#region
	--- Prevents the selected.Log Remote from firing the server (still logged)
	newButton("Block (i)", function()
		return "Click to stop this remote from firing.\nBlocking a remote won't remove it from SimpleSpy logs, but it will not continue to fire the server."
	end, function()
		if selected then
			if selected.Remote.remote then
				blocklist[selected.Remote.remote] = true
				TextLabel.Text = "Excluded!"
			else
				TextLabel.Text = "Error! Instance may no longer exist, try using Block (n)."
			end
		end
	end)
	--#endregion
	--#region
	--- Prevents all remotes from firing that share the same name as the selected.Log remote from the RemoteSpy (still logged)
	newButton("Block (n)", function()
		return "Click to stop remotes with this name from firing.\nBlocking a remote won't remove it from SimpleSpy logs, but it will not continue to fire the server."
	end, function()
		if selected then
			blocklist[selected.Name] = true
			TextLabel.Text = "Excluded!"
		end
	end)
	--#endregion
	--#region
	--- Empties list of blocked remotes.
	newButton("Clr Blocklist", function()
		return "Click to stop blocking remotes.\nBlocking a remote won't remove it from SimpleSpy logs, but it will not continue to fire the server."
	end, function()
		blocklist = {}
		TextLabel.Text = "Blocklist cleared!"
	end)
	--#endregion
	--#region
	--- Attempts to decompile the source script
	newButton("Decompile", function()
		return "Attempts to decompile source script\nWARNING: Not super reliable, nil == could not find"
	end, function()
		if selected then
			if selected.Source then
				codebox:setRaw(decompile(selected.Source))
				TextLabel.Text = "Done!"
			else
				TextLabel.Text = "Source not found!"
			end
		end
	end)
	--#endregion
	--#region
	newButton("Disable Info", function()
		return string.format(
			"[%s] Toggle function info (because it can cause lag in some games)",
			funcEnabled and "ENABLED" or "DISABLED"
		)
	end, function()
		funcEnabled = not funcEnabled
		TextLabel.Text = string.format(
			"[%s] Toggle function info (because it can cause lag in some games)",
			funcEnabled and "ENABLED" or "DISABLED"
		)
	end)
	--#endregion
	--#region
	newButton("Autoblock", function()
		return string.format(
			"[%s] [BETA] Intelligently detects and excludes spammy remote calls from logs",
			autoblock and "ENABLED" or "DISABLED"
		)
	end, function()
		autoblock = not autoblock
		TextLabel.Text = string.format(
			"[%s] [BETA] Intelligently detects and excludes spammy remote calls from logs",
			autoblock and "ENABLED" or "DISABLED"
		)
		history = {}
		excluding = {}
	end)
	--#endregion
	--#region
	newButton("CallingScript", function()
		return string.format(
			"[%s] [UNSAFE] Uses 'getcallingscript' to get calling script for Decompile and GetScript. Much more reliable, but opens up SimpleSpy to detection and/or instability.",
			useGetCallingScript and "ENABLED" or "DISABLED"
		)
	end, function()
		useGetCallingScript = not useGetCallingScript
		TextLabel.Text = string.format(
			"[%s] [UNSAFE] Uses 'getcallingscript' to get calling script for Decompile and GetScript. Much more reliable, but opens up SimpleSpy to detection and/or instability.",
			useGetCallingScript and "ENABLED" or "DISABLED"
		)
	end)
	--#endregion
	--#region
	newButton("KeyToString", function()
		return string.format(
			"[%s] [BETA] Uses an experimental new function to replicate Roblox's behavior when a non-primitive type is used as a key in a table. Still in development and may not properly reflect tostringed (empty) userdata.",
			keyToString and "ENABLED" or "DISABLED"
		)
	end, function()
		keyToString = not keyToString
		TextLabel.Text = string.format(
			"[%s] [BETA] Uses an experimental new function to replicate Roblox's behavior when a non-primitive type is used as a key in a table. Still in development and may not properly reflect tostringed (empty) userdata.",
			keyToString and "ENABLED" or "DISABLED"
		)
	end)
	--#endregion
	--#region
	newButton("ToggleReturnValues", function()
		return string.format(
			"[%s] [EXPERIMENTAL] Enables recording of return values for 'GetReturnValue'\n\nUse this method at your own risk, as it could be detectable.",
			recordReturnValues and "ENABLED" or "DISABLED"
		)
	end, function()
		recordReturnValues = not recordReturnValues
		TextLabel.Text = string.format(
			"[%s] [EXPERIMENTAL] Enables recording of return values for 'GetReturnValue'\n\nUse this method at your own risk, as it could be detectable.",
			recordReturnValues and "ENABLED" or "DISABLED"
		)
	end)
	--#endregion
	--#region
	newButton("GetReturnValue", function()
		return "[Experimental] If 'ReturnValues' is enabled, this will show the recorded return value for the RemoteFunction (if available)."
	end, function()
		if selected then
			codebox:setRaw(SimpleSpy:ValueToVar(selected.ReturnValue, "returnValue"))
		end
	end)
	--#endregion
end

return CreateButtons()
