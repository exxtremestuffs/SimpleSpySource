-- --[[
-- 	SimpleSpyIntro.lua

-- 	ooh fancy, but this is just a fancy intro graphic, not really much else...
-- ]]

-- local TweenService = game:GetService("TweenService")
-- local TextService = game:GetService("TextService")
-- local CoreGui = game:GetService("CoreGui")
-- local ContentProvider = game:GetService("ContentProvider")

-- local endTweenSize, endTweenPos = _G.EndTweenSize, _G.EndTweenPos
-- local intro = Instance.new("ScreenGui")
-- local background = Instance.new("ImageLabel")
-- local newbackground = Instance.new("ImageLabel")
-- local s = Instance.new("TextLabel")

-- intro.Name = "intro"
-- intro.Parent = CoreGui
-- intro.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
-- intro.DisplayOrder = 999999999

-- background.Name = "background"
-- background.Parent = intro
-- background.BackgroundColor3 = Color3.new(1, 1, 1)
-- background.BackgroundTransparency = 1
-- background.BorderSizePixel = 0
-- background.Position = UDim2.new(0.5, 0, 0.5, 0)
-- background.ZIndex = 0
-- background.Image = "http://www.roblox.com/asset/?id=4806127241"

-- newbackground.Name = "newbackground"
-- newbackground.Parent = background
-- newbackground.BackgroundColor3 = Color3.new(1, 1, 1)
-- newbackground.BackgroundTransparency = 1
-- newbackground.Position = UDim2.new(0.5, 0, 0.5, 0)
-- newbackground.ZIndex = 0
-- newbackground.Image = "http://www.roblox.com/asset/?id=4806127241"

-- s.Name = "S"
-- s.Parent = background
-- s.BackgroundColor3 = Color3.new(1, 1, 1)
-- s.BackgroundTransparency = 1
-- s.Size = UDim2.new(1, 0, 1, 0)
-- s.Font = Enum.Font.SourceSansSemibold
-- s.Text = "S"
-- s.TextColor3 = Color3.new(1, 1, 1)
-- s.TextSize = 100
-- s.TextWrapped = true

-- local s2 = s:Clone()
-- local backgroundExpandTween = TweenService:Create(background, TweenInfo.new(0.2), {Position = UDim2.new(0.5, -150, 0.5, -150), Size = UDim2.new(0, 300, 0, 300)})
-- local expandTween = TweenService:Create(newbackground, TweenInfo.new(0.2), {Position = UDim2.new(), Size = UDim2.new(1, 0, 1, 0)})
-- local colors = {Color3.fromRGB(153, 153, 153), Color3.fromRGB(128, 128, 128), Color3.fromRGB(102, 102, 102), Color3.fromRGB(77, 77, 77), Color3.fromRGB(51, 51, 51)}
-- local yellow = Color3.fromRGB(255, 242, 0)
-- local purple = Color3.fromRGB(156, 77, 214)
-- local white = Color3.fromRGB(255, 255, 255)
-- local minSize = background.Size
-- local minPos = background.Position

-- function retract()
-- 	newbackground.Position = UDim2.new(0.5, 0, 0.5, 0)
-- 	newbackground.Size = UDim2.new()
-- 	newbackground.Visible = false
-- end

-- ContentProvider:PreloadAsync({background})

-- backgroundExpandTween:Play()
-- wait(0.1)

-- for _, v in pairs(colors) do
-- 	newbackground.ImageColor3 = v
-- 	newbackground.Visible = true
-- 	expandTween:Play()
-- 	wait(0.2)
-- 	background.ImageColor3 = v
-- 	retract()
-- end

-- s2.Parent = s.Parent

-- TweenService:Create(s, TweenInfo.new(1), {Position = UDim2.new(0, -95, 0, -50), TextColor3 = yellow}):Play()
-- TweenService:Create(s2, TweenInfo.new(1), {Position = UDim2.new(0, -45, 0, 50), TextColor3 = purple}):Play()

-- local simpleWhite = s:Clone()
-- simpleWhite.TextColor3 = white
-- simpleWhite.Text = "imple"
-- simpleWhite.Position = UDim2.new(0, -95 + TextService:GetTextSize("Simple", 100, Enum.Font.SourceSansSemibold, s.AbsoluteSize).X / 2, 0, -50)
-- simpleWhite.ZIndex = 0
-- simpleWhite.TextTransparency = 1
-- simpleWhite.Parent = background

-- local spyWhite = s2:Clone()
-- spyWhite.TextColor3 = white
-- spyWhite.Text = "py"
-- spyWhite.Position = UDim2.new(0, -45 + TextService:GetTextSize("Spy", 100, Enum.Font.SourceSansSemibold, s2.AbsoluteSize).X / 2, 0, 50)
-- spyWhite.ZIndex = 0
-- spyWhite.TextTransparency = 1
-- spyWhite.Parent = background

-- TweenService:Create(simpleWhite, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
-- TweenService:Create(spyWhite, TweenInfo.new(0.5), {TextTransparency = 0}):Play()

-- wait(0.5)

-- TweenService:Create(s, TweenInfo.new(0.25), {TextColor3 = white}):Play()
-- TweenService:Create(s2, TweenInfo.new(0.25), {TextColor3 = white}):Play()

-- wait(0.25)

-- TweenService:Create(s, TweenInfo.new(0.15), {TextTransparency = 1}):Play()
-- TweenService:Create(s2, TweenInfo.new(0.15), {TextTransparency = 1}):Play()
-- TweenService:Create(simpleWhite, TweenInfo.new(0.15), {TextTransparency = 1}):Play()
-- TweenService:Create(spyWhite, TweenInfo.new(0.15), {TextTransparency = 1}):Play()

-- if typeof(endTweenSize) == "UDim2" and typeof(endTweenPos) == "UDim2" then
-- 	TweenService:Create(background, TweenInfo.new(0.5), {Size = endTweenSize, Position = endTweenPos}):Play()
-- else
-- 	TweenService:Create(background, TweenInfo.new(0.5), {Size = minSize, Position = minPos}):Play()
-- end

-- wait(0.15)

-- TweenService:Create(background, TweenInfo.new(0.5), {Size = endTweenSize, Position = endTweenPos}):Play()

-- coroutine.wrap(function()
-- 	wait(0.5)
-- 	TweenService:Create(background, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
-- 	wait(0.5)
-- 	intro:Destroy()
-- end)()