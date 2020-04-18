--[[
    higlight.lua v0.0.1 by exxtremewa#9394
    
    Features:
     - uses the power of fancy syntax detection algorithms to convert a frame into a syntax highlighted high quality code box
     - is cool
]]

local TextService = game:GetService("TextService")
--- The Highlight class
--- @class Highlight
local Highlight = {}

-- PRIVATE METHODS/PROPERTIES --

--[[
    Char Object:
    {
        Char: string -- A single character
        Color: Color3 -- The intended color of the char
        Line: number -- The line number
    }
]]

local parentFrame
local scrollingFrame
local textFrame
local lineNumbersFrame
local lines = {}

--- Contents of the table- array of char objects
local tableContents = {}

--- Whether or not the previous line had an unfinished string
local continuingString = false

local lineSpace = 15

local backgroundColor = Color3.fromRGB(40, 44, 52)
local operatorColor = Color3.fromRGB(187, 85, 255)
local functionColor = Color3.fromRGB(97, 175, 239)
local stringColor = Color3.fromRGB(152, 195, 121)
local numberColor = Color3.fromRGB(209, 154, 102)
local booleanColor = numberColor
local objectColor = Color3.fromRGB(229, 192, 123)
local defaultColor = Color3.fromRGB(224, 67, 78)
local commentColor = Color3.fromRGB(148, 148, 148)
local lineNumberColor = commentColor
local genericColor = Color3.fromRGB(240, 240, 240)

local operators = {"^(function)[^%w_]", "^(local)[^%w_]", "^(if)[^%w_]", "^(for)[^%w_]", "^(while)[^%w_]", "^(then)[^%w_]", "^(do)[^%w_]", "^(else)[^%w_]", "^(elseif)[^%w_]", "^(return)[^%w_]", "^(end)[^%w_]", "^(continue)[^%w_]", "[^%w_](continue)[^%w_]", "[^%w_](function)[^%w_]", "[^%w_](local)[^%w_]", "[^%w_](if)[^%w_]", "[^%w_](for)[^%w_]", "[^%w_](while)[^%w_]", "[^%w_](then)[^%w_]", "[^%w_](do)[^%w_]", "[^%w_](else)[^%w_]", "[^%w_](elseif)[^%w_]", "[^%w_](return)[^%w_]", "[^%w_](end)[^%w_]", "=", ">", "~", "<", "%-", "%+", "=", "%*"}
--- In this case, patterns could not be used, so just the string characters are provided
local strings = {'"', "'"}
local comments = {"%-%-%[%[[^%]%]]+%]?%]?", "(%-%-[^\n]+)"}
local functions = {"[^%w_]([%a_][%a%d_]*)%s*%(", "^([%a_][%a%d_]*)%s*%(", "[:%.%(%[%p]([%a_][%a%d_]*)%s*%("}
local numbers = {"[^%w_](%d+e?%d*)", "[^%w_](%.%d+e?%d*)", "[^%w_](%d+%.%d+e?%d*)", "^(%d+e?%d*)", "^(%.%d+e?%d*)", "^(%d+%.%d+e?%d*)"}
local booleans = {"[^%w_](true)", "^(true)", "[^%w_](false)", "^(false)", "[^%w_](nil)", "^(nil)"}
local objects = {"[^%w_:]([%a_][%a%d_]*):", "^([%a_][%a%d_]*):"}
local other = {"[^_%s%w]"}
local offLimits = {}

--- Determines if index is in a string
function isOffLimits(index)
    for _, v in pairs(offLimits) do
        if index >= v[1] and index <= v[2] then
            return true
        end
    end
    return false
end

--- Find iterator
function gfind(str, pattern)
    local start = 0
    return function()
        local findStart, findEnd = str:find(pattern, start)
        if findStart and findEnd ~= #str then
            start = findEnd + 1
            return findStart, findEnd
        else
            return nil
        end
    end
end

--- Finds and highlights comments with `commentColor`
function renderComments() 
    local str = Highlight:getRaw()
    for _, pattern in pairs(comments) do
        for commentStart, commentEnd in gfind(str, pattern) do
            if not isOffLimits(commentStart) then
                for i = commentStart, commentEnd do
                    table.insert(offLimits, {commentStart, commentEnd})
                    if tableContents[i] then
                        tableContents[i].Color = commentColor
                    end
                end
            end
        end
    end
end

-- Finds and highlights strings with `stringColor`
function renderStrings()
    local stringType = nil
    local stringStart
    local stringEnd
    local skip = false
    for i, char in pairs(tableContents) do
        if stringType then
            char.Color = stringColor
            if char.Char == stringType and tableContents[i - 1].Char ~= "\\" then
                skip = true
                stringType = nil
                stringEnd = i
                table.insert(offLimits, {stringStart, stringEnd})
            end
        end
        if not skip then
            for _, v in pairs(strings) do
                if char.Char == v and not isOffLimits(i) then
                    stringType = v
                    char.Color = stringColor
                    stringStart = i
                end
            end
        end
        skip = false
    end
end

--- Highlights the specified patterns with the specified color
--- @param patternArray string[]
---@param color userdata
function highlightPattern(patternArray, color)
    local str = Highlight:getRaw()
    for _, pattern in pairs(patternArray) do
        for findStart, findEnd in gfind(str, pattern) do
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

--- Main function for syntax highlighting tableContents
function render()
    offLimits = {}
    lines = {}
    textFrame:ClearAllChildren()
    lineNumbersFrame:ClearAllChildren()

    renderComments()
    renderStrings()
    highlightPattern(functions, functionColor)
    highlightPattern(numbers, numberColor)
    highlightPattern(operators, operatorColor)
    highlightPattern(objects, objectColor)
    highlightPattern(booleans, booleanColor)
    highlightPattern(other, genericColor)

    for i = 1, #tableContents do
        local v = tableContents[i]
        local textBox = Instance.new("TextLabel")
        local size = TextService:GetTextSize(v.Char, 14, Enum.Font.Arial, Vector2.new(math.huge, math.huge))
        local lineSizeX = 0
        if not lines[v.Line] then
            lines[v.Line] = {}
        end
        if v.Char == "\n" then
            textBox.Text = ""
        elseif v.Char:match("\t") then
            v.Char = "\t____"
            textBox.Text = "\t____"
            textBox.TextTransparency = 1
        elseif v.Char:match(" ") then
            v.Char = " |"
            textBox.Text = " -"
            textBox.TextTransparency = 1
        else
            textBox.Text = v.Char
        end
        for _, c in pairs(lines[v.Line]) do
            lineSizeX = lineSizeX + TextService:GetTextSize(c.Char, 14, Enum.Font.Arial, Vector2.new(math.huge, math.huge)).X
        end
        textBox.TextColor3 = v.Color
        textBox.Size = UDim2.new(0, size.X, 0, size.Y)
        textBox.TextXAlignment = Enum.TextXAlignment.Left
        textBox.TextYAlignment = Enum.TextYAlignment.Top
        textBox.Position = UDim2.new(0, lineSizeX, 0, v.Line * lineSpace - lineSpace / 2)
        textBox.BackgroundTransparency = 1
        if not lines[v.Line] then
            lines[v.Line] = {}
        end
        v.TextBox = textBox
        table.insert(lines[v.Line], v)
        textBox.Parent = textFrame
    end
    for i = 1, #lines do
        local lineNumber = Instance.new("TextLabel")
        lineNumber.Text = i
        lineNumber.Size = UDim2.new(1, 0, 0, lineSpace)
        lineNumber.TextXAlignment = Enum.TextXAlignment.Right
        lineNumber.TextColor3 = lineNumberColor
        lineNumber.Position = UDim2.new(0, 0, 0, i * lineSpace - lineSpace / 2)
        lineNumber.BackgroundTransparency = 1
        lineNumber.Parent = lineNumbersFrame
    end

    updateZIndex()
    updateCanvasSize()
end

function onFrameSizeChange()
    local newSize = parentFrame.AbsoluteSize
    scrollingFrame.Size = UDim2.new(0, newSize.X, 0, newSize.Y)
end

function updateCanvasSize()
    local codeSize = Vector2.new(TextService:GetTextSize(Highlight:getRaw(), 14, Enum.Font.Arial, Vector2.new(math.huge, math.huge)).X + 60, #lines * lineSpace + 60)
    scrollingFrame.CanvasSize = UDim2.new(0, codeSize.X, 0, codeSize.Y)
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
function Highlight:init(frame)
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
function Highlight:setRaw(raw)
    raw = raw .. "\n"
    tableContents = {}
    local line = 1
    for i = 1, #raw do
        table.insert(tableContents, {
            Char = raw:sub(i, i),
            Color = defaultColor,
            Line = line
        })
        if raw:sub(i, i) == "\n" then
            line = line + 1
        end
    end
    render()
end

--- Returns the (string) raw text of the code box (\n = new line). This includes placeholder characters so it should only be used internally.
--- @return string
function Highlight:getRaw()
    local result = ""
    for _, char in pairs(tableContents) do
        result = result .. char.Char
    end
    return result
end

--- Returns the (string) text of the code box (\n = new line)
--- @return string
function Highlight:getString()
    local result = ""
    for _, char in pairs(tableContents) do
        result = result .. char.Char:sub(1, 1)
    end
    return result
end

--- Returns the (char[]) array that holds all the lines in order as strings
--- @return table[]
function Highlight:getTable()
    return tableContents
end

--- Returns the (int) number of lines in the code box
--- @return number
function Highlight:getSize()
    return #tableContents
end

--- Returns the (string) line of the specified line number
--- @param line number
--- @return string
function Highlight:getLine(line)
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
---@param text string
function Highlight:setLine(line, text)
    if #tableContents and line >= tableContents[#tableContents].Line then
        for i = tableContents[#tableContents].Line, line do
            table.insert(tableContents, {
                Char = "\n",
                Line = i,
                Color = defaultColor
            })
            local str = Highlight:getRaw()
            str = str:sub(0, #str) .. text
            Highlight:setRaw(str)
            return
        end
    elseif not #tableContents then
        return
    end
    local str = Highlight:getRaw()
    local lastStart = 0
    local currentLine = 0
    for i in gfind(str, "\n") do
        currentLine = currentLine + 1
        if line == currentLine then
            str = str:sub(0, lastStart) .. text .. str:sub(i, #str)
            Highlight:setRaw(str)
            return
        end
    end
    error("Unable to set line")
end

--- Inserts a line made from the specified string and moves all existing lines down (\n will insert further lines)
--- @param line number
---@param text string
function Highlight:insertLine(line, text)
    if #tableContents and line >= tableContents[#tableContents].Line then
        Highlight:setLine(line, text)
    elseif not #tableContents then
        return
    end
    local str = Highlight:getRaw()
    local lastStart = 0
    local currentLine = 0
    for i in gfind(str, "\n") do
        currentLine = currentLine + 1
        if line == currentLine then
            str = str:sub(0, lastStart) .. "\n" .. text .. "\n" .. str:sub(i, #str)
            Highlight:setRaw(str)
            return
        end
    end
    error("Unable to insert line")
end

-- CONSTRUCTOR --

local constructor = {}
--- responsible for instantiation
function constructor.new(...)
    local class = Highlight
    local new = {}
    class.__index = class
    setmetatable(new, class)
    new:init(...)
    return new
end

return constructor