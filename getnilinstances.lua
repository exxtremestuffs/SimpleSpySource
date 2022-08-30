local getnilinstances = getfenv(0)['getnilinstances'] :: () -> {Instance}

if typeof(getnilinstances) ~= 'Instance' then
	return error("Invalid environment (missing getnilinstances).")
end

return function(name: string, class: string): {Instance}
	local instances = {}
	if typeof(name) == 'string' then
		for i, v in pairs(getnilinstances()) do
			if v.Name == name then
				table.insert(instances, v)
			end
		end
	elseif typeof(class) == 'string' then
		for i, v in pairs(getnilinstances()) do
			if v:IsA(class) then
				table.insert(instances, v)
			end
		end
	elseif typeof(name) == 'string' and typeof(class) == 'string' then
		for i, v in pairs(getnilinstances()) do
			if v.Name == name and v:IsA(class) then
				table.insert(instances, v)
			end
		end
	else
		instances = getnilinstances()
	end
	return instances
end
