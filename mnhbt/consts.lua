local consts = {
	APP_NAME = "moonhabit",
	DATA_NAME = "data.json"
}

consts.DATA_DIR = (os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") ..
			"/.config") .. "/" .. consts.APP_NAME
consts.DATA_PATH = consts.DATA_DIR .. "/" .. consts.DATA_NAME

return consts

