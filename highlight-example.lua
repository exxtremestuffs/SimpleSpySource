type highlightModule = {
	setRaw: (self: highlightModule, index: string) -> (),
	getRaw: (self: highlightModule) -> string,
	getTable: (self: highlightModule) -> {[number]: string},
	getSize: (self: highlightModule) -> number,
	getLine: (self: highlightModule, int: number) -> string, 
	setLine: (self: highlightModule, int: number, string) -> number,
	insertLine: (self: highlightModule, int: number, string) -> ()
}

return require(...) :: highlightModule
