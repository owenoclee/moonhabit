local yesterdayDate = os.date("*t")
yesterdayDate.day = yesterdayDate.day - 1

local consts = {
	APP_NAME	= "moonhabit",
	DATA_NAME	= "data.json",
	DATA_DIR	= (os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") ..
					"/.config") .. "/" .. consts.APP_NAME,
	DATA_PATH	= getDataDir() .. "/" .. consts.DATA_NAME,
	YESTERDAY = os.date("%Y-%m-%d", os.time(yesterdayDate)),
	TODAY = os.date("%Y-%m-%d")
}

return consts

