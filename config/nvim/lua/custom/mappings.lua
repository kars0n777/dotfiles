---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    }

  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

-- more keybinds!

-- MOVEMENT -- 
-- zz whenever you page down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")

-- SAVING --
-- ctrl q to quit
vim.keymap.set("n", "<C-q>", ":q!<cr>")

-- PLUGINS -- 
-- ctrl f for telescope
vim.keymap.set("n", "<C-f>", "<cmd> Telescope find_files <CR>")

-- [GotoTab](https://nvchad.com/docs/api#gototab)
for i = 1, 9, 1 do
  vim.keymap.set("n", string.format("<C-%s>", i), function()
    vim.api.nvim_set_current_buf(vim.t.bufs[i])
  end)
end

return M
