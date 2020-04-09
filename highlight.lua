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
    Char Object:
    {
        Char: string -- A single character
        Color: Color3 -- The intended color of the char
    }
]]

--- Contents of the table- array of char objects
local tableContents = {}

--- Whether or not the previous line had an unfinished string
local continuingString = false

local backgroundColor = Color3.fromRGB(40, 44, 52)
local operatorColor = Color3.fromRGB(198, 120, 221)
local functionColor = Color3.fromRGB(97, 175, 239)
local stringColor = Color3.fromRGB(152, 195, 121)
local numberColor = Color3.fromRGB(209, 154, 102)
local objectColor = Color3.fromRGB(229, 192, 123)
local defaultColor = Color3.fromRGB(204, 160, 163)

local operators = {"function", "local", "if", "for", "while", "then", "do", "else", "elseif", "return", "end", "=", ">", "~", "<"}
local strings = {{pattern = "", char = "\""}, {pattern = "", char = "\'"}}

--- Find iterator
function gfind(str, pattern)
    local currentSub = str
    return function()
        local findStart, findEnd = currentSub:find(pattern)
        if findStart and findEnd and findEnd ~= #str then
            currentSub = currentSub:sub(findEnd + 1, #currentSub)
            return findStart, findEnd
        else
            return nil
        end
    end
end

-- Finds and highlights operators with `operatorColor`
function renderOperators()
    local str = Highlight:getRaw()
    for _, operator in pairs(operators) do
        for findStart, findEnd in gfind(str, operator) do
            for i = findStart, findEnd do
                tableContents[i].Color = operatorColor
            end
        end
    end
end

-- Finds and highlights strings with `stringColor`
function renderStrings()
    local str = Highlight:getRaw()
    for _, s in pairs(strings) do
        for findStart, findEnd in gfind(str, s.pattern) do
            if str:sub(findEnd - 1) == "\\" then
                _, findEnd = str:sub(findEnd + 1, #str)
                if not findEnd then
                    findEnd = #str
                end
            end
            for i = findStart, findEnd do
                tableContents[i].Color = stringColor
            end
        end
    end
end

--- Main function for syntax highlighting tableContents
function render()
    for _, char in pairs(tableContents) do
        char.Color = defaultColor
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
    local result = ""
    for _, char in pairs(tableContents) do
        result = result .. char.Char
    end
    return result
end

--- Returns the (char[]) array that holds all the lines in order as strings
--- @return string[]
function Highlight:getTable()
    return tableContents
end

--- Returns the (int) number of lines in the code box
--- @return number
function Highlight:size()
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
