local constants = require("constants")
local colors = require("colors")
local icons = require("helpers.app_icons")
local fonts

local frontApps = {}

sbar.add("bracket", constants.items.FRONT_APPS, {}, { position = "left" })

local frontAppWatcher = sbar.add("item", {
	drawing = false,
	updates = true,
})

local function selectFocusedWindow(frontAppName)
	for appName, app in pairs(frontApps) do
		local isSelected = appName == frontAppName
		local color = isSelected and colors.purple or colors.white
		app:set({
			label = { color = color },
			icon = { color = color },
		})
	end
end

local function updateWindows(windows)
	sbar.remove("/" .. constants.items.FRONT_APPS .. "\\.*/")

	frontApps = {}
	local foundWindows = string.gmatch(windows, "[^\n]+")
	for window in foundWindows do
		local parsedWindow = {}
		for key, value in string.gmatch(window, "(%w+)=([%w%s]+)") do
			parsedWindow[key] = value
		end

		local windowId = parsedWindow["id"]
		local windowName = parsedWindow["name"]
		local icon = icons[windowName] or icons["default"]

		frontApps[windowName] = sbar.add("item", constants.items.FRONT_APPS .. "." .. windowName, {
			label = {
				padding_left = 0,
        padding_right = 0,
        -- string = windowName,
			},
			icon = {
				string = icon,
				font = "sketchybar-app-font:Regular:16.0",
			},
			click_script = "aerospace focus --window-id " .. windowId,
		})
	end

	sbar.exec(constants.aerospace.GET_CURRENT_WINDOW, function(frontAppName)
		selectFocusedWindow(frontAppName:gsub("[\n\r]", ""))
	end)
end

local function getWindows()
	sbar.exec(constants.aerospace.LIST_WINDOWS, updateWindows)
end

frontAppWatcher:subscribe(constants.events.UPDATE_WINDOWS, function()
	getWindows()
end)

frontAppWatcher:subscribe(constants.events.FRONT_APP_SWITCHED, function(env)
	getWindows()
end)

getWindows()