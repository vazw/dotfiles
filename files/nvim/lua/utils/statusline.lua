---@diagnostic disable: assign-type-mismatch, no-unknown,missing-local-export-doc
local M = {}
local state = {}

local function default_hl(name, style, opts)
  opts = opts or {}
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name })
  if ok and (hl.bg or hl.fg) then
    return
  end

  if opts.link then
    vim.api.nvim_set_hl(0, name, { link = style })
    return
  end

  local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
  local fallback = vim.api.nvim_get_hl(0, { name = style })

  vim.api.nvim_set_hl(0, name, { fg = normal.bg, bg = fallback.fg })
end

local mode_higroups = {
  ["NORMAL"] = "UserStatusMode_NORMAL",
  ["VISUAL"] = "UserStatusMode_VISUAL",
  ["V-BLOCK"] = "UserStatusMode_V_BLOCK",
  ["V-LINE"] = "UserStatusMode_V_LINE",
  ["INSERT"] = "UserStatusMode_INSERT",
  ["COMMAND"] = "UserStatusMode_COMMAND",
  ["TERMINAL"] = "UserStatusMode_TERMINAL",
}

local function apply_hl()
  default_hl("UserStatusBlock", "StatusLine", { link = true })
  default_hl("UserStatusMode_DEFAULT", "GitSignsAddVirtLnInLine")

  default_hl(mode_higroups["NORMAL"], "Title")
  default_hl(mode_higroups["VISUAL"], "WarningMsg")
  default_hl(mode_higroups["V-BLOCK"], "Directory")
  default_hl(mode_higroups["V-LINE"], "Conceal")
  default_hl(mode_higroups["INSERT"], "ErrorMsg")
  default_hl(mode_higroups["COMMAND"], "DiffChange")
  default_hl(mode_higroups["TERMINAL"], "Type")
end

-- mode_map copied from:
-- https://github.com/nvim-lualine/lualine.nvim/blob/5113cdb32f9d9588a2b56de6d1df6e33b06a554a/lua/lualine/utils/mode.lua
local mode_map = {
  ["n"] = "NORMAL",
  ["no"] = "O-PENDING",
  ["nov"] = "O-PENDING",
  ["noV"] = "O-PENDING",
  ["no\22"] = "O-PENDING",
  ["niI"] = "NORMAL",
  ["niR"] = "NORMAL",
  ["niV"] = "NORMAL",
  ["nt"] = "NORMAL",
  ["v"] = "VISUAL",
  ["vs"] = "VISUAL",
  ["V"] = "V-LINE",
  ["Vs"] = "V-LINE",
  ["\22"] = "V-BLOCK",
  ["\22s"] = "V-BLOCK",
  ["s"] = "SELECT",
  ["S"] = "S-LINE",
  ["\19"] = "S-BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["ix"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rc"] = "REPLACE",
  ["Rx"] = "REPLACE",
  ["Rv"] = "V-REPLACE",
  ["Rvc"] = "V-REPLACE",
  ["Rvx"] = "V-REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "EX",
  ["ce"] = "EX",
  ["r"] = "REPLACE",
  ["rm"] = "MORE",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

local fmt = string.format
local hi_pattern = "%%#%s#%s%%*"

function _G._statusline_component(name)
  return state[name]()
end

state.mode_group = mode_higroups["NORMAL"]

function state.lsp()
  local count = {}
  local levels = {
    errors = "Error",
    warnings = "Warn",
    info = "Info",
    hints = "Hint",
  }
  local lsps = ""
  for _, cli in ipairs(vim.lsp.get_clients()) do
    if cli.name ~= "typos_lsp" then
      lsps = lsps .. " " .. cli.name
    end
  end

  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  local errors = ""
  local warnings = ""
  local hints = ""
  local info = ""

  if count["errors"] ~= 0 then
    errors = " %#DiagnosticError# " .. count["errors"]
  end
  if count["warnings"] ~= 0 then
    warnings = " %#DiagnosticWarn# " .. count["warnings"]
  end
  if count["hints"] ~= 0 then
    hints = " %#DiagnosticHint#󰠠 " .. count["hints"]
  end
  if count["info"] ~= 0 then
    info = " %#DiagnosticInfo# " .. count["info"]
  end

  return lsps .. errors .. warnings .. hints .. info
end

function state.mode()
  local mode = vim.api.nvim_get_mode().mode
  local mode_name = mode_map[mode]
  local text = " "

  local higroup = mode_higroups[mode_name]

  if higroup then
    state.mode_group = higroup
    text = fmt(" %s ", mode_name)

    return fmt(hi_pattern, higroup, text)
  end

  state.mode_group = "UserStatusMode_DEFAULT"
  text = fmt(" %s ", mode_name)
  return fmt(hi_pattern, state.mode_group, text)
end

function state.position()
  return fmt(hi_pattern, state.mode_group, " %3l:%-2c ")
end

function state.gitsign()
  if not vim.g.loaded_gitsigs or vim.g.loaded_gitsigs == 0 then
    return ""
  end

  local git_info = vim.b.gitsigns_status_dict
  if not git_info or git_info.head == "" then
    return ""
  end
  local added = git_info.added and ("%#GitSignsAdd#+" .. git_info.added .. " ") or ""
  local changed = git_info.changed and ("%#GitSignsChange#~" .. git_info.changed .. " ") or ""
  local removed = git_info.removed and ("%#GitSignsDelete#-" .. git_info.removed .. " ") or ""
  if git_info.added == 0 then
    added = ""
  end
  if git_info.changed == 0 then
    changed = ""
  end
  if git_info.removed == 0 then
    removed = ""
  end
  return table.concat({
    added,
    changed,
    removed,
    "%#GitSignsAdd# ",
    git_info.head,
    " %#StatusLine#",
  })
end

state.percent = fmt(hi_pattern, "UserStatusBlock", " %2p%% ")

state.full_status = {
  '%{%v:lua._statusline_component("mode")%} ',
  '%{%v:lua._statusline_component("gitsign")%}',
  "%t%h%m%r%w",
  "%=",
  '%{%v:lua._statusline_component("lsp")%}',
  state.percent,
  '%{%v:lua._statusline_component("position")%}',
}

state.short_status = {
  "%t%h%m%r%w",
  "%=",
  "%{&filetype}",
  state.percent,
  '%{%v:lua._statusline_component("position")%}',
}

state.inactive_status = {
  " %t%h%m%r%w%q",
  "%=",
  "%{&filetype} |",
  " %2p%% | ",
  "%3l:%-2c ",
}

function M.setup()
  local augroup = vim.api.nvim_create_augroup("statusline_cmds", { clear = true })
  local autocmd = vim.api.nvim_create_autocmd
  vim.opt.showmode = false

  apply_hl()
  local pattern = M.get_status("full")
  if pattern then
    vim.o.statusline = pattern
  end

  autocmd("ColorScheme", {
    group = augroup,
    desc = "Apply statusline highlights",
    callback = apply_hl,
  })
  autocmd("FileType", {
    group = augroup,
    pattern = { "netrw" },
    desc = "Apply short statusline",
    callback = function()
      vim.w.status_style = "short"
      vim.wo.statusline = M.get_status("short")
    end,
  })
  autocmd("InsertEnter", {
    group = augroup,
    desc = "Clear message area",
    command = "echo ''",
  })
end

function M.get_status(name)
  return table.concat(state[fmt("%s_status", name)], "")
end

function M.apply(name)
  vim.o.statusline = M.get_status(name)
end

function M.higroups()
  local res = vim.deepcopy(mode_higroups)
  res["DEFAULT"] = "UserStatusMode_DEFAULT"
  res["STATUS-BLOCK"] = "UserStatusBlock"
  return res
end

M.default_hl = apply_hl

return M
