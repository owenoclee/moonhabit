local date = require "mnhbt.date"
local meta = require "mnhbt.meta"
local consts = require "mnhbt.consts"

local COMMANDS = {
	add = {
		arity = 1,
		run = function(habits, name)
			habits[name] = habits[name] or {}
		end
	},
	rm = {
		arity = 1,
		run = function(habits, name)
			habits[name] = nil
		end
	},
	check = {
		arity = 1,
		run = function(habits, name)
			if not meta.indexOf(habits[name], date.today()) then
				table.insert(habits[name], date.today())
			end
		end
	},
	uncheck = {
		arity = 1,
		run = function(habits, name)
			idx = meta.indexOf(habits[name], date.today())
			if idx then
				table.remove(habits[name], idx)
			end
		end
	},
	display = {
		arity = 1,
		run = function(habits, name)
			for _, v in pairs(habits[name]) do
				print(v)
			end
		end
	},
	ls = {
		arity = 0,
		run = function(habits)
			for k, _ in pairs(habits) do
				print(string.format("%s: %d day streak. %d recorded events.", k,
						meta.getStreak(habits[k]), #habits[k]))
			end
		end
	}
}

-- fallback command: help
setmetatable(COMMANDS, {
	__index = function()
		return {
			arity = 0,
			run = function()
				print("Usage: " .. consts.APP_NAME .. " <command> [<args>]\n\n" ..
						"Commands:\n" ..
						"    add                Add a new habit\n" ..
						"    rm                 Remove a habit\n" ..
						"    check              Check off a habit\n" ..
						"    uncheck            Uncheck a habit\n" ..
						"    display            Display details about a habit\n" ..
						"    ls                 List all habits")
			end
		}
	end
})

return {
	tryRun = function(command, args, habits)
		if #args > COMMANDS[command].arity then
			return false, "Too many arguments"
		elseif #args < COMMANDS[command].arity then
			return false, "Insufficient arguments"
		end
		COMMANDS[command].run(habits, unpack(args))
		return true
	end
}
