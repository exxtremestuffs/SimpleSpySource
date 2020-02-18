local Highlight = require(...)

local myFrame = Instance.new("Frame")
--- Instantiates and returns a new Highlight instance- creates the actual gui within the frame
local myHighlight = Highlight.new(myFrame)

--- Sets the raw text of the code box (\n = new line, \t converted to spaces)
myHighlight:setRaw(string)

--- Returns the (string) raw text of the code box (\n = new line)
myHighlight:getRaw()

--- Sets the table to the specified array of strings
myHighlight:setTable(string[])

--- Returns the (string[]) array that holds all the lines in order as strings
myHighlight:getTable()

--- Returns the (int) number of lines in the code box
myHighlight:size()

--- Returns the (string) line of the specified line number
myHighlight:getLine(int)

--- Replaces the specified line number with the specified string (\n will overwrite further lines)
myHighlight:setLine(int, string)

--- Inserts a line made from the specified string and moves all existing lines down (\n will insert further lines)
myHighlight:insertLine(int, string)
