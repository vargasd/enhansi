local M = {
  config = {
    extended = true,
    rgb_colors = {
      dark = {},
      bg = {},
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

  bg = {
    red = 52,
    green = 22,
    blue = 17,
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
  local rgb_colors = M.config.rgb_colors
  ---@type table<string, ExplicitHighlight | ReverseHighlight | LinkHighlight>
  return {
    Normal = { ctermfg = colors.white, fg = rgb_colors.white },
    NonText = { ctermfg = colors.dim, fg = rgb_colors.dim },
    Visual = { reverse = true },
    LineNr = { link = "NonText" },
    FloatBorder = { link = "NonText" },
    Italic = { italic = true },
    Title = { ctermfg = colors.green, fg = rgb_colors.green },
    Directory = { ctermfg = colors.gray, fg = rgb_colors.gray },
    ColorColumn = { ctermbg = colors.black, bg = rgb_colors.black },
    TabLine = { ctermfg = colors.white, fg = rgb_colors.white },
    TabLineSel = { reverse = true },

    Comment = { ctermfg = colors.gray, fg = rgb_colors.gray, italic = true },
    Todo = { ctermfg = colors.cyan, fg = rgb_colors.cyan },
    Constant = { ctermfg = colors.magenta, fg = rgb_colors.magenta },
    Delimiter = { ctermfg = colors.gray, fg = rgb_colors.gray },
    String = { ctermfg = colors.green, fg = rgb_colors.green, italic = true },
    Function = { ctermfg = colors.green, fg = rgb_colors.green },
    Operator = { link = "Delimiter" },
    Special = { ctermfg = colors.magenta, fg = rgb_colors.magenta },
    Number = { ctermfg = colors.magenta, fg = rgb_colors.magenta },
    Boolean = { ctermfg = colors.magenta, fg = rgb_colors.magenta },
    Statement = { ctermfg = colors.red, fg = rgb_colors.red },
    Type = { ctermfg = colors.yellow, fg = rgb_colors.yellow },
    Identifier = { ctermfg = colors.blue, fg = rgb_colors.blue },

    DiffAdd = M.config.extended and { ctermbg = colors.bg.green, bg = rgb_colors.bg.green }
      or { ctermfg = colors.green, fg = rgb_colors.green },
    DiffChange = M.config.extended and { ctermbg = colors.bg.blue, bg = rgb_colors.bg.blue }
      or { ctermfg = colors.blue, fg = rgb_colors.blue },
    DiffDelete = M.config.extended and { ctermbg = colors.bg.red, bg = rgb_colors.bg.red }
      or { ctermfg = colors.red, fg = rgb_colors.red },
    DiffText = { ctermfg = colors.gray, fg = rgb_colors.gray, ctermbg = nil },

    DiagnosticVirtualTextError = { ctermfg = colors.dark.red, fg = rgb_colors.dark.red },
    DiagnosticVirtualTextWarn = { ctermfg = colors.dark.yellow, fg = rgb_colors.dark.yellow },
    DiagnosticVirtualTextInfo = { ctermfg = colors.dark.blue, fg = rgb_colors.dark.blue },
    DiagnosticVirtualTextHint = { ctermfg = colors.dark.cyan, fg = rgb_colors.dark.cyan },
    DiagnosticVirtualTextOk = { ctermfg = colors.dark.green, fg = rgb_colors.dark.green },

    SpellBad = { undercurl = true, sp = rgb_colors.red or "Red" },
    SpellCap = { undercurl = true, sp = rgb_colors.yellow or "Yellow" },
    SpellLocal = { undercurl = true, sp = rgb_colors.blue or "Blue" },
    SpellRare = { undercurl = true, sp = rgb_colors.cyan or "Cyan" },

    DiagnosticUnderlineError = { link = "SpellBad" },
    DiagnosticUnderlineWarn = { link = "SpellCap" },
    DiagnosticUnderlineInfo = { link = "SpellLocal" },
    DiagnosticUnderlineHint = { link = "SpellRare" },
    DiagnosticUnderlineOk = { undercurl = true, sp = "Green" },

    ["@variable"] = { link = "Normal" },
    ["@variable.member"] = { link = "Identifier" },
    ["@markup.heading"] = { link = "Title" },
    ["@markup.link"] = { ctermfg = colors.blue, fg = rgb_colors.blue, underline = true },
    ["@punctuation.special"] = { link = "Delimiter" },

    Pmenu = { ctermfg = colors.white, fg = rgb_colors.white },
    PmenuSel = {
      ctermfg = colors.black,
      fg = rgb_colors.black,
      ctermbg = colors.blue,
      bg = rgb_colors.blue,
      bold = true,
    },
    PmenuSbar = { ctermbg = colors.dim, bg = rgb_colors.dim },
    PmenuThumb = { ctermbg = colors.white, bg = rgb_colors.white },
    PmenuKind = { ctermfg = colors.blue, fg = rgb_colors.blue },

    -- plugin-specific
    BlinkCmpDocBorder = { link = "FloatBorder" },

    NoiceCmdlinePopupBorder = { ctermfg = colors.blue, fg = rgb_colors.blue },
    NoiceCmdlineIcon = { link = "NoiceCmdlinePopupBorder" },
    NoiceConfirmBorder = { link = "NoiceCmdlinePopupBorder" },
    NoiceCmdlinePopupBorderSearch = { ctermfg = colors.yellow, fg = rgb_colors.yellow },
    NoiceCmdlineIconSearch = { link = "NoiceCmdlinePopupBorderSearch" },

    SnacksPickerLine = { link = "Visual" },
    SnacksPickerDir = { link = "Directory" },
    SnacksPickerPathHidden = { link = "Directory" },
    SnacksPickerPathIgnored = { link = "Directory" },

    SnacksDashboardHeader = { ctermfg = colors.yellow, fg = rgb_colors.yellow },

    RenderMarkdownCodeBorder = { link = "Comment" },
  }
end

M.setup = function(config)
  M.config = vim.tbl_deep_extend("force", M.config, config or {})
end

M.load = function()
  vim.o.termguicolors = M.config.rgb_colors.white ~= nil

  vim.g.colors_name = "enhansi"

  local groups = get_groups()
  for group, settings in pairs(groups) do
    vim.api.nvim_set_hl(0, group, settings)
  end
end

return M
