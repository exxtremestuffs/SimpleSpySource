--[[
    SimpleSpy v1 SOURCE 

    Credits: 
        exx - basically everything
        Frosty - GUI to Lua
]]

-- shuts down the previous instance of SimpleSpy
if _G.SimpleSpyExecuted and type(_G.SimpleSpyShutdown) == "function" then
    _G.SimpleSpyShutdown()
end

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local Highlight = loadstring(game:HttpGet("https://github.com/exxtremestuffs/SimpleSpySource/raw/master/highlight.lua"))()

---- GENERATED (kinda sorta mostly) BY GUI to LUA ----

-- Instances:

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
if syn and syn.protect_gui then syn.protect_gui(SimpleSpy2) else warn("Unable to protect gui from recursive FindFirstChild, use Synapse for this features") end
SimpleSpy2.Parent = CoreGui
SimpleSpy2.ResetOnSpawn = false

Background.Name = "Background"
Background.Parent = SimpleSpy2
Background.BackgroundColor3 = Color3.new(1, 1, 1)
Background.BackgroundTransparency = 1
Background.Position = UDim2.new(0, 500, 0, 200)
Background.Size = UDim2.new(0, 450, 0, 268)

LeftPanel.Name = "LeftPanel"
LeftPanel.Parent = Background
LeftPanel.BackgroundColor3 = Color3.new(0.207843, 0.203922, 0.215686)
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
ColorBar.BackgroundColor3 = Color3.new(1, 0.94902, 0)
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
RightPanel.BackgroundColor3 = Color3.new(0.145098, 0.141176, 0.14902)
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
ScrollingFrame.Position = UDim2.new(0, 0, 0.476000011, 0)
ScrollingFrame.Size = UDim2.new(0, 319, 0, 131)
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
TopBar.BackgroundColor3 = Color3.new(0.145098, 0.141176, 0.14902)
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

-------------------------------------------------------------------------------
-- init
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ContentProvider = game:GetService("ContentProvider")
local TextService = game:GetService("TextService")
local Mouse = game:GetService("Players").LocalPlayer:GetMouse()

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
--- Whether or not to add getNil function
local getNil = false
--- Array of remotes (and original functions) connected to
local connectedRemotes = {}
--- True = hookfunction, false = namecall
local toggle = false
local gm = getrawmetatable(game)
local original = gm.__namecall
setreadonly(gm, false)
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
--- the maximum amount of remotes allowed in logs
_G.SIMPLESPYCONFIG_MaxRemotes = 500
--- how many spaces to indent
local indent = 4
--- used for task scheduler
local scheduled = {}
--- RBXScriptConnect of the task scheduler
local schedulerconnect
local SimpleSpy = {}
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

-- functions

--- Converts arguments to a string and generates code that calls the specified method with them, recommended to be used in conjunction with ValueToString (method must be a string, e.g. `game:GetService("ReplicatedStorage").Remote:FireServer`)
--- @param method string
--- @param args any[]
--- @return string
function SimpleSpy:ArgsToString(method, args)
    assert(typeof(method) == "string", "string expected, got " .. typeof(method))
    assert(typeof(args) == "table", "table expected, got " .. typeof(args))
    return v2v({args = args}) .. "\n\n" .. method .. "(unpack(args))"
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
    return v2v({[variablename] = value})
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
    return v2v{functionInfo = {
        info = debug.getinfo(func),
        constants = debug.getconstants(func)
    }}
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
    assert(typeof(remote) == "Instance" or typeof(remote) == "string", "Instance | string expected, got " .. typeof(remote))
    blocklist[remote] = true
end

--- Excludes the specified remote from logs (instance/string)
--- @param remote any
function SimpleSpy:ExcludeRemote(remote)
    assert(typeof(remote) == "Instance" or typeof(remote) == "string", "Instance | string expected, got " .. typeof(remote))
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
            return setmetatable({
                Disconnect = function()
                    if not connected then
                        warn("Signal is already closed")
                    end
                    connected[tostring(f)] = nil
                end
            },
            {
                __index = function(self, i)
                    if i == "Connected" then
                        return not not connected[tostring(f)]
                    end
                end
            })
        end,
        Fire = function(self, ...)
            for _, f in pairs(connected) do
                coroutine.wrap(f)(...)
            end
        end
    }
end

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

--- Scales the ToolTip to fit containing text
function scaleToolTip()
    local size = TextService:GetTextSize(TextLabel.Text, TextLabel.TextSize, TextLabel.Font, Vector2.new(196, math.huge))
    TextLabel.Size = UDim2.new(0, size.X, 0, size.Y)
    ToolTip.Size = UDim2.new(0, size.X + 4, 0, size.Y + 4)
end

--- Executed when the toggle button (the SimpleSpy logo) is hovered over
function onToggleButtonHover()
    if not toggle then
        TweenService:Create(Simple, TweenInfo.new(0.5), {TextColor3 = Color3.fromRGB(252, 51, 51)}):Play()
    else
        TweenService:Create(Simple, TweenInfo.new(0.5), {TextColor3 = Color3.fromRGB(68, 206, 91)}):Play()
    end
end

--- Executed when the toggle button is unhovered over
function onToggleButtonUnhover()
    TweenService:Create(Simple, TweenInfo.new(0.5), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end

--- Executed when the X button is hovered over
function onXButtonHover()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 60, 60)}):Play()
end

--- Executed when the X button is unhovered over
function onXButtonUnhover()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(37, 36, 38)}):Play()
end

--- Toggles the remote spy method (when button clicked)
function onToggleButtonClick()
    if toggle then
        TweenService:Create(Simple, TweenInfo.new(0.5), {TextColor3 = Color3.fromRGB(252, 51, 51)}):Play()
    else
        TweenService:Create(Simple, TweenInfo.new(0.5), {TextColor3 = Color3.fromRGB(68, 206, 91)}):Play()
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
    local currentX = Background.AbsolutePosition.X
    local currentY = Background.AbsolutePosition.Y
    local viewportSize = workspace.CurrentCamera.ViewportSize
    if (currentX < 0) or (currentX > (viewportSize.X - (sideClosed and 131 or 450))) then
        if currentX < 0 then
            currentX = 0
        else
            currentX = viewportSize.X - (sideClosed and 131 or 450)
        end
    end
    if (currentY < 0) or (currentY > (viewportSize.Y - (closed and 19 or 268) - 35)) then
        if currentY < 0 then
            currentY = 0
        else
            currentY = viewportSize.Y - (closed and 19 or 268) - 35
        end
    end
    TweenService.Create(TweenService, Background, TweenInfo.new(0.1), {Position = UDim2.new(0, currentX, 0, currentY)}):Play()
end

--- Drags gui (so long as mouse is held down)
function onBarInput(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local lastPos = UserInputService.GetMouseLocation(UserInputService)
        local mainPos = Background.AbsolutePosition
        local offset = mainPos - lastPos
        local currentPos = offset + lastPos
        RunService.BindToRenderStep(RunService, "drag", 1,
            function()
                local newPos = UserInputService.GetMouseLocation(UserInputService)
                if newPos ~= lastPos then
                    local currentX = (offset + newPos).X
                    local currentY = (offset + newPos).Y
                    local viewportSize = workspace.CurrentCamera.ViewportSize
                    if (currentX < 0 and currentX < currentPos.X) or (currentX > (viewportSize.X - (sideClosed and 131 or 450)) and currentX > currentPos.X) then
                        if currentX < 0 then
                            currentX = 0
                        else
                            currentX = viewportSize.X - (sideClosed and 131 or 450)
                        end
                    end
                    if (currentY < 0 and currentY < currentPos.Y) or (currentY > (viewportSize.Y - (closed and 19 or 268) - 35) and currentY > currentPos.Y) then
                        if currentY < 0 then
                            currentY = 0
                        else
                            currentY = viewportSize.Y - (closed and 19 or 268) - 35
                        end
                    end
                    currentPos = Vector2.new(currentX, currentY)
                    lastPos = newPos
                    TweenService.Create(TweenService, Background, TweenInfo.new(0.1), {Position = UDim2.new(0, currentPos.X, 0, currentPos.Y)}):Play()
                end
                if not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                    RunService.UnbindFromRenderStep(RunService, "drag")
                end
            end
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
                    BackgroundTransparency = v.BackgroundTransparency
                }
                TweenService:Create(v, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
                if v:IsA("TextBox") or v:IsA("TextButton") or v:IsA("TextLabel") then
                    data[v].TextTransparency = v.TextTransparency
                    TweenService:Create(v, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
                elseif v:IsA("ImageButton") or v:IsA("ImageLabel") then
                    data[v].ImageTransparency = v.ImageTransparency
                    TweenService:Create(v, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
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
                    BackgroundTransparency = i.BackgroundTransparency
                }
                i.BackgroundTransparency = 1
                TweenService:Create(i, TweenInfo.new(0.5), {BackgroundTransparency = properties.BackgroundTransparency}):Play()
                if i:IsA("TextBox") or i:IsA("TextButton") or i:IsA("TextLabel") then
                    properties.TextTransparency = i.TextTransparency
                    i.TextTransparency = 1
                    TweenService:Create(i, TweenInfo.new(0.5), {TextTransparency = properties.TextTransparency}):Play()
                elseif i:IsA("ImageButton") or i:IsA("ImageLabel") then
                    properties.ImageTransparency = i.ImageTransparency
                    i.ImageTransparency = 1
                    TweenService:Create(i, TweenInfo.new(0.5), {ImageTransparency = properties.ImageTransparency}):Play()
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
        TweenService:Create(LeftPanel, TweenInfo.new(0.5), {Size = UDim2.new(0, 131, 0, 0)}):Play()
        wait(0.5)
        remotesFadeIn = fadeOut(LeftPanel:GetDescendants())
        wait(0.5)
    else
        TweenService:Create(LeftPanel, TweenInfo.new(0.5), {Size = UDim2.new(0, 131, 0, 249)}):Play()
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
        TweenService:Create(RightPanel, TweenInfo.new(0.5), {Size = UDim2.new(0, 0, 0, 249)}):Play()
        TweenService:Create(TopBar, TweenInfo.new(0.5), {Size = UDim2.new(0, 131, 0, 19)}):Play()
        wait(0.5)
        RightPanel.Visible = false
    else
        if closed then
            toggleMinimize(true)
        end
        RightPanel.Visible = true
        TweenService:Create(RightPanel, TweenInfo.new(0.5), {Size = UDim2.new(0, 319, 0, 249)}):Play()
        TweenService:Create(TopBar, TweenInfo.new(0.5), {Size = UDim2.new(0, 450, 0, 19)}):Play()
        wait(0.5)
        if rightFadeIn then
            rightFadeIn()
        end
        bringBackOnResize()
    end
    sideClosing = false
end

--- Expands code box to fit screen for more convenient viewing
function toggleMaximize()
    if not sideClosed and not maximized then
        maximized = true
        local disable = Instance.new("TextButton")
        local prevSize = UDim2.new(0, CodeBox.AbsoluteSize.X, 0, CodeBox.AbsoluteSize.Y)
        local prevPos = UDim2.new(0,CodeBox.AbsolutePosition.X, 0, CodeBox.AbsolutePosition.Y)
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
        TweenService:Create(CodeBox, TweenInfo.new(0.5), {Size = UDim2.new(0.5, 0, 0.5, 0), Position = UDim2.new(0.25, 0, 0.25, 0)}):Play()
        TweenService:Create(disable, TweenInfo.new(0.5), {BackgroundTransparency = 0.5}):Play()
        disable.MouseButton1Click:Connect(function()
            if UserInputService:GetMouseLocation().Y + 36 >= CodeBox.AbsolutePosition.Y and UserInputService:GetMouseLocation().Y + 36 <= CodeBox.AbsolutePosition.Y + CodeBox.AbsoluteSize.Y
            and UserInputService:GetMouseLocation().X >= CodeBox.AbsolutePosition.X and UserInputService:GetMouseLocation().X <= CodeBox.AbsolutePosition.X + CodeBox.AbsoluteSize.X then
                return
            end
            TweenService:Create(CodeBox, TweenInfo.new(0.5), {Size = prevSize, Position = prevPos}):Play()
            TweenService:Create(disable, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            wait(0.5)
            disable:Destroy()
            CodeBox.Size = UDim2.new(1, 0, 0.5, 0)
            CodeBox.Position = UDim2.new(0, 0, 0, 0)
            CodeBox.ZIndex = 0
            maximized = false
        end)
    end
end

--- Gets the player an instance is descended from
function getPlayerFromInstance(instance)
    for _, v in pairs(Players:GetPlayers()) do
        if v.Character and (instance:IsDescendantOf(v.Character) or instance == v.Character) then
            return v
        end
    end
end

--- Runs on MouseButton1Click of an event frame
function eventSelect(frame)
    if selected and selected.Log  then
        TweenService:Create(selected.Log.Button, TweenInfo.new(0.5), {BackgroundColor3 = Color3.fromRGB(0, 0, 0)}):Play()
        selected = nil
    end
    for _, v in pairs(logs) do
        if frame == v.Log then
            selected = v
        end
    end
    if selected and selected.Log then
        TweenService:Create(frame.Button, TweenInfo.new(0.5), {BackgroundColor3 = Color3.fromRGB(92, 126, 229)}):Play()
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
--- @param text string
function makeToolTip(enable, text)
    if enable then
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
        TextLabel.Text = text
        ToolTip.Visible = true
    else
        ToolTip.Visible = false
        pcall(function() RunService:UnbindFromRenderStep("ToolTip") end)
    end
end

--- Creates new function button (below codebox)
function newButton(name, description, onClick)
    local button = FunctionTemplate:Clone()
    button.Text.Text = name
    button.Button.MouseEnter:Connect(function()
        makeToolTip(true, description)
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

--- Adds new Remote to logs
--- @param name string The name of the remote being logged
--- @param type string The type of the remote being logged (either 'function' or 'event')
--- @param gen_script any
--- @param remote any
--- @param function_info string
--- @param blocked any
function newRemote(type, name, gen_script, remote, function_info, blocked)
    local remoteFrame = RemoteTemplate:Clone()
    remoteFrame.Text.Text = name
    remoteFrame.ColorBar.BackgroundColor3 = type == "event" and Color3.new(255, 242, 0) or Color3.fromRGB(99, 86, 245)
    local id = Instance.new("IntValue")
    id.Name = "ID"
    id.Value = #logs + 1
    id.Parent = remoteFrame
    logs[#logs + 1] = {
        Name = name,
        GenScript = gen_script,
        Function = function_info,
        Remote = remote,
        Log = remoteFrame,
        Blocked = blocked,
    }
    if blocked then
        logs[#logs].GenScript = "-- THIS REMOTE WAS PREVENTED FROM FIRING THE SERVER BY SIMPLESPY\n\n" .. logs[#logs].GenScript
    end
    local connect = remoteFrame.Button.MouseButton1Click:Connect(function()
        eventSelect(remoteFrame)
    end)
    if layoutOrderNum < 1 then
        layoutOrderNum = 999999999
    end
    remoteFrame.LayoutOrder = layoutOrderNum
    layoutOrderNum = layoutOrderNum - 1
    remoteFrame.Parent = LogList
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
        if not pcall(function()
                gen = v2v({args = args}) .. "\n"
            end)
        then
            gen = gen .. "-- TableToString failure! Reverting to legacy functionality (results may vary)\nlocal args = {"
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
        if not remote:IsDescendantOf(game) and not getnilrequired then
            gen = "function getNil(name,class) for _,v in pairs(getnilinstances())do if v.ClassName==class and v.Name==name then return v;end end end\n\n" .. gen
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

--- value-to-string: value, string (out), level (indentation), parent table, var name, is from tovar
function v2s(v, l, p, n, vtv, i, pt, path, tables)
    if typeof(v) == "number" then
        if v == math.huge then
            return "math.huge"
        end
        return tostring(v)
    elseif typeof(v) == "boolean" then
        return tostring(v)
    elseif typeof(v) == "string" then
        return formatstr(v)
    elseif typeof(v) == "function" then
        return f2s(v)
    elseif typeof(v) == "table" then
        return t2s(v, l, p, n, vtv, i, pt, path, tables)
    elseif typeof(v) == "Instance" then
        return i2p(v)
    elseif typeof(v) == "userdata" then
        return "newproxy(true)"
    elseif type(v) == "userdata" then
        return u2s(v)
    else
        return "nil --[[" .. tostring(v) .. "]]"
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
            ret = ret .. "local " .. tostring(i):lower() .. "_" .. tostring(count) .. " = " .. v2s(v, nil, nil, tostring(i):lower() .. "_" .. tostring(count), true) .. "\n"
        else
            ret = ret .. "local " .. type(v) .. "_" .. tostring(count) .. " = " .. v2s(v, nil, nil, type(v) .. "_" .. tostring(count), true) .. "\n"
        end
        count = count + 1
    end
    if getnilrequired then
        topstr = "function getNil(name,class) for _,v in pairs(getnilinstances())do if v.ClassName==class and v.Name==name then return v;end end end\n" .. topstr
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
function t2s(t, l, p, n, vtv, i, pt, path, tables)
    for k, x in pairs(getrenv()) do
        local isgucci, gpath
        if rawequal(x, t) then
            isgucci, gpath = true, ""
        elseif type(x) == "table" then
            isgucci, gpath = v2p(t, x)
        end
        if isgucci then
            if type(k) == "string" and k:match("^[%a_]+[%w_]*$") then
                return k .. gpath
            else
                return "getrenv()[" .. v2s(k) .. "]" .. gpath
            end
        end
    end
    if not path then
        path = ""
    end
    if not l then
        l = 0
        tables = {}
    end
    if not p then
        p = t
    end
    for _, v in pairs(tables) do
        if n and rawequal(v, t) then
            bottomstr = bottomstr .. "\n" .. tostring(n) .. tostring(path) .. " = " .. tostring(n) .. tostring(({v2p(v, p)})[2])
            return "{} --[[DUPLICATE]]"
        end
    end
    table.insert(tables, t)
    local s =  "{"
    local size = 0
    l = l + indent
    for k, v in pairs(t) do
        size = size + 1
        if size > (_G.SimpleSpyMaxTableSize and _G.SimpleSpyMaxTableSize or 1000) then
            break
        end
        local currentPath = ""
        if type(k) == "string" and k:match("^[%a_]+[%w_]*$") then
            currentPath = "." .. k
        else
            currentPath = "[" .. v2s(k, nil, p, n, vtv, i, pt, path) .. "]"
        end
        s = s .. "\n" .. string.rep(" ", l) .. "[" .. v2s(k, l, p, n, vtv, k, t, path .. currentPath, tables) .. "] = " .. v2s(v, l, p, n, vtv, k, t, path .. currentPath, tables) .. ","
    end
    if #s > 1 then
        s = s:sub(1, #s - 1)
    end
    if size > 0 then
        s = s .. "\n" .. string.rep(" ", l - indent)
    end
    return s .. "}"
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
        if isgucci then
            if type(k) == "string" and k:match("^[%a_]+[%w_]*$") then
                return k .. gpath
            else
                return "getgenv()[" .. v2s(k) .. "]" .. gpath
            end
        end
    end
    -- uwu some cool stuff here once bork finishes up
    -- if SimpleSpy.GetExternalLoader then
    --     local ExternalLoader = SimpleSpy:GetExternalLoader()
    --     local loaded, path = pcall(function() ExternalLoader:LoadAsset("Bork_Functions") end)
    --     if loaded then
    --         local functions = loadfile(path .. "functions.lua")
    --         local out = functions[f]
    --         if out then
    --             return out
    --         end
    --     end
    -- end
    local isgucci, gpath = v2p(f, getgc())
    if isgucci then
        return "getgc()" .. gpath
    end
    if debug.getinfo(f).name:match("%w") then
        return "function()end --[[" .. debug.getinfo(f).name .. "]]"
    end
    return "function()end"
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
                    out = '[' .. formatstr(parent.Name) .. ']' .. out
                else
                    out = "." .. parent.Name .. out
                end
            end
            parent = parent.Parent
        end
    elseif parent ~= game then
        while true do
            if parent and parent.Parent == game then
                if game:GetService(parent.ClassName) then
                    if parent.ClassName == "Workspace" then
                        return "workspace" .. out
                    else
                        return 'game:GetService("' .. parent.ClassName .. '")' .. out
                    end
                else
                    if parent.Name:match("[%a_]+[%w_]*") then
                        return "game." .. parent.Name .. out
                    else
                        return 'game[' .. formatstr(parent.Name) .. ']' .. out
                    end
                end
            elseif parent.Parent == nil then
                getnilrequired = true
                return 'getNil(' .. formatstr(parent.Name) .. ', "' .. parent.ClassName .. '")' .. out
            elseif parent == Players.LocalPlayer then
                out = ".LocalPlayer" .. out
            else
                if parent.Name:match("[%a_]+[%w_]*") ~= parent.Name then
                    out = '[' .. formatstr(parent.Name) .. ']' .. out
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
        return "TweenInfo.new(" ..tostring(u.Time) .. ", Enum.EasingStyle." .. tostring(u.EasingStyle) .. ", Enum.EasingDirection." .. tostring(u.EasingDirection) .. ", " .. tostring(u.RepeatCount) .. ", " .. tostring(u.Reverses) .. ", " .. tostring(u.DelayTime) .. ")"
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
    elseif typeof(u) == "RBXScriptConnection" then
        return "nil --[[RBXScriptConnection]]"
    else
        return typeof(u) .. ".new(" .. tostring(u) .. ")"
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
function formatstr(s)
    return '"' .. handlespecials(s) .. '"'
end

--- Adds \'s to the text as a replacement to whitespace chars and other things because string.format can't yayeet
function handlespecials(s)
    local i = 0
    repeat
        i = i + 1
        local char = s:sub(i, i)
        if string.byte(char) then
            if char == "\n" then
                s = s:sub(0, i - 1) .. "\\n" .. s:sub(i + 1, -1)
                i = i + 1
            elseif char == "\t" then
                s = s:sub(0, i - 1) .. "\\t" .. s:sub(i + 1, -1)
                i = i + 1
            elseif char == "\\" then
                s = s:sub(0, i - 1) .. "\\\\" .. s:sub(i + 1, -1)
                i = i + 1
            elseif char == '"' then
                s = s:sub(0, i - 1) .. '\\"' .. s:sub(i + 1, -1)
                i = i + 1
            elseif string.byte(char) > 126 or string.byte(char) < 32 then
                s = s:sub(0, i - 1) .. "\\" .. string.byte(char) .. s:sub(i + 1, -1)
                i = i + #tostring(string.byte(char))
            end
        end
    until char == ""
    return s
end

--- schedules the provided function (and calls it with any args after)
function schedule(f, ...)
    table.insert(scheduled, {f, ...})
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
function remoteHandler(hookfunction, methodName, remote, args, func)
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
            history[remote] = {badOccurances = 0, lastCall = tick()}
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
    if func and islclosure(func) then
        local functionInfo = {}
        pcall(function() functionInfo.info = debug.getinfo(func) end)
        pcall(function() functionInfo.constants = debug.getconstants(func) end)
        pcall(function() functionInfoStr = v2v{functionInfo = functionInfo} end)
    end
    if methodName:lower() == "fireserver" and not (blacklist[remote] or blacklist[remote.Name]) then
        bindableHandler("event", remote.Name, genScript(remote, table.unpack(args)), remote, functionInfoStr, (blocklist[remote] or blocklist[remote.Name]))
    elseif methodName:lower() == "invokeserver" and not (blacklist[remote] or blacklist[remote.Name]) then
        bindableHandler("function", remote.Name, genScript(remote, table.unpack(args)), remote, functionInfoStr, (blocklist[remote] or blocklist[remote.Name]))
    end
end

--- Used for hookfunction
function hookRemote(remoteType, remote, ...)
    local args = {...}
    if remoteHooks[remote] then
        args = remoteHooks[remote](args)
    end
    if typeof(remote) == "Instance" then
        local func = funcEnabled and debug.getinfo(4).func or nil
        schedule(remoteHandler, true, remoteType == "RemoteEvent" and "fireserver" or "invokeserver", remote, args, func)
        if (blocklist[remote] or blocklist[remote.Name]) then
            return
        end
    end
    if remoteType == "RemoteEvent" then
        if remoteHooks[remote] then
            return originalEvent(remote, unpack(args))
        end
        return originalEvent(remote, ...)
    else
        if remoteHooks[remote] then
            return originalFunction(remote, unpack(args))
        end
        return originalFunction(remote, ...)
    end
end

local newnamecall = newcclosure(function(...)
    local args = {...}
    local methodName = getnamecallmethod()
    local remote = args[1]
    if methodName:lower() == "invokeserver" or methodName:lower() == "fireserver" then
        if remoteHooks[remote] then
            args = remoteHooks[remote]({unpack(args, 2)})
            table.insert(args, 1, remote)
        end
        local func = funcEnabled and debug.getinfo(3).func or nil
        coroutine.wrap(function()
            schedule(remoteHandler, false, methodName, remote, {unpack(args, 2)}, func)
        end)()
    end
    if typeof(remote) == "Instance" and (methodName:lower() == "invokeserver" or methodName:lower() == "fireserver") and (blocklist[remote] or blocklist[remote.Name]) then
        return nil
    elseif (methodName:lower() == "invokeserver" or methodName:lower() == "fireserver") and remoteHooks[remote] then
        return original(unpack(args))
    else
        return original(...)
    end
end)

local newFireServer = newcclosure(function(...) return hookRemote("RemoteEvent", ...) end)

local newInvokeServer = newcclosure(function(...) return hookRemote("RemoteFunction", ...) end)

--- Toggles on and off the remote spy
function toggleSpy()
    if not toggle then
        setreadonly(gm, false)
        if not original then
            original = gm.__namecall
            if not original then
                warn("SimpleSpy: namecall method not found!\n")
                onToggleButtonClick()
                return
            end
        end
        gm.__namecall = newnamecall
        originalEvent = hookfunction(remoteEvent.FireServer, newFireServer)
        originalFunction = hookfunction(remoteFunction.InvokeServer, newInvokeServer)
    else
        setreadonly(gm, false)
        gm.__namecall = original
        hookfunction(remoteEvent.FireServer, originalEvent)
        hookfunction(remoteFunction.InvokeServer, originalFunction)
    end
end

--- Toggles between the two remotespy methods (hookfunction currently = disabled)
function toggleSpyMethod()
    toggleSpy()
    toggle = not toggle
end

--- Handles the button creation things... Connected to `remoteHandlerEvent`
function bindableHandler(...)
    -- syn.set_thread_identity(7)
    newRemote(...)
end

--- Shuts down the remote spy
function shutdown()
    if schedulerconnect then
        schedulerconnect:Disconnect()
    end
    setreadonly(gm, false)
    SimpleSpy2:Destroy()
    hookfunction(remoteEvent.FireServer, originalEvent)
    hookfunction(remoteFunction.InvokeServer, originalFunction)
    gm.__namecall = original
    _G.SimpleSpyExecuted = false
end

-- main
if not _G.SimpleSpyExecuted then
    local succeeded, err = pcall(function()
        _G.SimpleSpyShutdown = shutdown
        onToggleButtonClick()
        RemoteTemplate.Parent = nil
        FunctionTemplate.Parent = nil
        codebox = Highlight.new(CodeBox)
        codebox:setRaw("")
        getgenv().SimpleSpy = SimpleSpy
        TextLabel:GetPropertyChangedSignal("Text"):Connect(scaleToolTip)
        TopBar.InputBegan:Connect(onBarInput)
        MinimizeButton.MouseButton1Click:Connect(toggleMinimize)
        MaximizeButton.MouseButton1Click:Connect(toggleSideTray)
        Simple.MouseButton1Click:Connect(onToggleButtonClick)
        CloseButton.MouseEnter:Connect(onXButtonHover)
        CloseButton.MouseLeave:Connect(onXButtonUnhover)
        Simple.MouseEnter:Connect(onToggleButtonHover)
        Simple.MouseLeave:Connect(onToggleButtonUnhover)
        CloseButton.MouseButton1Click:Connect(shutdown)
        connectResize()
        SimpleSpy2.Enabled = true
        coroutine.wrap(function()
            wait(1)
            onToggleButtonUnhover()
        end)()
        schedulerconnect = RunService.Heartbeat:Connect(taskscheduler)
    end)
    if succeeded then
        _G.SimpleSpyExecuted = true
    else
        warn("A fatal error has occured, SimpleSpy was unable to launch properly.\nPlease DM this error message to @exx#9394:\n\n" .. tostring(err))
        SimpleSpy2:Destroy()
        hookfunction(remoteEvent.FireServer, originalEvent)
        hookfunction(remoteFunction.InvokeServer, originalFunction)
        gm.__namecall = original
        return
    end
else
    SimpleSpy2:Destroy()
    return
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
        - globals list: (contact @exx#9394 for more information or if you have suggestions for more to be added)
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
        setclipboard(codebox:getString())
        TextLabel.Text = "Copied successfully!"
        wait(2)
        TextLabel.Text = orText
    end
)

--- Copies the source script (that fired the remote)
newButton(
    "Copy Remote",
    "Click to copy the path of the remote",
    function(button)
        if selected then
            local orText = "Click to copy the path of the remote"
            setclipboard(v2s(selected.Remote))
            TextLabel.Text = "Copied!"
        end
    end
)

-- Executes the contents of the codebox through loadstring
newButton(
    "Run Code",
    "Click to execute code",
    function(button)
        local orText = "Click to execute code"
        TextLabel.Text = "Executing..."
        local execute = {
            pcall(
                function()
                    return loadstring(codebox:getString())()
                end
            )
        }
        if execute[1] then
            TextLabel.Text = "Executed successfully!"
        else
            warn(execute[2], execute[3])
            TextLabel.Text = "Execution error!"
        end
        wait(3)
        TextLabel.Text = orText
    end
)
--- Decompiles the script that fired the remote and puts it in the code box
newButton(
    "Function Info",
    "Click to view calling function information",
    function(button)
        if selected then
            local orText = "Click to view calling function information"
            if selected.Function then
                codebox:setRaw("-- Calling function info\n-- Generated by the SimpleSpy serializer\n\n" .. tostring(selected.Function))
            end
            TextLabel.Text = "Done!"
            wait(3)
            TextLabel.Text = orText
        end
    end
)

--- Clears the Remote logs
newButton(
    "Clr Logs",
    "Click to clear logs",
    function(button)
        local orText = "Click to clear logs"
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
        wait(3)
        TextLabel.Text = orText
    end
)

--- Excludes the selected.Log Remote from the RemoteSpy
newButton(
    "Exclude (i)",
    "Click to exclude this Remote",
    function(button)
        if selected then
            local orText = "Click to exclude this Remote"
            blacklist[selected.Remote] = true
            TextLabel.Text = "Excluded!"
            wait(3)
            TextLabel.Text = orText
        end
    end
)

--- Excludes all Remotes that share the same name as the selected.Log remote from the RemoteSpy
newButton(
    "Exclude (n)",
    "Click to exclude all remotes with this name",
    function(button)
        if selected then
            local orText = "Click to exclude all remotes with this name"
            blacklist[selected.Name] = true
            TextLabel.Text = "Excluded!"
            wait(3)
            TextLabel.Text = orText
        end
    end
)

--- clears blacklist
newButton(
    "Clr Blacklist",
    "Click to clear the blacklist",
    function(button)
        local orText = "Click to clear the blacklist"
        blacklist = {}
        TextLabel.Text = "Blacklist cleared!"
        wait(3)
        TextLabel.Text = orText
    end
)

--- Prevents the selected.Log Remote from firing the server (still logged)
newButton(
    "Block (i)",
    "Click to stop this remote from firing",
    function(button)
        if selected then
            local orText = "Click to stop this remote from firing"
            blocklist[selected.Remote] = true
            TextLabel.Text = "Excluded!"
            wait(3)
            TextLabel.Text = orText
        end
    end
)

--- Prevents all remotes from firing that share the same name as the selected.Log remote from the RemoteSpy (still logged)
newButton(
    "Block (n)",
    "Click to stop remotes with this name from firing",
    function(button)
        if selected then
            local orText = "Click to stop remotes with this name from firing"
            blocklist[selected.Name] = true
            TextLabel.Text = "Excluded!"
            wait(3)
            TextLabel.Text = orText
        end
    end
)

--- clears blacklist
newButton(
    "Clr Blocklist",
    "Click to stop blocking remotes",
    function(button)
        local orText = "Click to stop blocking remotes"
        blocklist = {}
        TextLabel.Text = "Blocklist cleared!"
        wait(3)
        TextLabel.Text = orText
    end
)

newButton(
    "Disable Info",
    "Toggle function info (because it can cause lag in some games)",
    function()
        funcEnabled = not funcEnabled
        TextLabel.Text = "Toggle function info (because it can cause lag in some games) - " .. (funcEnabled and "ENABLED" or "DISABLED")
    end
)

newButton(
    "Autoblock",
    "[BETA] Intelligently detects and excludes spammy remote calls from logs",
    function()
        autoblock = not autoblock
        TextLabel.Text = "[BETA] Intelligently detects and excludes spammy remote calls from logs - " .. (autoblock and "ENABLED" or "DISABLED")
        history = {}
        excluding = {}
    end
)