return {
  "pwntester/octo.nvim",
  requires = {
    "folke/snacks.nvim",
  },
  opts = {
    ssh_aliases = {
      ["github_work"] = "github.com",
      ["github-work"] = "github.com",
    },
    picker = "snacks",
  },
}
