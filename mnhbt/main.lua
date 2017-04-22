local commands = require "commands"
local data = require "data"

local habits = data.loadHabits()
if not habits then
	io.write("Could not load habits file, would you like to create one? (y/n) ")
	io.flush()
	if io.read() ~= "y" then return end
	habits = {}
end

local argRemainder = {}
for i = 2, #arg do
	argRemainder[i-1] = arg[i]
end

assert(commands.tryRun(arg[1], argRemainder, habits))
data.saveHabits(habits)

