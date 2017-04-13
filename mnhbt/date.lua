local date = {}

date.dateDaysFromNow = function(days)
	local date = os.date("*t")
	date.day = date.day + days
	return os.date("%Y-%m-%d", os.time(date))
end

date.today = function() return date.dateDaysFromNow(0) end
date.yesterday = function() return date.dateDaysFromNow(-1) end

return date
