local M = {}

function M.setup()
  -- File explorer window size
  vim.g.netrw_winsize = 30
  vim.g.netrw_preview = 1
  vim.g.netrw_liststyle = 3
  vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro nornu"

  -- Don't sync current directory with browsing directory
  vim.g.netrw_keepdir = 1

  -- Hide banner
  vim.g.netrw_banner = 0

  -- Hide dotfiles
  vim.g.netrw_list_hide = [[\(^\|\s\s\)\zs\.\S\+]]

  -- A better copy command (for unix-like systems)
  vim.g.netrw_localcopydircmd = "cp -r"

  local group = vim.api.nvim_create_augroup("netrw_cmds", { clear = true })

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = { "netrw" },
    desc = "Setup mappings for netrw",
    callback = M.mappings,
  })
end

function M.mappings(ev)
  local map = function(mode, lhs, rhs, opts)
    opts = opts or { remap = true }
    opts.buffer = ev.buf
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  -- Close netrw window
  map("n", "q", "<cmd>Lexplore<cr>", { nowait = true })

  -- Go to file and close Netrw window
  map("n", "L", "<cr><cmd>Lexplore<cr>")

  -- Go back in history
  map("n", "H", "u")

  -- Go up a directory
  map("n", "h", "-^")

  -- Go down a directory / open file
  map("n", "l", "<cr>")

  -- Toggle dotfiles
  map("n", "za", "gh")

  -- Toggle the mark on a file
  map("n", "<Tab>", "mf")

  -- Unmark all files in the buffer
  map("n", "<S-Tab>", "mF")

  -- Unmark all files
  map("n", "<leader><Tab>", "mu")

  -- 'Bookmark' a directory
  map("n", "bb", "mb")

  -- Delete the most recent directory bookmark
  map("n", "bd", "mB")

  -- Got to a directory on the most recent bookmark
  map("n", "bl", "gb")

  -- Create a file
  map("n", "F", "%")

  -- Rename a file
  map("n", "fr", "R")

  -- Copy marked files
  map("n", "fc", "mc")

  -- Move marked files
  map("n", "fm", "mm")

  -- Execute a command on marked files
  map("n", "fx", "mx")

  -- Show the list of marked files
  map("n", "fl", ':echo join(netrw#Expose("netrwmarkfilelist"), "\n")<CR>')

  -- Show the current target directory
  map("n", "fq", [[:echo 'Target:' . netrw#Expose("netrwmftgt")<CR>]])

  -- Set the directory under the cursor as the current target
  map("n", "ft", "mtfq")

  -- Close the preview window
  map("n", "P", "<C-w>z")
end

return M
