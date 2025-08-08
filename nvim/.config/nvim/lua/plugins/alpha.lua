-- lua/plugins/alpha.lua
return {
  { import = "lazyvim.plugins.extras.ui.alpha" },

  { "folke/snacks.nvim", optional = true, opts = { dashboard = { enabled = false } } },

  {
    "goolord/alpha-nvim",
    optional = true,
    opts = function(_, opts)
      local art = require("art.alpha_art2")
      art.setup_highlights()
    
      -- 1) Identify which highlight groups are white
      local WHITE = "#ffffff"
      local is_white = {}
      for grp, hex in pairs(art.groups or {}) do
        if (hex or ""):lower() == WHITE then
          is_white[grp] = true
        end
      end
    
      -- 2) Build filtered/cropped components (remove white, crop empty border)
      local function components_no_white_cropped()
        local comps = {}
        local minx, maxx = math.huge, -math.huge
        local nonempty_rows = {}
    
        -- Pass 1: remove white runs; find horizontal bbox
        for i, runs in ipairs(art.line_hls or {}) do
          local filtered = {}
          for _, r in ipairs(runs) do
            local grp, s, e = r[1], r[2], r[3]
            if not is_white[grp] then
              table.insert(filtered, { grp, s, e })
              if s < minx then minx = s end
              if e > maxx then maxx = e end
            end
          end
          nonempty_rows[i] = filtered
        end
    
        if minx == math.huge then
          -- everything was white; fall back to original (or show nothing)
          return art.components()
        end
    
        -- Remove leading/trailing fully-white rows (vertical crop)
        local top, bottom = 1, #nonempty_rows
        while top <= bottom and #nonempty_rows[top] == 0 do top = top + 1 end
        while bottom >= top and #nonempty_rows[bottom] == 0 do bottom = bottom - 1 end
    
        local width = maxx - minx
        for i = top, bottom do
          -- line string shrinks to bbox width
          local line = string.rep(" ", width)
          local hl = {}
          for _, r in ipairs(nonempty_rows[i]) do
            local grp, s, e = r[1], r[2], r[3]
            -- shift runs into the cropped coords
            s = math.max(s - minx, 0)
            e = math.max(e - minx, 0)
            if e > s then
              table.insert(hl, { grp, s, e })
            end
          end
          table.insert(comps, { type = "text", val = line, opts = { hl = hl, position = "center" } })
        end
    
        return comps
      end
    
      local comps = components_no_white_cropped()
    
      -- 3) Center the block (and each line)
      opts.section.header.type = "group"
      opts.section.header.val = comps
      opts.section.header.opts = { position = "center" }
    
      -- 4) Rebuild layout (keeps it reliable)
      opts.layout = {
        { type = "padding", val = 8 },
        opts.section.header,
        { type = "padding", val = 2 },
        opts.section.buttons,
        { type = "padding", val = 1 },
        opts.section.footer,
      }
    
      return opts
    end,
  },
}