local COMMANDS = {
	add = {
		arity = 1,
		run = function(name)
			habits[name] = habits[name] or { meta = { count = 0, streak = 0 } }
		end
	},
	rm = {
		arity = 1,
		run = function(name)
			habits[name] = nil
		end
	},
	check = {
		arity = 1,
		run = function(name)
			if not habits[name][TODAY] then
				habits[name][TODAY] = {}
				habits[name].meta.count = habits[name].meta.count + 1
				if habits[name][YESTERDAY] then
					habits[name].meta.streak = habits[name].meta.streak + 1
				else
					habits[name].meta.streak = 1
				end
			end
		end
	},
	uncheck = {
		arity = 1,
		run = function(name)
			if habits[name][TODAY] then
				habits[name][TODAY] = nil
				habits[name].meta.count = habits[name].meta.count - 1
				habits[name].meta.streak = habits[name].meta.streak - 1
			end
		end
	},
	display = {
		arity = 1,
		run = function(name)
			for k, _ in pairs(habits[name]) do
				print(k)
			end
		end
	},
	ls = {
		arity = 0,
		run = function()
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
	tryRun = function(command, args)
		if #args > COMMANDS[command].arity then
			return false, "Too many arguments"
		else
			return false, "Insufficient arguments"
		end
		COMMANDS[command].run()
		return true
	end
}
