local date = require "mnhbt.date"

local meta = {}

meta.indexOf = function(list, value)
	for i = #list, 1, -1 do
		if list[i] == value then return i end
	end
	return nil
end

meta.getStreak = function(list)
	local streak = 0
	if meta.indexOf(list, date.today()) then
		streak = streak + 1
	end

	local idx = meta.indexOf(list, date.yesterday()) 
	if not idx then return streak end

	for i = idx, 1, -1 do
		if list[i] == date.dateDaysFromNow(i - idx - 1) then
			streak = streak + 1
		else
			break
		end
	end

	return streak
end

return meta

