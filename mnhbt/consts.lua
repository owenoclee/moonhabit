local yesterdayDate = os.date("*t")
yesterdayDate.day = yesterdayDate.day - 1

local consts = {
	APP_NAME = "moonhabit",
	DATA_NAME = "data.json",
	YESTERDAY = os.date("%Y-%m-%d", os.time(yesterdayDate)),
	TODAY = os.date("%Y-%m-%d")
}

consts.DATA_DIR = (os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") ..
			"/.config") .. "/" .. consts.APP_NAME
consts.DATA_PATH = consts.DATA_DIR .. "/" .. consts.DATA_NAME

return consts

