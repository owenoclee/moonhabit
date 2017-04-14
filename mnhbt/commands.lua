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
	history = {
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
				print(k)
			end
		end
	},
	status = {
		arity = 1,
		optionalArgs = true,
		run = function(habits, name)
			local subHabits = habits
			if name then
				subHabits = { [name] = habits[name] }
			end
			for k, _ in pairs(subHabits) do
				local cross = "x"
				if not meta.indexOf(subHabits[k], date.today()) then
					cross = " "
				end
				print(string.format("[%s] %s: %d day streak." ..
						" %d recorded events.", cross, k,
						meta.getStreak(subHabits[k]), #subHabits[k]))
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
						"    history            See history of a habit\n" ..
						"    ls                 List all habits\n" ..
						"    status             Check status of habits")
			end
		}
	end
})

return {
	tryRun = function(command, args, habits)
		if #args > COMMANDS[command].arity then
			return false, "Too many arguments"
		elseif #args < COMMANDS[command].arity and not COMMANDS[command].optionalArgs then
			return false, "Insufficient arguments"
		end
		COMMANDS[command].run(habits, unpack(args))
		return true
	end
}
