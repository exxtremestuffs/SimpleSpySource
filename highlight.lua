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

<<<<<<< HEAD
-- PRIVATE METHODS/PROPERTIES --

--[[
    Line Interface:
    {
        Line: number - Line number
        Text: Instance (TextBox) - TextBox for the line
        Gradient: Instance (UIGradient) - UIGradient responsible for syntax highlighting
    }
]]
local tableContents = {}

--- Creates new Line (see interface above)
--- @param line number
---@param textContent string
--- @return Line
function newLine(line, textContent)
    local textBox = Instance.new("TextBox")
    textBox.Name = line
    textBox.Text = textContent

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
    for i, _ in pairs(tableContents) do
        highlightLine(i)
    end
end

-- PUBLIC METHODS --

=======
>>>>>>> parent of 5c8d9b4... added public/private
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
