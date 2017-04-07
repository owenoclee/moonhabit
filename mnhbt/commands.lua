local consts = require "mnhbt.consts"
local habits = {}

local COMMANDS = {
	add = {
		arity = 1,
		run = function(habits, name)
			habits[name] = habits[name] or { meta = { count = 0, streak = 0 } }
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
			if not habits[name][consts.TODAY] then
				habits[name][consts.TODAY] = {}
				habits[name].meta.count = habits[name].meta.count + 1
				if habits[name][consts.YESTERDAY] then
					habits[name].meta.streak = habits[name].meta.streak + 1
				else
					habits[name].meta.streak = 1
				end
			end
		end
	},
	uncheck = {
		arity = 1,
		run = function(habits, name)
			if habits[name][consts.TODAY] then
				habits[name][consts.TODAY] = nil
				habits[name].meta.count = habits[name].meta.count - 1
				habits[name].meta.streak = habits[name].meta.streak - 1
			end
		end
	},
	display = {
		arity = 1,
		run = function(habits, name)
			for k, _ in pairs(habits[name]) do
				print(k)
			end
		end
	},
	ls = {
		arity = 0,
		run = function(habits)
			for k, _ in pairs(habits) do
				print(string.format("%s: %d day streak. %d recorded events.", k,
						habits[k].meta.streak, habits[k].meta.count))
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
				print("Usage: " .. APP_NAME .. " <command> [<args>]\n\n" ..
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
