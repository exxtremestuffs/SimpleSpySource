type highlightModule = {
	setRaw: (self: highlightModule, index: string) -> (), -- # undocumented
	getRaw: (self: highlightModule) -> string, -- # undocumented
	getTable: (self: highlightModule) -> {[number]: string}, -- # get all existing lines
	getSize: (self: highlightModule) -> number, -- # get list size
	getLine: (self: highlightModule, int: number) -> string,  -- # get existing line by id
	setLine: (self: highlightModule, int: number, string) -> number, -- # create/modify new line with existing/no behavior
	insertLine: (self: highlightModule, int: number, string) -> () -- # create a new line with internal behavior
}

return require(...) :: highlightModule
