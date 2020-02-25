--[[
    higlight.lua v0.1 by exxtremewa#9394
    
     - uses the power of fancy gradient api shenanigans to do line-based syntax higlighting
     - is cool
]]

local TextService = game:GetService("TextService")
--- The metatable of the Highlight class
local HighlightMeta = {}
--- The Highlight class
--- @class Highlight
local Highlight = {}

-- PRIVATE METHODS/PROPERTIES --

--[[
    Line Interface:
    {
        Line: number - Line number
        Text: Instance (TextBox) - TextBox for the line
        Gradient: Instance (UIGradient) - UIGradient responsible for syntax highlighting
        Colors: {
            [LetterNumber: number] = Color: Color3
        }[]
    }
]]
local tableContents = {}

--- Whether or not the previous line had an unfinished string
local continuingString = false

local backgroundColor = Color3.fromRGB(40, 44, 52)
local operatorColor = Color3.fromRGB(198, 120, 221)
local functionColor = Color3.fromRGB(97, 175, 239)
local stringColor = Color3.fromRGB(152, 195, 121)
local numberColor = Color3.fromRGB(209, 154, 102)
local objectColor = Color3.fromRGB(229, 192, 123)
local defaultColor = Color3.fromRGB(224, 108, 117)

--- Table of string patterns and colors (prioritizes whichever is first)
local colorStrings = {
    ["function"] =  {"function", operatorColor},
    ["local"] = {"local", operatorColor},
    ["end"] = {"end", operatorColor},
    ["if"] = {"if", operatorColor},
    ["for"] = {"for", operatorColor},
    ["in"] = {"in", operatorColor},
    ["do"] = {"do", operatorColor},
    ["then"] = {"then", operatorColor},
    ["else"] = {"else", operatorColor},
    ["elseif"] = {"elseif", operatorColor},
    ["%a+("] = {"%a+", functionColor},
    ["%a+.+("] = {"%a+", functionColor},
    -- ["%b\"\""] = {"%b\"\"", stringColor}, Strings have to be handled directly in the function
    ["%d+"] = {"%d+", numberColor},
    ["%w+"] = {"%w+", numberColor},
}

--- Creates new Line (see interface above)
--- @param line number
---@param textContent string
--- @return Line
function newLine(line, textContent)
    local textBox = Instance.new("TextBox")
    textBox.Name = line
    textBox.Text = textContent
    textBox.BackgroundTransparency = 1
    textBox.TextSize = 14
    local gradient = Instance.new("UIGradient")
    gradient.Parent = textBox
    return {
        Line = line,
        Text = textBox,
        Gradient = gradient
    }
end

--- Creates and syntax highlights lines from provided data (array of Line objects)
--- @param data Line[]
function render(data)
    if typeof(data) == "table" then
        for i, v in pairs(data) do
            
        end
    else
        error("Incorrect data sent: of type " .. typeof(data))
    end
end

--- Syntax highlights single line (not for individual use)
--- @param line number
function highlightLine(line)
    
end

--- Syntax highlights code
function highlightEditor()
    local full = ""
    local matchLocations = {}
    for _, v in pairs(tableContents) do
        local text = " " .. v.Text.Text .. " "
        for i, v2 in pairs(colorStrings) do
            for _, v3 in v:match("") do
                
            end
        end
    end
    for i, _ in pairs(tableContents) do
        highlightLine(i)
    end
end

-- PUBLIC METHODS --

--- Runs when a new object is instantiated
--- @param frame Frame
function Highlight:init(frame)
    if typeof(frame) == "Instance" and frame:IsA("Frame") then

    else
        error("Initialization error: argument " .. tostring(frame) .. " is not a Frame Instance")
    end
end

--- Sets the raw text of the code box (\n = new line, \t converted to spaces)
--- @param raw string
function Highlight:setRaw(raw)

end

--- Returns the (string) raw text of the code box (\n = new line)
--- @return string
function Highlight:getRaw()

end

--- Sets the table to the specified array of strings
--- @param lineArray string[]
function Highlight:setTable(lineArray)

end

--- Returns the (string[]) array that holds all the lines in order as strings
--- @return string[]
function Highlight:getTable()

end

--- Returns the (int) number of lines in the code box
--- @return number
function Highlight:size()

end

--- Returns the (string) line of the specified line number
--- @param line number
--- @return string
function Highlight:getLine(line)

end

--- Replaces the specified line number with the specified string (\n will overwrite further lines)
--- @param line number
---@param text string
function Highlight:setLine(line, text)

end

--- Inserts a line made from the specified string and moves all existing lines down (\n will insert further lines)
--- @param line number
---@param text string
function Highlight:insertLine(line, text)

end

local oldIndex = HighlightMeta.__index
--- @param table table
---@param key any
HighlightMeta.__index = function(table, key)
    local old = {oldIndex()}
    if typeof(key) == "string" then

    end
    return unpack(old)
end

setmetatable(Highlight, HighlightMeta)

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

--- @class Frame
--- @class Line
