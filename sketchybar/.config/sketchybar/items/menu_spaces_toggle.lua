local constants = require("constants")
local colors = require("colors")
local settings = require("settings")
local icons = require("icons")

sbar.add("event", constants.events.SWAP_MENU_AND_SPACES)

local function switchToggle(menuToggle)
  local isShowingMenu = menuToggle:query().icon.value == icons.sf_symbols.switch.on

  menuToggle:set({
    icon = isShowingMenu and icons.sf_symbols.switch.off or icons.sf_symbols.switch.on,
    label = isShowingMenu and "Menus" or "Spaces",
  })

  sbar.trigger(constants.events.SWAP_MENU_AND_SPACES, { isShowingMenu = isShowingMenu })
end

local function addToggle()
  local menuToggle = sbar.add("item", constants.items.MENU_TOGGLE, {
    icon = {
      string = icons.sf_symbols.switch.on
    },
    label = {
      width = 0,
      color = colors.bg1,
      string = "Spaces",
    },
    background = {
      color = colors.with_alpha(colors.dirty_white, 0.0),
    }
  })

  sbar.add("item", constants.items.MENU_TOGGLE .. ".padding", {
    width = settings.paddings
  })

  menuToggle:subscribe("mouse.entered", function(env)
    sbar.animate("tanh", 30, function()
      menuToggle:set({
        background = {
          color = { alpha = 1.0 },
          border_color = { alpha = 0.5 },
        },
        icon = { color = colors.bg1 },
        label = { width = "dynamic" }
      })
    end)
  end)

  menuToggle:subscribe("mouse.exited", function(env)
    sbar.animate("tanh", 30, function()
      menuToggle:set({
        background = {
          color = { alpha = 0.0 },
          border_color = { alpha = 0.0 },
        },
        icon = { color = colors.white },
        label = { width = 0 }
      })
    end)
  end)

  menuToggle:subscribe("mouse.clicked", function(env)
    switchToggle(menuToggle)
  end)

  menuToggle:subscribe(constants.events.AEROSPACE_SWITCH, function(env)
    switchToggle(menuToggle)
  end)
end

addToggle()