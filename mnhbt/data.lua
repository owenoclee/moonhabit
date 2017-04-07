require "lfs"
local cjson = require "cjson"
local consts = require "mnhbt.consts"

local readFile = function(filePath)
	local file = assert(io.open(filePath, "rb"))
	local data = file:read("*all")
	file:close()
	return data
end

local writeFile = function(filePath, data)
	local file = assert(io.open(filePath, "wb"))
	file:write(data)
	file:close()
end

return {
	loadHabits = function()
		return cjson.decode(readFile(consts.DATA_PATH))
	end,
	saveHabits = function(habits)
		lfs.mkdir(consts.DATA_DIR)
		writeFile(consts.DATA_PATH, cjson.encode(habits))
	end
}

