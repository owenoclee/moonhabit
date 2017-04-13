return {
	dateDaysFromNow = function(days)
		local date = os.date("*t")
		date.day = date.day + days
		return os.date("%Y-%m-%d", os.time(date))
	end,
	today = function() return dateDaysFromNow(0) end
	yesterday = function() return dateDaysFromNow(-1) end
}

