--[[
    SimpleSpy v0.9.5 SOURCE 

    Credits: 
        exxtremestuffs - basically everything
        Frosty - GUI to Lua
]]

-- shuts down the previous instance of SimpleSpy
if _G.SimpleSpyExecuted and type(_G.SimpleSpyShutdown) == "function" then
    _G.SimpleSpyShutdown()
end

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

---- GENERATED (kinda sorta mostly) BY GUI to LUA ----

-- Instances:

local ScreenguiS = Instance.new("ScreenGui")
local main = Instance.new("Frame")
local topbar = Instance.new("ImageLabel")
local methodToggle = Instance.new("ImageButton")
local suck = Instance.new("TextButton")
local minimize = Instance.new("TextButton")
local minimize_vis = Instance.new("TextLabel")
local bottombar = Instance.new("ImageLabel")
local remotes = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local eTemplate = Instance.new("ImageButton")
local name = Instance.new("TextLabel")
local fTemplate = Instance.new("ImageButton")
local name_2 = Instance.new("TextLabel")
local side = Instance.new("Frame")
local topbar_2 = Instance.new("ImageLabel")
local bottombar_2 = Instance.new("ImageLabel")
local functions = Instance.new("ScrollingFrame")
local UIListLayout_2 = Instance.new("UIListLayout")
local functionTemplate = Instance.new("ImageButton")
local name_3 = Instance.new("TextLabel")
local description = Instance.new("TextLabel")
local code = Instance.new("ScrollingFrame")
codebox = Instance.new("TextBox")
local lines = Instance.new("TextLabel")

--Properties:

ScreenguiS.Name = "ScreenguiS"
ScreenguiS.Parent = CoreGui
ScreenguiS.Enabled = false
ScreenguiS.DisplayOrder = 999999998

main.Name = "main"
main.Parent = ScreenguiS
main.BackgroundColor3 = Color3.new(0.254902, 0.25098, 0.258824)
main.BorderSizePixel = 0
main.Size = UDim2.new(0, 200, 0, 320)
main.Position = UDim2.new(0.5, -main.Size.X.Offset / 2, 0.5, -main.Size.Y.Offset / 2)
main.ZIndex = 2

topbar.Name = "topbar"
topbar.Parent = main
topbar.BackgroundColor3 = Color3.new(1, 1, 1)
topbar.BackgroundTransparency = 1
topbar.Position = UDim2.new(0, 0, 0, -11)
topbar.Size = UDim2.new(1, 0, 0, 11)
topbar.Image = "rbxassetid://4652116060"
topbar.ZIndex = 2

methodToggle.Name = "methodToggle"
methodToggle.Parent = topbar
methodToggle.BackgroundColor3 = Color3.new(1, 1, 1)
methodToggle.BackgroundTransparency = 1
methodToggle.BorderSizePixel = 0
methodToggle.Position = UDim2.new(0, 14, 0, 0)
methodToggle.Size = UDim2.new(0, 11, 1, 0)
methodToggle.Image = "rbxassetid://4807227064"
methodToggle.ImageColor3 = Color3.fromRGB(51, 233, 81)
methodToggle.ZIndex = 2

suck.Name = "suck"
suck.Parent = topbar
suck.BackgroundColor3 = Color3.new(1, 1, 1)
suck.BackgroundTransparency = 0.9
suck.BorderColor3 = Color3.fromRGB(255, 255, 255)
suck.BorderSizePixel = 1
suck.Position = UDim2.new(1, -20, 0, 0)
suck.Size = UDim2.new(0, 11, 1, 0)
suck.Font = Enum.Font.ArialBold
suck.Text = "<"
suck.TextColor3 = Color3.new(0.933333, 0.933333, 0.933333)
suck.TextSize = 14
suck.ZIndex = 2

minimize.Name = "minimize"
minimize.Parent = topbar
minimize.BackgroundColor3 = Color3.new(1, 1, 1)
minimize.BackgroundTransparency = 0.9
minimize.BorderColor3 = Color3.fromRGB(255, 255, 255)
minimize.BorderSizePixel = 1
minimize.Position = UDim2.new(1, -33, 0, 0)
minimize.Size = UDim2.new(0, 11, 1, 0)
minimize.Text = ""
minimize.ZIndex = 2

minimize_vis.Name = "minimize_vis"
minimize_vis.Parent = minimize
minimize_vis.BackgroundColor3 = Color3.new(1, 1, 1)
minimize_vis.BackgroundTransparency = 1
minimize_vis.BorderSizePixel = 0
minimize_vis.Position = UDim2.new(0, 0, 0, -6)
minimize_vis.Size = UDim2.new(0, 11, 1, 0)
minimize_vis.Font = Enum.Font.SourceSansBold
minimize_vis.Text = "_"
minimize_vis.TextColor3 = Color3.new(0.933333, 0.933333, 0.933333)
minimize_vis.TextSize = 14
minimize_vis.ZIndex = 2

bottombar.Name = "bottombar"
bottombar.Parent = main
bottombar.BackgroundColor3 = Color3.new(1, 1, 1)
bottombar.BackgroundTransparency = 1
bottombar.Position = UDim2.new(0, 0, 1, 0)
bottombar.Rotation = 180
bottombar.Size = UDim2.new(1, 0, 0, 11)
bottombar.Image = "rbxassetid://4652116060"
bottombar.ZIndex = 2

remotes.Name = "remotes"
remotes.Parent = main
remotes.BackgroundColor3 = Color3.new(1, 1, 1)
remotes.BackgroundTransparency = 1
remotes.BorderSizePixel = 0
remotes.Position = UDim2.new(0, 2, 0.0250000004, 0)
remotes.Size = UDim2.new(0, 198, 0.949999988, 0)
remotes.CanvasSize = UDim2.new(0, 0, 0, 0)
remotes.HorizontalScrollBarInset = Enum.ScrollBarInset.Always
remotes.ScrollBarThickness = 10
remotes.ZIndex = 2
remotes.ScrollingDirection = Enum.ScrollingDirection.Y

UIListLayout.Parent = remotes
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 3)

eTemplate.Name = "eTemplate"
eTemplate.Parent = remotes
eTemplate.BackgroundColor3 = Color3.new(1, 1, 1)
eTemplate.BackgroundTransparency = 1
eTemplate.Size = UDim2.new(0, 187, 0, 20)
eTemplate.Image = "rbxassetid://4652152767"
eTemplate.ZIndex = 2

name.Name = "name"
name.Parent = eTemplate
name.BackgroundColor3 = Color3.new(1, 1, 1)
name.BackgroundTransparency = 1
name.Position = UDim2.new(0, 6, 0, 0)
name.Size = UDim2.new(1, -6, 1, 0)
name.Font = Enum.Font.SourceSansSemibold
name.Text = "RemoteEvent"
name.TextColor3 = Color3.new(0.917647, 0.917647, 0.917647)
name.TextSize = 14
name.ZIndex = 3

fTemplate.Name = "fTemplate"
fTemplate.Parent = remotes
fTemplate.BackgroundColor3 = Color3.new(1, 1, 1)
fTemplate.BackgroundTransparency = 1
fTemplate.Size = UDim2.new(0, 187, 0, 20)
fTemplate.Image = "rbxassetid://4652182447"
fTemplate.ZIndex = 2

name_2.Name = "name"
name_2.Parent = fTemplate
name_2.BackgroundColor3 = Color3.new(1, 1, 1)
name_2.BackgroundTransparency = 1
name_2.Position = UDim2.new(0, 6, 0, 0)
name_2.Size = UDim2.new(1, -6, 1, 0)
name_2.Font = Enum.Font.SourceSansSemibold
name_2.Text = "RemoteFunction"
name_2.TextColor3 = Color3.new(0.917647, 0.917647, 0.917647)
name_2.TextSize = 14
name_2.ZIndex = 3

side.Name = "side"
side.Parent = main
side.BackgroundColor3 = Color3.new(0.254902, 0.25098, 0.258824)
side.BorderSizePixel = 0
side.Position = UDim2.new(1, 0, 0, 0)
side.Size = UDim2.new(0, 300, 0, 320)
side.ZIndex = 0

topbar_2.Name = "topbar"
topbar_2.Parent = side
topbar_2.BackgroundColor3 = Color3.new(1, 1, 1)
topbar_2.BackgroundTransparency = 1
topbar_2.Position = UDim2.new(0, 0, 0, -11)
topbar_2.Size = UDim2.new(1, 0, 0, 11)
topbar_2.ZIndex = 0
topbar_2.Image = "rbxassetid://4652116060"

bottombar_2.Name = "bottombar"
bottombar_2.Parent = side
bottombar_2.BackgroundColor3 = Color3.new(1, 1, 1)
bottombar_2.BackgroundTransparency = 1
bottombar_2.Position = UDim2.new(0, 0, 1, 0)
bottombar_2.Rotation = 180
bottombar_2.Size = UDim2.new(1, 0, 0, 11)
bottombar_2.ZIndex = 0
bottombar_2.Image = "rbxassetid://4652116060"

functions.Name = "functions"
functions.Parent = side
functions.BackgroundColor3 = Color3.new(1, 1, 1)
functions.BackgroundTransparency = 1
functions.BorderSizePixel = 0
functions.Position = UDim2.new(0, 1, 0.5, 0)
functions.Size = UDim2.new(1, -1, 0.5, 0)
functions.ZIndex = 0
functions.CanvasSize = UDim2.new(0, 0, 0, 0)
functions.HorizontalScrollBarInset = Enum.ScrollBarInset.Always
functions.ScrollBarThickness = 10
functions.ScrollingDirection = Enum.ScrollingDirection.Y

UIListLayout_2.Parent = functions
UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_2.Padding = UDim.new(0, 3)

functionTemplate.Name = "functionTemplate"
functionTemplate.Parent = functions
functionTemplate.BackgroundColor3 = Color3.new(1, 1, 1)
functionTemplate.BackgroundTransparency = 1
functionTemplate.Size = UDim2.new(0, 288, 0, 20)
functionTemplate.ZIndex = 0
functionTemplate.Image = "http://www.roblox.com/asset/?id=4806096140"
functionTemplate.ZIndex = 0

name_3.Name = "name"
name_3.Parent = functionTemplate
name_3.BackgroundColor3 = Color3.new(1, 1, 1)
name_3.BackgroundTransparency = 1
name_3.Position = UDim2.new(0, 5, 0, 0)
name_3.Size = UDim2.new(0, 107, 1, 0)
name_3.Font = Enum.Font.SourceSansSemibold
name_3.Text = "FunctionName"
name_3.TextColor3 = Color3.new(0.917647, 0.917647, 0.917647)
name_3.TextSize = 14
name_3.ZIndex = 0

description.Name = "description"
description.Parent = functionTemplate
description.BackgroundColor3 = Color3.new(1, 1, 1)
description.BackgroundTransparency = 1
description.Position = UDim2.new(0, 120, 0, 0)
description.Size = UDim2.new(0, 160, 1, 0)
description.Font = Enum.Font.SourceSansSemibold
description.Text = "Function description..."
description.TextScaled = true
description.TextColor3 = Color3.new(0.917647, 0.917647, 0.917647)
description.TextSize = 14
description.ZIndex = 0

code.Name = "code"
code.Parent = side
code.BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255)
code.BorderSizePixel = 0
code.Size = UDim2.new(1, 0, 0.5, 0)
code.ZIndex = 0
code.CanvasSize = UDim2.new(0, 0, 0, 0)
code.HorizontalScrollBarInset = Enum.ScrollBarInset.Always
code.ScrollBarThickness = 10

codebox.Name = "codebox"
codebox.Parent = code
codebox.BackgroundColor3 = Color3.new(1, 1, 1)
codebox.BackgroundTransparency = 1
codebox.Position = UDim2.new(0, 18, 0, 0)
codebox.Size = UDim2.new(1, -18, 1, 0)
codebox.Font = Enum.Font.SourceSans
codebox.Text = "-- hiya, you shouldn't be seeing this"
codebox.TextColor3 = Color3.new(0.87451, 0.87451, 0.87451)
codebox.TextSize = 14
codebox.TextXAlignment = Enum.TextXAlignment.Left
codebox.TextYAlignment = Enum.TextYAlignment.Top
codebox.ZIndex = 0
codebox.ClearTextOnFocus = false

lines.Name = "lines"
lines.Parent = code
lines.BackgroundColor3 = Color3.new(0.0823529, 0.0823529, 0.0823529)
lines.BorderSizePixel = 0
lines.Size = UDim2.new(0, 15, 1, 0)
lines.Font = Enum.Font.SourceSansSemibold
lines.Text = "1"
lines.TextColor3 = Color3.new(0.466667, 0.494118, 1)
lines.TextSize = 14
lines.TextYAlignment = Enum.TextYAlignment.Top
lines.ZIndex = 0

-------------------------------------------------------------------------------
-- init
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ContentProvider = game:GetService("ContentProvider")
local TextService = game:GetService("TextService")

--- UDim2 size of `main` while minimized
local minSize = UDim2.new(0, 100, 0, 15)
--- UDim2 size of `main` while expanded
local mainSize = main.Size
local selectedColor = Color3.new(0.321569, 0.333333, 1)
local deselectedColor = Color3.new(0.8, 0.8, 0.8)
--- So things are descending
local layoutOrderNum = 999999999
--- Whether or not the gui is closing
local mainClosing = false
--- Whether or not the gui is closed (defaults to false)
closed = false
--- Whether or not the sidebar is closing
local sideClosing = false
--- Whether or not the sidebar is closed (defaults to true but opens automatically on remote selection)
local sideClosed = false
--- The event logs to be read from
logs = {}
--- The event currently selected.Log (defaults to nil)
selected = nil
--- The blacklist (can be a string name or the Remote Instance)
blacklist = {}
--- The block list (can be a string name or the Remote Instance)
blocklist = {}
--- Whether or not to add getNil function
local getNil = false
--- Array of remotes (and original functions) connected to
local connectedRemotes = {}
--- True = hookfunction, false = namecall
local toggle = false
local gm = getrawmetatable(game)
local original = gm.__namecall
setreadonly(gm, false)
--- This event is the main handler for remotes
local remoteHandlerEvent = Instance.new("BindableEvent")
--- used to prevent recursives
local prevTables = {}
--- holds logs (for deletion)
local remoteLogs = {}
--- used for hookfunction
local remoteEvent = Instance.new("RemoteEvent")
--- used for hookfunction
local remoteFunction = Instance.new("RemoteFunction")
local originalEvent = remoteEvent.FireServer
local originalFunction = remoteFunction.InvokeServer
local prevArgs = {}
--- used for minimizing the side menu
local normalSize, normalPos, minSize, minPos = side.Size, side.Position, UDim2.new(1, 0, 1, 0), UDim2.new()
--- used for minimizing the gui
local normalSizeM, minSizeM = main.Size, UDim2.new(0, main.Size.X.Offset, 0, 0)
--- used for determining the last cursor position
local lastCursorPos, cursorPos = 0, 0
--- the maximum amount of remotes allowed in logs
_G.SIMPLESPYCONFIG_MaxRemotes = 500
--- the current amount of tasks in the scheduler
local tasks = {}
--- this bindable is fired whenever the task queue updates
local tasksUpdate = Instance.new("BindableEvent")
--- string that contains things to deal with recursives, to be put after the table
local recursiveHandlingString = ""

-- functions

--- Prevents remote spam from causing lag (clears logs after `_G.SIMPLESPYCONFIG_MaxRemotes` or 500 remotes)
function clean()
    local max = _G.SIMPLESPYCONFIG_MaxRemotes
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

--- Toggles the remote spy method (when button clicked)
function onToggleButtonClick()
    if toggle then
        methodToggle.ImageColor3 = Color3.fromRGB(248, 39, 39)
    else
        methodToggle.ImageColor3 = Color3.fromRGB(51, 233, 81)
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
    if main.Position.X.Offset > workspace.CurrentCamera.ViewportSize.X or main.Position.Y.Offset > workspace.CurrentCamera.ViewportSize.Y then
        TweenService:Create(main, TweenInfo.new(0.5), {Position = UDim2.new(0, 0, 0, 11)}):Play()
    end
end

--- Drags gui (so long as mouse is held down)
function onBarInput(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local lastPos = UserInputService:GetMouseLocation()
        local currentPos = main.Position
        RunService:BindToRenderStep(
            "drag",
            1,
            function()
                local newPos = UserInputService:GetMouseLocation()
                if newPos ~= lastPos then
                    local currentX = currentPos.X.Offset + (newPos - lastPos).X
                    if (currentX < 0 and currentX < currentPos.X.Offset) or (currentX > (workspace.CurrentCamera.ViewportSize.X - main.Size.X.Offset) and currentX > currentPos.X.Offset) then
                        currentX = currentPos.X.Offset
                    end
                    local currentY = currentPos.Y.Offset + (newPos - lastPos).Y
                    if (currentY < 11 and currentY < currentPos.Y.Offset) or (currentY > (workspace.CurrentCamera.ViewportSize.Y - (main.Size.Y.Offset + 47)) and currentY > currentPos.Y.Offset) then
                        currentY = currentPos.Y.Offset
                    end
                    currentPos = UDim2.new(0, currentX, 0, currentY)
                    TweenService:Create(main, TweenInfo.new(0.1), {Position = currentPos}):Play()
                    lastPos = newPos
                end
            end
        )
        UserInputService.InputEnded:Connect(
            function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    RunService:UnbindFromRenderStep("drag")
                end
            end
        )
    end
end

--- Expands and minimizes the gui (closed is the toggle boolean)
function toggleMinimize(override)
    if mainClosing and not override then
        return
    end
    mainClosing = true
    if not closed then
        if not sideClosed then
            toggleSideTray(true)
        end
        TweenService:Create(main, TweenInfo.new(0.5), {Size = minSizeM}):Play()
        TweenService:Create(minimize, TweenInfo.new(0.5), {Rotation = 90}):Play()
        wait(0.5)
        remotes.Visible = false
    else
        TweenService:Create(main, TweenInfo.new(0.5), {Size = normalSizeM}):Play()
        TweenService:Create(minimize, TweenInfo.new(0.5), {Rotation = 0}):Play()
        remotes.Visible = true
        wait(0.5)
    end
    closed = not closed
    mainClosing = false
end

--- Expands and minimizes the sidebar (sideClosed is the toggle boolean)
function toggleSideTray(override)
    if sideClosing and not override then
        return
    end
    sideClosing = true
    if not sideClosed and side.Visible then
        TweenService:Create(side, TweenInfo.new(0.5), {Size = minSize, Position = minPos}):Play()
        TweenService:Create(suck, TweenInfo.new(0.5), {Rotation = 180}):Play()
        wait(0.5)
        side.Visible = false
        side.BackgroundTransparency = 0
        side.Size, side.Position = normalSize, normalPos
    else
        if closed then
            toggleMinimize(true)
        end
        side.Size, side.Position = minSize, minPos
        side.Visible = true
        TweenService:Create(side, TweenInfo.new(0.5), {Size = normalSize, Position = normalPos}):Play()
        TweenService:Create(suck, TweenInfo.new(0.5), {Rotation = 0}):Play()
        wait(0.5)
    end
    sideClosed = not sideClosed
    sideClosing = false
end

--- Runs when the cursor position changes, saves the previous value and current value to variables
function onCursorPosChange()
    lastCursorPos = cursorPos
    cursorPos = codebox.CursorPosition
end

--- Returns a table of {number of lines: number, canvas size:UDim2} from the codebox
function getLinesAndCanvas()
    local lineNumber = 0
    for _ in string.gmatch(codebox.Text, "\n") do
        lineNumber = lineNumber + 1
    end
    local size = TextService:GetTextSize(codebox.Text, 14, Enum.Font.SourceSans, Vector2.new(math.huge, math.huge))
    return {lineNumber, UDim2.new(0, size.X + 25, 0, size.Y)}
end

--- Runs every time the codebox is modified
function updateCodebox()
    local lineNumber, canvasSize = unpack(getLinesAndCanvas())
    code.CanvasSize = canvasSize
    local lineString = ""
    for i = 1, lineNumber + 1 do
        lineString = lineString .. tostring(i) .. "\n"
    end
    lines.Text = lineString
end

--- Used to have enter key create a new line
function onDeselect(isEnter)
    if isEnter and cursorPos == -1 then
        local cPos = lastCursorPos
        if cPos == #codebox.Text then
            codebox.Text = codebox.Text .. "\n"
            codebox.Text = codebox.Text:sub(1, #codebox.Text - 1)
        elseif cPos == 0 then
            codebox.Text = "\n" .. codebox.Text
            codebox.Text = codebox.Text:sub(2, #codebox.Text)
            codebox.Text = codebox.Text:sub(1, 1) .. codebox.Text:sub(3, #codebox.Text)
        else
            codebox.Text = codebox.Text:sub(1, cPos) .. "\n" .. codebox.Text:sub(cPos, #codebox.Text)
            codebox.Text = codebox.Text:sub(1, cPos) .. codebox.Text:sub(cPos + 2, #codebox.Text)
        end
        codebox:CaptureFocus()
        codebox.CursorPosition = cPos + 1
    end
end

--- Checks if the given Remote is blacklisted; returns true if blacklisted, false if not
function blacklisted(remote)
    if #blacklist > 0 then
        for _, v in pairs(blacklist) do
            if type(v) == "string" and v == remote.Name then
                return true
            elseif typeof(v) == "Instance" and v == remote then
                return true
            end
        end
    end
    return false
end

--- Checks if the given Remote is blocked; returns true if blacklisted, false if not
function blocked(remote)
    if #blocklist > 0 then
        for _, v in pairs(blocklist) do
            if type(v) == "string" and v == remote.Name then
                return true
            elseif typeof(v) == "Instance" and v == remote then
                return true
            end
        end
    end
    return false
end

--- Runs on MouseButton1Click of an event frame
function eventSelect(frame)
    if selected and selected.Log and typeof(selected.Log.name) == "Instance" and selected.Log.name:IsA("TextLabel") then
        TweenService:Create(selected.Log.name, TweenInfo.new(0.5), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        selected = nil
    end
    for _, v in pairs(logs) do
        if frame == v.Log then
            selected = v
        end
    end
    if selected and selected.Log and selected.Log.name then
        TweenService:Create(selected.Log.name, TweenInfo.new(0.5), {TextColor3 = Color3.fromRGB(0, 195, 255)}):Play()
        codebox.Text = selected.GenScript
    end
    if sideClosed then
        toggleSideTray()
    end
end

--- Updates the canvas size to fit the current amount of function buttons
function updateFunctionCanvas()
    local individualHeight = UIListLayout_2.Padding.Offset + functionTemplate.AbsoluteSize.Y
    local canvasHeight = 0
    for i = 1, #functions:GetChildren() - 1 do
        canvasHeight = canvasHeight + individualHeight
    end
    functions.CanvasSize = UDim2.new(1, 0, 0, canvasHeight)
end

--- Updates the canvas size to fit the amount of current remotes
function updateRemoteCanvas()
    local individualHeight = UIListLayout.Padding.Offset + eTemplate.AbsoluteSize.Y
    local canvasHeight = 0
    for i = 1, #remotes:GetChildren() - 1 do
        canvasHeight = canvasHeight + individualHeight
    end
    remotes.CanvasSize = UDim2.new(1, 0, 0, canvasHeight)
end

--- Creates new function button (below codebox)
function newButton(name, defaultName, onClick)
    local button = functionTemplate:Clone()
    button.name.Text = name
    button.description.Text = defaultName
    button.MouseButton1Click:Connect(
        function(...)
            if selected then
                onClick(button.description, ...)
            end
        end
    )
    button.Parent = functions
    updateFunctionCanvas()
end

--- Adds new RemoteEvent to logs
function newEvent(name, gen_script, remote, source_script, blocked, upvalues, constants, num)
    local remoteFrame = eTemplate:Clone()
    remoteFrame.name.Text = name
    local id = Instance.new("IntValue")
    id.Name = "ID"
    id.Value = #logs + 1
    id.Parent = remoteFrame
    logs[#logs + 1] = {
        Name = name,
        GenScript = gen_script,
        Source = source_script,
        Remote = remote,
        Log = remoteFrame,
        Upvalues = upvalues,
        Constants = constants,
        Blocked = blocked,
        FunNum = num
    }
    if blocked then
        logs[#logs].GenScript = "-- THIS REMOTE WAS PREVENTED FROM FIRING THE SERVER BY SIMPLESPY\n\n" .. logs[#logs].GenScript
    end
    local connect = remoteFrame.MouseButton1Click:Connect(
        function(...)
            eventSelect(remoteFrame, ...)
        end
    )
    if layoutOrderNum < 1 then
        layoutOrderNum = 999999999
    end
    remoteFrame.LayoutOrder = layoutOrderNum
    layoutOrderNum = layoutOrderNum - 1
    remoteFrame.Parent = remotes
    table.insert(remoteLogs, 1, {connect, remoteFrame})
    clean()
    updateRemoteCanvas()
end

--- Adds new RemoteFunction to logs
function newFunction(name, gen_script, remote, source_script, blocked, upvalues, constants, num)
    local remoteFrame = fTemplate:Clone()
    remoteFrame.name.Text = name
    local id = Instance.new("IntValue")
    id.Name = "ID"
    id.Value = #logs + 1
    id.Parent = remoteFrame
    logs[#logs + 1] = {
        Name = name,
        GenScript = gen_script,
        Source = source_script,
        Remote = remote,
        Log = remoteFrame,
        Upvalues = upvalues,
        Constants = constants,
        Blocked = blocked,
        FunNum = num
    }
    if blocked then
        logs[#logs].GenScript = "-- THIS REMOTE WAS PREVENTED FROM FIRING THE SERVER BY SIMPLESPY\n\n" .. logs[#logs].GenScript
    end
    local connect = remoteFrame.MouseButton1Click:Connect(
        function(...)
            eventSelect(remoteFrame, ...)
        end
    )
    if layoutOrderNum < 1 then
        layoutOrderNum = 999999999
    end
    remoteFrame.LayoutOrder = layoutOrderNum
    layoutOrderNum = layoutOrderNum - 1
    remoteFrame.Parent = remotes
    table.insert(remoteLogs, 1, {connect, remoteFrame})
    clean()
    updateRemoteCanvas()
end

--- Generates a script from the provided arguments (first has to be remote path)
function genScript(remote, ...)
    prevTables = {}
    local gen = ""
    local args = {...}
    if #args > 0 then
        if
            not pcall(
                function()
                    gen = tableToString(args) .. "\n\n"
                end
            )
         then
            gen =
                gen .. "-- TableToString failure! Reverting to legacy functionality (results may vary)\nlocal args = {"
            if
                not pcall(
                    function()
                        for i, v in pairs(args) do
                            if type(i) ~= "Instance" and type(i) ~= "userdata" then
                                gen = gen .. "\n    [" .. tostring(i) .. "] = "
                            elseif type(i) == "string" then
                                gen = gen .. '\n    ["' .. tostring(i) .. '"] = '
                            elseif type(i) == "userdata" and typeof(i) ~= "Instance" then
                                gen = gen .. "\n    [" .. typeof(i) .. ".new(" .. tostring(i) .. ")] = "
                            elseif type(i) == "userdata" then
                                gen = gen .. "\n    [game." .. i:GetFullName() .. ")] = "
                            end
                            if type(v) ~= "Instance" and type(v) ~= "userdata" then
                                gen = gen .. tostring(v)
                            elseif type(v) == "string" then
                                gen = gen .. '"' .. tostring(v) .. '"'
                            elseif type(v) == "userdata" and typeof(v) ~= "Instance" then
                                gen = gen .. typeof(v) .. ".new(" .. tostring(v) .. ")"
                            elseif type(v) == "userdata" then
                                gen = gen .. "game." .. v:GetFullName()
                            end
                        end
                        gen = gen .. "\n}\n\n"
                    end
                )
             then
                gen = gen .. "}\n-- Legacy tableToString failure! Unable to decompile."
            end
        end
        if remote:IsA("RemoteEvent") then
            gen = gen .. typeToString(remote) .. ":FireServer(unpack(args))"
        elseif remote:IsA("RemoteFunction") then
            gen = gen .. typeToString(remote) .. ":InvokeServer(unpack(args))"
        end
    else
        if remote:IsA("RemoteEvent") then
            gen = gen .. typeToString(remote) .. ":FireServer()"
        elseif remote:IsA("RemoteFunction") then
            gen = gen .. typeToString(remote) .. ":InvokeServer()"
        end
    end
    if getNil then
        gen =
            "function getNil(name,class) for _,v in pairs(getnilinstances())do if v.ClassName==class and v.Name==name then return v;end end end\n\n" ..
            gen
        getNil = false
    end
    gen =
        "-- Script generated by SimpleSpy - credits to exxtremewa#9394\n-- This generator is IN DEVELOPMENT, not compatible with all types/classes yet\n\n" ..
        gen
    prevTables = {}
    return gen
end

--- Generates spaces based on the provided level
function space(level)
    local out = ""
    for i = 1, level do
        out = out .. " "
    end
    return out
end

--- Adds \'s to the text as a replacement to whitespace chars and other things
function getSpecials(s, nested)
    if not nested then
        s = s:gsub("\\", "\\\\")
    end
    if s:match("\n") then
        local pos, pos2 = s:find("\n")
        s = s:sub(0, pos - 1) .. "\\n" .. s:sub(pos2 + 1, s:len())
        return getSpecials(s, true)
    elseif s:match("\t") then
        local pos, pos2 = s:find("\t")
        s = s:sub(0, pos - 1) .. "\\t" .. s:sub(pos2 + 1, s:len())
        return getSpecials(s, true)
    elseif s:match("\t") then
        local pos, pos2 = s:find("\t")
        s = s:sub(0, pos - 1) .. "\\t" .. s:sub(pos2 + 1, s:len())
        return getSpecials(s, true)
    elseif s:match("\"") and (s:sub(s:find("\"") - 1, s:find("\"") - 1) ~= "\\") then
        local pos, pos2 = s:find("\"")
        s = s:sub(0, pos - 1) .. "\\\"" .. s:sub(pos2 + 1, s:len())
        return getSpecials(s, true)
    elseif s:match("'") and (s:sub(s:find("'") - 1, s:find("'") - 1) ~= "\\") then
        local pos, pos2 = s:find("'")
        s = s:sub(0, pos - 1) .. "\\'" .. s:sub(pos2 + 1, s:len())
        return getSpecials(s, true)
    else
        return s
    end
end

--- Converts the path of a value of a table into a string
function valueToString(pt, x, level, getRecursive, tableName)
    local prev = {}
    local string = tableName
    local currentPath = ""
    function iterate(t,  s)
        if x == t then
            return {true, s}
        end
        for i, v in pairs(t) do
            if x == v then
                return {true, s .. "[" .. typeToString(i, pt, level) .. "]"}
            elseif type(v) == "table" then
                for _, v in pairs(prev) do
                    if v == tostring(t) then
                        return {false, ""}
                    end
                end
                table.insert(prev, tostring(t))
                s = s .. "[" .. typeToString(i, pt, level) .. "]"
                local results = iterate(v, s)
                prev = {}
                if results[1] then
                    return results
                end
            end
        end
        return {false, ""}
    end
    function iterate2(t,  s, ignore)
        if x == t and s ~= ignore then
            return s
        end
        for i, v in pairs(t) do
            s = s .. "[" .. typeToString(i, pt, level) .. "]"
            if v == x and s ~= ignore then
                return s
            elseif type(v) == "table" then
                for _, v in pairs(prev) do
                    if v == tostring(t) then
                        return {false, ""}
                    end
                end
                table.insert(prev, tostring(t))
                local results = iterate2(v, s, ignore)
                prev = {}
                if results then
                    return results
                end
            end
        end
        return ""
    end
    local results = iterate(pt, string)
    if results[1] then
        recursiveHandlingString = recursiveHandlingString .. "\n" .. iterate2(pt, string, results[2]) .. " = " .. results[2]
        return "{} --[[RECURSIVE DETECTED]]"
    end
    return "{} --[[RECURSIVE DETECTED]]"
end

--- Converts a var to a string (including userdata)
function typeToString(var, parentTable, level, tableName)
    if not level then
        level = 4
    end
    local out = ""
    if type(var) ~= "userdata" and type(var) ~= "table" and type(var) ~= "string" then
        -- Number, booleans
        out = out .. tostring(var)
    elseif type(var) == "string" then
        -- Strings
        out = out .. '"' .. getSpecials(var) .. '"'
    elseif type(var) == "table" then
        -- Tables
        local recursive, selfRecursive = false, false
        if prevTables[1] and prevTables[1] == tostring(var) then
            selfRecursive = true
        end
        for _, v in pairs(prevTables) do
            if v == tostring(var) then
                recursive = true
                break
            end
        end
        if not parentTable then
            parentTable = var
        end
        if not recursive then
            out = out .. tableToString(var, level, parentTable, tableName)
        else
            out = out .. valueToString(parentTable, var, level, true, tableName)
        end
    elseif typeof(var) == "TweenInfo" then
        -- TweenInfo
        out =
            out ..
            "TweenInfo.new(" ..
                tostring(var.Time) ..
                    ", Enum.EasingStyle." ..
                        tostring(var.EasingStyle) ..
                            ", Enum.EasingDirection." ..
                                tostring(var.EasingDirection) ..
                                    ", " ..
                                        tostring(var.RepeatCount) ..
                                            ", " .. tostring(var.Reverses) .. ", " .. tostring(var.DelayTime) .. ")"
    elseif typeof(var) == "Ray" then
        -- Ray
        out =
            out ..
            "Ray.new(Vector3.new(" .. tostring(var.Origin) .. "), Vector3.new(" .. tostring(var.Direction) .. "))"
    elseif typeof(var) == "NumberSequence" then
        -- NumberSequence
        out = out .. "NumberSequence.new("
        for i, v in pairs(var.KeyPoints) do
            out = out .. tostring(v)
            if i < #var.Keypoints then
                out = out .. ", "
            end
        end
        out = out .. ")"
    elseif typeof(var) == "DockWidgetPluginGuiInfo" then
        -- DockWidgetPluginGuiInfo
        out = out .. "DockWidgetPluginGuiInfo.new(Enum.InitialDockState" .. tostring(var) .. ")"
    elseif typeof(var) == "ColorSequence" then
        -- ColorSequence
        out = out .. "ColorSequence.new("
        for i, v in pairs(var.KeyPoints) do
            out = out .. "Color3.new(" .. tostring(v) .. ")"
            if i < #var.Keypoints then
                out = out .. ", "
            end
        end
        out = out .. ")"
    elseif typeof(var) == "BrickColor" then
        -- BrickColor
        out = out .. "BrickColor.new(" .. tostring(var.Number) .. ")"
    elseif typeof(var) == "NumberRange" then
        -- NumberRange
        out = out .. "NumberRange.new(" .. tostring(var.Min) .. ", " .. tostring(var.Max) .. ")"
    elseif typeof(var) == "Region3" then
        -- Region3
        local center = var.CFrame.Position
        local size = var.CFrame.Size
        local vector1 = center - size / 2
        local vector2 = center + size / 2
        out = out .. "Region3.new(Vector3.new(" .. tostring(vector1) .. "), Vector3.new(" .. tostring(vector2) .. ")"
    elseif type(var) == "userdata" and typeof(var) ~= "Instance" then
        -- Default userdata (no instances)
        local dataName = typeof(var)
        local args = tostring(var)
        for i = 1, args:len() do
            if args:sub(i, i) == "}" or args:sub(i, i) == "{" then
                if i > 1 and i < args:len() then
                    args = args:sub(1, i - 1) .. " " .. args:sub(i + 1, args:len())
                elseif i == 1 then
                    args = " " .. args:sub(i + 1, args:len())
                elseif i == args:len() then
                    args = args:sub(1, i - 1) .. " "
                end
            end
        end
        out = out .. dataName .. ".new(" .. args .. ")"
    elseif type(var) == "userdata" and typeof(var) == "Instance" then
        -- Instances
        local parent = var
        if parent == nil then
            out = "nil"
        elseif parent ~= game then
            while true do
                if parent and parent.Parent == game then
                    if game:GetService(parent.ClassName) then
                        if parent.ClassName == "Workspace" then
                            out = "workspace" .. out
                        else
                            out = 'game:GetService("' .. parent.ClassName .. '")' .. out
                        end
                        break
                    else
                        out = 'game["' .. getSpecials(parent.Name) .. '"]'
                        break
                    end
                elseif parent.Parent == nil then
                    getNil = true
                    out = 'getNil("' .. getSpecials(parent.Name) .. '", "' .. parent.ClassName .. '")'
                    break
                else
                    if parent.Name:match("%a+") ~= parent.Name then
                        out = '["' .. getSpecials(parent.Name) .. '"]' .. out
                    else
                        out = "." .. parent.Name .. out
                    end
                end
                parent = parent.Parent
            end
        else
            out = "game"
        end
    -- legacy method
    -- out = out .. "game." .. var:GetFullName() .. ","
    end
    return out
end

--- Determines if a provided table is an array, also returns size
function isArray(t)
    local size = 0
    for i, v in pairs(t) do
        size = size + 1
        if type(i) ~= "number" or i ~= math.floor(i) then
            return false
        end
    end
    return true, size
end

--- Iterates through a full array (thx frosty)
local function iterate(t)
    local i, n, continue_table, f = 0, #t, {}, #t
    for i, v in pairs(t) do
        if type(i) ~= "number" then
            n = n + 1;
            table.insert(continue_table, {i, v})
        end
    end
    return function ()
        i = i + 1
        if i <= n then 
            if i > f then
                return unpack(continue_table[i - f])
            end
            return i, t[i] 
        end
    end
end

--- Converts a table to a string (includes nested tables)
function tableToString(t, level, parentTable, tableName)
    local first = false
    if not tableName then
        tableName = "args"
    end
    if not parentTable then
        parentTable = t
        first = true
    end
    table.insert(prevTables, tostring(t))
    if type(level) ~= "number" then
        level = 4
    else
        level = level + 4
    end
    local out = ""
    local array, size
    if first then
        array, size = isArray(t)
    end
    if first and array then
        for i, v in iterate(t) do
            out = out .. "\n" .. space(level) .. "[" .. typeToString(i, parentTable, level, tableName) .. "] = " .. typeToString(v, parentTable, level, tableName) .. ","
        end
    else
        for i, v in pairs(t) do
            out = out .. "\n" .. space(level) .. "[" .. typeToString(i, parentTable, level, tableName) .. "] = " .. typeToString(v, parentTable, level, tableName) .. ","
        end
    end
    out = "{" .. out .. "\n" .. space(level - 4) .. "}"
    if first then
        out = "local " .. tableName .." = " .. out
    end
    if first and recursiveHandlingString then
        out = out .. "\n" .. recursiveHandlingString
        recursiveHandlingString = ""
    end
    return out
end

-- --- Adds a function to the task scheduler, must run in coroutine
function scheduleFunction(f, name)
    if #tasks > 999999 then
        rconsolewarn("Unable to schedule task " .. name .. ", too many tasks in queue (999999+).")
        rconsolename = "SimpleSpy Error Console"
        return
    end
    local id = tostring(f)
    table.insert(tasks, id)
    local connection
    connection = tasksUpdate.Event:Connect(function(reason)
        if tasks[1] == id then
            connection:Disconnect()
            pcall(f)
            RunService.RenderStepped:Wait()
            table.remove(tasks, 1)
            tasksUpdate:Fire("finished")
        end
    end)
    tasksUpdate:Fire("added")
end

--- Handles remote logs
function remoteHandler(hookfunction, methodName, remote, args, script, func)
    if methodName == "FireServer" and not blacklisted(remote) then
        table.remove(args, 1)
        local funNum
        if typeof(func) == "function" then
            for i, v in pairs(getgc()) do
                if v == func then
                    funNum = i
                    break
                end
            end
            remoteHandlerEvent:Fire("RemoteEvent", remote.Name, genScript(remote, unpack(args)), remote, script, blocked(remote), tableToString(debug.getupvalues(func), nil, nil, "upvalues"), tableToString(debug.getconstants(func), nil, nil, "constants"), funNum)
        else
            remoteHandlerEvent:Fire("RemoteEvent", remote.Name, genScript(remote, unpack(args)), remote, script, blocked(remote), tableToString({}), tableToString({}), 0)
        end
    elseif methodName == "InvokeServer" and not blacklisted(remote) then
        table.remove(args, 1)
        local funNum
        if typeof(func) == "function" then
            for i, v in pairs(getgc()) do
                if v == func then
                    funNum = i
                    break
                end
            end
            remoteHandlerEvent:Fire("RemoteFunction", remote.Name, genScript(remote, unpack(args)), remote, script, blocked(remote), tableToString(debug.getupvalues(func), nil, nil, "upvalues"), tableToString(debug.getconstants(func), nil, nil, "constants"), funNum)
        else
            remoteHandlerEvent:Fire("RemoteFunction", remote.Name, genScript(remote, unpack(args)), remote, script, blocked(remote), tableToString({}), tableToString({}), 0)
        end
    end
end

--- Used for hookfuncton to check if arguments are equal
function isEqual(table1, table2)
    for i, v in pairs(table1) do
        if table2[i] ~= v then
            return false
        end
    end
    return true
end

--- Used for hookfunction
function hookRemote(methodName, remote, ...)
    local args = {...}
    if isEqual(args, prevArgs) then
        prevArgs = {unpack(args)}
        return
    end
    prevArgs = {unpack(args)}
    local script = rawget(getfenv(0), "script")
    coroutine.wrap(scheduleFunction)(function() remoteHandler(true, methodName, remote, args, script, nil) end, remote.Name)
    if blocked(remote) then
        return false
    end
    return true
end

--- Toggles on and off the remote spy
function toggleSpy()
    if not toggle then
        originalEvent = hookfunction(remoteEvent.FireServer, function(...) if hookRemote("FireServer", ...) then return originalEvent(...) end end)
        originalFunction = hookfunction(remoteFunction.InvokeServer, function(...) if hookRemote("InvokeServer", ...) then return originalFunction(...) end end)
        gm.__namecall = newcclosure(function(...)
            local args = {...}
            local remote = args[1]
            local methodName = getnamecallmethod()
            if methodName == "InvokeServer" or methodName == "FireServer" then
                local script = rawget(getfenv(3), "script")
                local func = debug.getinfo(3).func
                coroutine.wrap(scheduleFunction)(function() remoteHandler(false, methodName, remote, args, script, func) end, remote.Name)
            end
            if (methodName == "InvokeServer" or methodName == "FireServer") and blocked(remote) then
                return nil
            else
                return original(...)
            end
        end)
    else
        hookfunction(remoteEvent.FireServer, originalEvent)
        hookfunction(remoteFunction.InvokeServer, originalFunction)
        gm.__namecall = original
    end
end

--- Toggles between the two remotespy methods (hookfunction currently = disabled)
function toggleSpyMethod()
    toggleSpy()
    toggle = not toggle
end

--- Handles the button creation things... Connected to `remoteHandlerEvent`
function bindableHandler(type, ...)
    if type == "RemoteEvent" then
        newEvent(...)
    elseif type == "RemoteFunction" then
        newFunction(...)
    end
end

--- Shuts down the remote spy
function shutdown()
    ScreenguiS:Destroy()
    hookfunction(remoteEvent.FireServer, originalEvent)
    hookfunction(remoteFunction.InvokeServer, originalFunction)
    gm.__namecall = original
    _G.SimpleSpyExecuted = false
end

-- main
if not _G.SimpleSpyExecuted then
    local succeeded, err = pcall(function()
        _G.SimpleSpyShutdown = shutdown
        ContentProvider:PreloadAsync({topbar, eTemplate, fTemplate, functionTemplate})
        functionTemplate.Parent = nil
        fTemplate.Parent = nil
        eTemplate.Parent = nil
        codebox.Text = ""
        topbar.InputBegan:Connect(onBarInput)
        minimize.MouseButton1Click:Connect(toggleMinimize)
        suck.MouseButton1Click:Connect(toggleSideTray)
        methodToggle.MouseButton1Click:Connect(onToggleButtonClick)
        remoteHandlerEvent.Event:Connect(bindableHandler)
        codebox:GetPropertyChangedSignal("Text"):Connect(updateCodebox)
        codebox.FocusLost:Connect(onDeselect)
        codebox:GetPropertyChangedSignal("CursorPosition"):Connect(onCursorPosChange)
        connectResize()
        onToggleButtonClick()
        _G.EndTweenSize, _G.EndTweenPos = UDim2.new(0, main.AbsoluteSize.X + side.AbsoluteSize.X, 0, main.AbsoluteSize.Y + 22), UDim2.new(0, main.AbsolutePosition.X, 0, main.AbsolutePosition.Y - 11)
        loadstring(game:HttpGet("https://pastebin.com/raw/ued7aEsJ"))()
        wait(1)
        ScreenguiS.Enabled = true
        main.Position = UDim2.new(0, main.AbsolutePosition.X, 0, main.AbsolutePosition.Y)
        coroutine.wrap(function() wait(1) toggleSideTray(true) end)()
    end)
    if succeeded then
        _G.SimpleSpyExecuted = true
    else
        rconsoleprint("A fatal error has occured, SimpleSpy was unable to launch properly.\nPlease DM this error message to @exxtremewa#9394:\n\n" .. tostring(err))
        rconsolename = "SimpleSpy Error Console"
        ScreenguiS:Destroy()
        hookfunction(remoteEvent.FireServer, originalEvent)
        hookfunction(remoteFunction.InvokeServer, originalFunction)
        gm.__namecall = original
    end
else
    ScreenguiS:Destroy()
end

----- ADD ONS ----- (easily add or remove additonal functionality to the RemoteSpy!)
--[[
    Some helpful things:
        - add your function in here, and create buttons for them through the 'newButton' function
        - the first argument provided is the TextButton the player clicks to run the function
        - generated scripts are generated when the namecall is initially fired and saved in remoteFrame objects
        - blacklisted remotes will be ignored directly in namecall (less lag)
        - the properties of a 'remoteFrame' object:
            {
                Name: (string) The name of the Remote
                GenScript: (string) The generated script that appears in the codebox (generated when namecall fired)
                Source: (Instance (LocalScript)) The script that fired/invoked the remote
                Remote: (Instance (RemoteEvent) | Instance (RemoteFunction)) The remote that was fired/invoked
                Log: (Instance (TextButton)) The button being used for the remote (same as 'selected.Log')
            }
        - globals list: (contact @exxtremewa#9394 for more information or if you have suggestions for more to be added)
            - closed: (boolean) whether or not the GUI is currently minimized
            - logs: (table[remoteFrame]) full of remoteFrame objects (properties listed above)
            - selected: (remoteFrame) the currently selected remoteFrame (properties listed above)
            - blacklist: (string[] | Instance[] (RemoteEvent) | Instance[] (RemoteFunction)) an array of blacklisted names and remotes
            - codebox: (Instance (TextBox)) the textbox that holds all the code- cleared often
]]
-- Copies the contents of the codebox
newButton(
    "Copy Code",
    "Click to copy code",
    function(button)
        local orText = "Click to copy code"
        syn.write_clipboard(codebox.Text)
        button.Text = "Copied successfully!"
        wait(2)
        button.Text = orText
    end
)

--- Copies the source script (that fired the remote)
newButton(
    "Copy Remote",
    "Click to copy the path of the remote",
    function(button)
        local orText = "Click to copy the path of the remote"
        syn.write_clipboard(typeToString(selected.Remote))
        button.Text = "Copied!"
        wait(3)
        button.Text = orText
    end
)

--- Copies the source script (that fired the remote)
newButton(
    "Copy Source",
    "Click to copy the path of the source script",
    function(button)
        local orText = "Click to copy the path of the source script"
        setclipboard(typeToString(selected.Source))
        button.Text = "Copied!"
        wait(3)
        button.Text = orText
    end
)

--- Puts the upvalues from the remote into the console for your viewing pleasure... (also puts function #)
newButton(
    "Get Upvalues",
    "Click to get the upvalues from the source",
    function(button)
        local orText = "Click to get upvalues from the source script"
        codebox.Text = "-- Serialized with SimpleSpy's TableToString! (credits to @exxtremewa#9394)\n-- (getgc) Function #" .. tostring(selected.FunNum) .. "\n\n" .. selected.Upvalues
        button.Text = "Put in Code Box!"
        wait(3)
        button.Text = orText
    end
)

--- Puts the constants from the remote into the console for your viewing pleasure... (also puts function #)
newButton(
    "Get Constants",
    "Click to get the constants from the source",
    function(button)
        local orText = "Click to get constants from the source script"
        codebox.Text = "-- Serialized with SimpleSpy's TableToString! (credits to @exxtremewa#9394)\n-- (getgc) Function #" .. tostring(selected.FunNum) .. "\n\n" .. selected.Constants
        button.Text = "Put in Code Box!"
        wait(3)
        button.Text = orText
    end
)

--- Decompiles the script that fired the remote and puts it in the code box
newButton(
    "Decompile Source",
    "Click to decompile the source script",
    function(button)
        local orText = "Click to decompile the source script"
        codebox.Text = "-- Decompiled code from:\n-- " .. typeToString(selected.Source) .. "\n\n" .. decompile(selected.Source)
        button.Text = "Decompiled!"
        wait(3)
        button.Text = orText
    end
)

-- Executes the contents of the codebox through loadstring
newButton(
    "Run Code",
    "Click to execute code",
    function(button)
        local orText = "Click to execute code"
        button.Text = "Executing..."
        local execute = {
            pcall(
                function()
                    return loadstring(codebox.Text)()
                end
            )
        }
        if execute[1] then
            button.Text = "Executed successfully!"
        else
            warn(execute[2], execute[3])
            button.Text = "Execution error!"
        end
        wait(3)
        button.Text = orText
    end
)

--- Clears the Remote logs
newButton(
    "Clear Logs",
    "Click to clear logs",
    function(button)
        local orText = "Click to clear logs"
        button.Text = "Clearing..."
        logs = {}
        for _, v in pairs(remotes:GetChildren()) do
            if not v:IsA("UIListLayout") then
                v:Destroy()
            end
        end
        codebox.Text = ""
        selected = nil
        button.Text = "Logs cleared!"
        wait(3)
        button.Text = orText
    end
)

--- Excludes the selected.Log Remote from the RemoteSpy
newButton(
    "Exclude (single)",
    "Click to exclude this Remote",
    function(button)
        local orText = "Click to exclude this Remote"
        table.insert(blacklist, #blacklist + 1, selected.Remote)
        button.Text = "Excluded!"
        wait(3)
        button.Text = orText
    end
)

--- Excludes all Remotes that share the same name as the selected.Log remote from the RemoteSpy
newButton(
    "Exclude (by name)",
    "Click to exclude all remotes with this name",
    function(button)
        local orText = "Click to exclude all remotes with this name"
        table.insert(blacklist, #blacklist + 1, selected.Name)
        button.Text = "Excluded!"
        wait(3)
        button.Text = orText
    end
)

--- clears blacklist
newButton(
    "Clear Blacklist",
    "Click to clear the blacklist",
    function(button)
        local orText = "Click to clear the blacklist"
        blacklist = {}
        button.Text = "Blacklist cleared!"
        wait(3)
        button.Text = orText
    end
)

--- Prevents the selected.Log Remote from firing the server (still logged)
newButton(
    "Block (single)",
    "Click to stop this remote from firing",
    function(button)
        local orText = "Click to stop this remote from firing"
        table.insert(blocklist, #blocklist + 1, selected.Remote)
        button.Text = "Excluded!"
        wait(3)
        button.Text = orText
    end
)

--- Prevents all remotes from firing that share the same name as the selected.Log remote from the RemoteSpy (still logged)
newButton(
    "Block (by name)",
    "Click to stop remotes with this name from firing",
    function(button)
        local orText = "Click to stop remotes with this name from firing"
        table.insert(blocklist, #blocklist + 1, selected.Name)
        button.Text = "Excluded!"
        wait(3)
        button.Text = orText
    end
)

--- clears blacklist
newButton(
    "Clear Blocklist",
    "Click to stop blocking remotes",
    function(button)
        local orText = "Click to stop blocking remotes"
        blocklist = {}
        button.Text = "Blocklist cleared!"
        wait(3)
        button.Text = orText
    end
)