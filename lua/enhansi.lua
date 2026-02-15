local M = {}

---@class SpecialColors
---@field red string
---@field yellow string
---@field blue string
---@field cyan string
---@field green string

---@class BackgroundColors
---@field red number
---@field blue number
---@field green number

---@class CustomColors
---@field background BackgroundColors | false
---@field special SpecialColors

---@class EnhansiConfig
---@field custom_colors CustomColors

---@type EnhansiConfig
M.config = {
  custom_colors = {
    background = {
      red = 52,
      green = 22,
      blue = 17,
    },
    special = {
      red = "red",
      yellow = "yellow",
      blue = "blue",
      cyan = "cyan",
      green = "green",
    },
  },
}

local colors = {
  black = 0,
  gray = 7,
  dim = 8,
  red = 9,
  green = 10,
  yellow = 11,
  blue = 12,
  magenta = 13,
  cyan = 14,
  white = 15,

  dark = {
    red = 1,
    green = 2,
    yellow = 3,
    blue = 4,
    magenta = 5,
    cyan = 6,
  },
}

---@class ExplicitHighlight
---@field ctermfg number?
---@field ctermbg number?
---@field fg string?
---@field bg string?
---@field sp string?
---@field bold boolean?
---@field italic boolean?
---@field standout boolean?
---@field underline boolean?
---@field undercurl boolean?
---@field underdouble boolean?
---@field underdotted boolean?
---@field strikethrough boolean?

---@class ReverseHighlight
---@field reverse boolean?

---@class LinkHighlight
---@field link string?

local function get_groups()
  local use_background = M.config.custom_colors.background ~= false
  local sp_red = M.config.custom_colors.special.red
  local sp_yellow = M.config.custom_colors.special.yellow
  local sp_blue = M.config.custom_colors.special.blue
  local sp_cyan = M.config.custom_colors.special.cyan
  local sp_green = M.config.custom_colors.special.green

  ---@type table<string, ExplicitHighlight | ReverseHighlight | LinkHighlight>
  return {
    Normal = { ctermfg = colors.white },
    NonText = { ctermfg = colors.dim },
    Visual = { reverse = true },
    LineNr = { link = "NonText" },
    FloatBorder = { link = "NonText" },
    Italic = { italic = true },
    Title = { ctermfg = colors.green },
    Directory = { ctermfg = colors.gray },
    ColorColumn = { ctermbg = colors.black },
    TabLine = { ctermfg = colors.white },
    TabLineSel = { reverse = true },

    Comment = { ctermfg = colors.gray, italic = true },
    Todo = { ctermfg = colors.cyan },
    Constant = { ctermfg = colors.magenta },
    Delimiter = { ctermfg = colors.gray },
    String = { ctermfg = colors.green, italic = true },
    Function = { ctermfg = colors.green },
    Operator = { link = "Delimiter" },
    Special = { ctermfg = colors.magenta },
    Number = { ctermfg = colors.magenta },
    Boolean = { ctermfg = colors.magenta },
    Statement = { ctermfg = colors.red },
    Type = { ctermfg = colors.yellow },
    Identifier = { ctermfg = colors.blue },

    DiffAdd = (use_background and { ctermbg = M.config.custom_colors.background.green }) or { ctermfg = colors.green },
    DiffChange = (use_background and { ctermbg = M.config.custom_colors.background.blue }) or { ctermfg = colors.blue },
    DiffDelete = (use_background and { ctermbg = M.config.custom_colors.background.red }) or { ctermfg = colors.red },
    DiffText = { ctermfg = colors.gray },

    DiagnosticVirtualTextError = { ctermfg = colors.dark.red },
    DiagnosticVirtualTextWarn = { ctermfg = colors.dark.yellow },
    DiagnosticVirtualTextInfo = { ctermfg = colors.dark.blue },
    DiagnosticVirtualTextHint = { ctermfg = colors.dark.cyan },
    DiagnosticVirtualTextOk = { ctermfg = colors.dark.green },

    SpellBad = { undercurl = true, sp = sp_red },
    SpellCap = { undercurl = true, sp = sp_yellow },
    SpellLocal = { undercurl = true, sp = sp_blue },
    SpellRare = { undercurl = true, sp = sp_cyan },

    DiagnosticUnderlineError = { link = "SpellBad" },
    DiagnosticUnderlineWarn = { link = "SpellCap" },
    DiagnosticUnderlineInfo = { link = "SpellLocal" },
    DiagnosticUnderlineHint = { link = "SpellRare" },
    DiagnosticUnderlineOk = { undercurl = true, sp = sp_green },

    ["@variable"] = { link = "Normal" },
    ["@variable.member"] = { link = "Identifier" },
    ["@markup.heading"] = { link = "Title" },
    ["@markup.link"] = { ctermfg = colors.blue, underline = true },
    ["@punctuation.special"] = { link = "Delimiter" },

    Pmenu = { ctermfg = colors.white },
    PmenuSel = { ctermfg = colors.black, ctermbg = colors.blue, bold = true },
    PmenuSbar = { ctermbg = colors.dim },
    PmenuThumb = { ctermbg = colors.white },
    PmenuKind = { ctermfg = colors.blue },
  }
end

---@param config EnhansiConfig
M.setup = function(config)
  M.config = vim.tbl_deep_extend("force", M.config, config or {})
end

M.load = function()
  vim.g.colors_name = "enhansi"

  local groups = get_groups()
  for group, settings in pairs(groups) do
    vim.api.nvim_set_hl(0, group, settings)
  end
end

return M
