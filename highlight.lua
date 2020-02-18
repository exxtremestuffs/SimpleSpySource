--[[
    higlight.lua v0.1 by exxtremewa#9394
    
     - uses the power of fancy gradient api shenanigans to do line-based syntax higlighting
     - is cool
]]

--- The metatable of the Highlight class
local HighlightMeta = {}
--- The Highlight class
--- @class Highlight
local Highlight = {}

-- PRIVATE METHODS/PROPERTIES --

local renderTable = {}

function render()
    
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
