local yesterdayDate = os.date("*t")
yesterdayDate.day = yesterdayDate.day - 1

local date = {
	YESTERDAY = os.date("%Y-%m-%d", os.time(yesterdayDate)),
	TODAY = os.date("%Y-%m-%d")
}

return date
