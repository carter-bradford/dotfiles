local constants = require("constants")
local colors = require("colors")
local settings = require("settings")
local icons = require("icons")

local spaces = {}

local swapWatcher = sbar.add("item", {
	drawing = false,
	updates = true,
})

local currentWorkspaceWatcher = sbar.add("item", {
	drawing = false,
	updates = true,
})

local spaceConfigs <const> = {
	["1"] = { icon = " :microsoft_edge:", name = " 1" },
	["2"] = { icon = " :todoist:", name = " 2" },
	["3"] = { icon = " :notes:", name = " 3" },
	["4"] = { icon = " :microsoft_teams:", name = " 4" },
	["5"] = { icon = " :terminal:", name = " 5" },
	["6"] = { icon = " :code:", name = " 6" },
	["7"] = { icon = " :microsoft_edge:", name = " 7" },
	["8"] = { icon = " :mail:", name = " 8" },
	["9"] = { icon = " :messages:", name = " 9" },
	["0"] = { icon = " :slack:", name = " 0" },
}

local function selectCurrentWorkspace(focusedWorkspaceName)
	for sid, item in pairs(spaces) do
		if item ~= nil then
			local isSelected = sid == constants.items.SPACES .. "." .. focusedWorkspaceName
			item:set({
				icon = { color = isSelected and colors.bg1 or colors.white },
				label = { color = isSelected and colors.bg1 or colors.white },
				background = { color = isSelected and colors.white or colors.bg1 },
			})
		end
	end

	sbar.trigger(constants.events.UPDATE_WINDOWS)
end

local function findAndSelectCurrentWorkspace()
	sbar.exec(constants.aerospace.GET_CURRENT_WORKSPACE, function(focusedWorkspaceOutput)
		local focusedWorkspaceName = focusedWorkspaceOutput:match("[^\r\n]+")
		selectCurrentWorkspace(focusedWorkspaceName)
	end)
end

local function addWorkspaceItem(workspaceName)
	local spaceName = constants.items.SPACES .. "." .. workspaceName
	local spaceConfig = spaceConfigs[workspaceName]

	spaces[spaceName] = sbar.add("item", spaceName, {
		label = {
			width = 20,
			padding_left = 2,
			padding_right = 10,
			string = spaceConfig.name,
		},
		icon = {
			font = "sketchybar-app-font:Regular:16.0",
			string = spaceConfig.icon or icons.apps["default"],
			color = colors.white,
		},
		background = {
			color = colors.bg1,
		},
		click_script = "aerospace workspace " .. workspaceName,
	})

	spaces[spaceName]:subscribe("mouse.entered", function(env)
		--sbar.animate("tanh", 30, function()
		--  spaces[spaceName]:set({ label = { width = "dynamic" } })
		--end)
	end)

	spaces[spaceName]:subscribe("mouse.exited", function(env)
		--sbar.animate("tanh", 30, function()
		--  spaces[spaceName]:set({ label = { width = 0 } })
		--end)
	end)

	sbar.add("item", spaceName .. ".padding", {
		width = settings.paddings,
	})
end

local function createWorkspaces()
	sbar.exec(constants.aerospace.LIST_ALL_WORKSPACES, function(workspacesOutput)
		for workspaceName in workspacesOutput:gmatch("[^\r\n]+") do
			addWorkspaceItem(workspaceName)
		end

		findAndSelectCurrentWorkspace()
	end)
end

swapWatcher:subscribe(constants.events.SWAP_MENU_AND_SPACES, function(env)
	local isShowingSpaces = env.isShowingMenu == "off" and true or false
	sbar.set("/" .. constants.items.SPACES .. "\\..*/", { drawing = isShowingSpaces })
end)

currentWorkspaceWatcher:subscribe(constants.events.AEROSPACE_WORKSPACE_CHANGED, function(env)
	selectCurrentWorkspace(env.FOCUSED_WORKSPACE)
	sbar.trigger(constants.events.UPDATE_WINDOWS)
end)

createWorkspaces()
