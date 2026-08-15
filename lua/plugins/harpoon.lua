-- Ported from https://github.com/nikola-s6/nvim-setup.
-- Everything lives under <leader>b so it can't collide with LazyVim's own
-- keymaps (<leader>bb/bd/bo/bi/bD are taken by core buffer commands).
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("harpoon"):setup()
  end,
  keys = {
    { "<leader>ba", function() require("harpoon"):list():add() end, desc = "Harpoon Add File" },
    { "<leader>bx", function() require("harpoon"):list():remove() end, desc = "Harpoon Remove File" },
    {
      "<leader>bl",
      function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end,
      desc = "Harpoon Menu",
    },
    { "<leader>b1", function() require("harpoon"):list():select(1) end, desc = "Harpoon File 1" },
    { "<leader>b2", function() require("harpoon"):list():select(2) end, desc = "Harpoon File 2" },
    { "<leader>b3", function() require("harpoon"):list():select(3) end, desc = "Harpoon File 3" },
    { "<leader>b4", function() require("harpoon"):list():select(4) end, desc = "Harpoon File 4" },
    { "<leader>bp", function() require("harpoon"):list():prev() end, desc = "Harpoon Prev File" },
    { "<leader>bn", function() require("harpoon"):list():next() end, desc = "Harpoon Next File" },
  },
}
