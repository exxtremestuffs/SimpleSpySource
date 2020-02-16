--[[
    higlight.lua v0.1 by exxtremewa#9394
    
     - uses the power of fancy gradient api shenanigans to do line-based syntax higlighting
     - is cool
]]

local Highlight = {}

local constructor = {}
--- responsible for instantiation
function constructor.new(...)
    local class = Highlight
    local new = {}
    class.__index = class
    setmetatable(new, class)
    return new
end

return constructor