require "lfs"
local cjson = require "cjson"
local consts = require "consts"

local readFile = function(filePath)
	local file = io.open(filePath, "rb")
	if not file then return false end
	local data = file:read("*all")
	file:close()
	return data
end

local writeFile = function(filePath, data)
	local file = io.open(filePath, "wb")
	if not file then return false end
	file:write(data)
	file:close()
end

return {
	loadHabits = function()
		habitsStr = readFile(consts.DATA_PATH)
		if not habitsStr then return false end
		return cjson.decode(habitsStr)
	end,
	saveHabits = function(habits)
		lfs.mkdir(consts.DATA_DIR)
		writeFile(consts.DATA_PATH, cjson.encode(habits))
	end
}

