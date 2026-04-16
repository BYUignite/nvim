
local M = {}

--=============================================================================
-- Setup

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.o.termguicolors = true
vim.g.colors_name   = "repent2"

local hl = vim.api.nvim_set_hl

--=============================================================================
-- Palette

utils = require("utils")

local c = {

    blk = utils.hsl_to_hex(200, 00,  0), --"#000000"
    c00 = utils.hsl_to_hex(200, 70,  6), --"#05131A"
    c01 = utils.hsl_to_hex(200, 60, 14), --"#0E2B39"
    c02 = utils.hsl_to_hex(200, 50, 22), --"#1C4154"
    c03 = utils.hsl_to_hex(200, 40, 30), --"#2E576B"
    c04 = utils.hsl_to_hex(200, 30, 38), --"#446B7E"
    c05 = utils.hsl_to_hex(200, 20, 46), --"#5E7D8D"
    c06 = utils.hsl_to_hex(200, 20, 54), --"#7292A1"
    c07 = utils.hsl_to_hex(200, 20, 62), --"#8BA5B1"
    c08 = utils.hsl_to_hex(200, 20, 70), --"#A3B8C2"
    c09 = utils.hsl_to_hex(200, 20, 78), --"#BCCBD2"
    c10 = utils.hsl_to_hex(200, 20, 86), --"#D4DEE2"
    c11 = utils.hsl_to_hex(200, 20, 94), --"#EDF1F3"
    wht = utils.hsl_to_hex(200, 00,100), --"#ffffff"

    red = utils.hsl_to_hex(350, 90, 30), --"#91081F"
    org = utils.hsl_to_hex( 20, 90, 30), --"#913608"
    yel = utils.hsl_to_hex( 50, 90, 30), --"#917A08"
    ylg = utils.hsl_to_hex( 80, 90, 30), --"#639108"
    grn = utils.hsl_to_hex(110, 90, 30), --"#1F9108"
    grb = utils.hsl_to_hex(140, 90, 30), --"#089136"
    blg = utils.hsl_to_hex(170, 90, 30), --"#08917A"
    blu = utils.hsl_to_hex(200, 90, 30), --"#086391"
    blp = utils.hsl_to_hex(230, 90, 30), --"#081F91"
    prb = utils.hsl_to_hex(260, 90, 30), --"#360891"
    pnk = utils.hsl_to_hex(290, 90, 30), --"#7A0891"
    prp = utils.hsl_to_hex(320, 90, 30), --"#910863"
}

--=============================================================================
------------------- Terminal colors

vim.g.terminal_color_0  = c.c01
vim.g.terminal_color_1  = c.red
vim.g.terminal_color_2  = c.grb
vim.g.terminal_color_3  = c.yel
vim.g.terminal_color_4  = c.blu
vim.g.terminal_color_5  = c.prp
vim.g.terminal_color_6  = c.blu
vim.g.terminal_color_7  = c.wht
vim.g.terminal_color_8  = c.c01
vim.g.terminal_color_9  = c.red
vim.g.terminal_color_10 = c.grb
vim.g.terminal_color_11 = c.yel
vim.g.terminal_color_12 = c.blu
vim.g.terminal_color_13 = c.prp
vim.g.terminal_color_14 = c.blu
vim.g.terminal_color_15 = c.wht

--=============================================================================
-- highlight group colors
-- variables used multiple times

local Normal     = { fg = c.c02, bg = c.wht }
local Cursor     = { fg = c.blk, bg = c.wht }
local FoldColumn = { fg = c.c06 } 
local Visual     = { bg = c.c10 } 
local Search     = { fg = c.wht, bg = c.c05 } 
local VertSplit  = { fg = c.c03 } 
local TabLine    = { fg = c.c02, bg = c.c11 } 
local Comment    = { fg = c.c07, italic = true }
local String     = { fg = c.blu }
local Number     = { fg = c.blu }
local Error      = { fg = c.wht, bg=c.red }
local Warning    = { bg = c.yel, bold = true }

------------------- status line 

hl(0, "SLine1",  { fg=c.c11, bg=c.c02, bold=true })
hl(0, "Trans1",  { fg=c.c02, bg=c.c08})
hl(0, "SLine2",  { fg=c.c01, bg=c.c08, bold=true })
hl(0, "Trans2",  { fg=c.c08, bg=c.c11})
hl(0, "SLine3",  { fg=c.c01, bg=c.c11 })
hl(0, "Trans3",  { fg=c.c02, bg=c.c11})

------------------- general editor

hl(0, "Normal",       Normal)
hl(0, "NormalNC",     Normal)
hl(0, "EndOfBuffer",  Normal)
hl(0, "Cursor",       Cursor)
hl(0, "CursorLine",   { bold = true })
hl(0, "CursorColumn", { bg = c.c11 })
hl(0, "ColorColumn",  { bg = c.c11 })
hl(0, "LineNr",       { fg = c.c10 })
hl(0, "CursorLineNr", { fg = c.c06, bold = true })
hl(0, "FoldColumn",   FoldColumn)
hl(0, "SignColumn",   FoldColumn)
hl(0, "Folded",       { fg = c.c08, italic = true })

------------------- search, selection

hl(0, "Visual",       Visual)
hl(0, "VisualNOS",    Visual)
hl(0, "Search",       Search)
hl(0, "IncSearch",    Search)
hl(0, "Substitute",   Search)

------------------- messages, etc.

hl(0, "Question",     Normal)
hl(0, "MoreMsg",      Normal)
hl(0, "ErrorMsg",     Error)
hl(0, "WarningMsg",   Warning)
hl(0, "Conceal",      Normal)
hl(0, "Whitespace",   Normal)
hl(0, "ModeMsg",      { fg = c.wht, bg=c.c02 })
hl(0, "Title",        { fg = c.red, bold = true })
hl(0, "SpecialKey",   { fg = c.red })

------------------- split windows

hl(0, "VertSplit",     VertSplit)
hl(0, "WinSeparator",  VertSplit)
hl(0, "TabLine",       TabLine)
hl(0, "TabLineFill",   TabLine)
hl(0, "StatusLine",    { fg = c.c01, bg = c.c08, bold = true })
hl(0, "StatusLineNC",  { fg = c.c01, bg = c.c11 })
hl(0, "TabLineSel",    { fg = c.c11, bg = c.c02, bold = true })

------------------- floating windows

hl(0, "NormalFloat",   Normal)
hl(0, "Pmenu",         { bg = c11 })
hl(0, "PmenuSel",      { bg = c.c09, bold = true })
hl(0, "PmenuSbar",     { fg = c.wht, bg = c.c02 })
hl(0, "PmenuThumb",    { fg = c.wht, bg = c.c04 })

------------------- syntax

hl(0, "Comment",   Comment)
hl(0, "String",    String)
hl(0, "Constant",  String)
hl(0, "Character", String)
hl(0, "Number",    Number)
hl(0, "Boolean",   Number)
hl(0, "Float",     Number)

hl(0, "Identifier", Normal)
hl(0, "Function",   { fg = c.org })
hl(0, "Statement",  { fg = c.red })
hl(0, "Conditional",{ fg = c.red })
hl(0, "Repeat",     { fg = c.red })
hl(0, "Label",      { fg = c.red })
hl(0, "Operator",   { fg = c.blu })
hl(0, "Keyword",    { fg = c.red, bold = true })
hl(0, "Exception",  { fg = c.red })

hl(0, "PreProc",    { fg = c.prp })
hl(0, "Include",    { fg = c.prp })
hl(0, "Define",     { fg = c.prp })
hl(0, "Macro",      { fg = c.prp })
hl(0, "PreCondit",  { fg = c.prp })

hl(0, "Type",        { fg = c.grb })
hl(0, "StorageClass",{ fg = c.grb })
hl(0, "Structure",   { fg = c.grb })
hl(0, "Typedef",     { fg = c.grb })

hl(0, "Special",      { fg = c.prp })
hl(0, "SpecialChar",  { fg = c.prp })
hl(0, "Tag",          { fg = c.prp })
hl(0, "Delimiter",    { fg = c.prp })
hl(0, "Debug",        { fg = c.prp })

hl(0, "Underlined",  { underline = true })
hl(0, "Bold",        { bold = true })
hl(0, "Italic",      { italic = true })
hl(0, "Ignore",      {  })
hl(0, "Error",       Error)
hl(0, "Todo",        Warning)

------------------- treesitter

hl(0, "@variable",        { fg = c.c02 })
hl(0, "@variable.builtin",{ fg = c.red })
hl(0, "@property",        { fg = c.blp })
hl(0, "@field",           { fg = c.blu })
hl(0, "@parameter",       { fg = c.org })

hl(0, "@function",        { fg = c.org })
hl(0, "@function.builtin",{ fg = c.blu, italic = true })
hl(0, "@function.macro",  { fg = c.blg })

hl(0, "@method",          { fg = c.blu })
hl(0, "@constructor",     { fg = c.yel })

hl(0, "@keyword",         { fg = c.org, bold = true })
hl(0, "@keyword.function",{ fg = c.org, bold = true })
hl(0, "@keyword.return",  { fg = c.red, bold = true })
hl(0, "@conditional",     { fg = c.red })
hl(0, "@repeat",          { fg = c.prp })
hl(0, "@operator",        { fg = c.blu })

hl(0, "@string",          { fg = c.blu })
hl(0, "@string.escape",   { fg = c.blu })
hl(0, "@string.regex",    { fg = c.blu })
hl(0, "@string.special",  { fg = c.blu })

hl(0, "@comment",         { fg = c.c07, italic = true })
hl(0, "@comment.warning", { fg = c.yel, bold = true })
hl(0, "@comment.error",   { fg = c.wht, bg = c.red })

hl(0, "@constant.builtin",{ fg = c.blu, italic = true })
hl(0, "@constant",        Number)
hl(0, "@number",          Number)
hl(0, "@boolean",         Number)

hl(0, "@type",            { fg = c.grb })
hl(0, "@type.builtin",    { fg = c.yel })
hl(0, "@attribute",       { fg = c.blu })
hl(0, "@namespace",       { fg = c.c04 })
hl(0, "@punctuation",     { fg = c.c04 })
hl(0, "@tag",             { fg = c.red })
hl(0, "@tag.attribute",   { fg = c.blu })
hl(0, "@tag.delimiter",   { fg = c.c04 })

hl(0, "@text",            { fg = c.c02 })
hl(0, "@text.title",      { fg = c.blu, bold = true })
hl(0, "@text.literal",    { fg = c.grb })
hl(0, "@text.uri",        { fg = c.blu, underline = true })
hl(0, "@text.reference",  { fg = c.prp })

------------------- diagnostics, LSP

hl(0, "DiagnosticError",  { fg = c.red })
hl(0, "DiagnosticWarn",   { fg = c.yel })
hl(0, "DiagnosticInfo",   { fg = c.blg })
hl(0, "DiagnosticHint",   { fg = c.blu })

hl(0, "DiagnosticVirtualTextError", { fg = c.red, bg = c.bg_high })
hl(0, "DiagnosticVirtualTextWarn",  { fg = c.yel, bg = c.bg_high })
hl(0, "DiagnosticVirtualTextInfo",  { fg = c.blg, bg = c.bg_high })
hl(0, "DiagnosticVirtualTextHint",  { fg = c.blu, bg = c.bg_high })

hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = c.red })
hl(0, "DiagnosticUnderlineWarn",  { undercurl = true, sp = c.yel })
hl(0, "DiagnosticUnderlineInfo",  { undercurl = true, sp = c.blg })
hl(0, "DiagnosticUnderlineHint",  { undercurl = true, sp = c.blu })

hl(0, "LspReferenceText",  { bg = c.blk })
hl(0, "LspReferenceRead",  { bg = c.blk })
hl(0, "LspReferenceWrite", { bg = c.blk })
hl(0, "LspInlayHint",      { fg = c.blk, bg = c.blk, italic = true })

------------------- diff

hl(0, "DiffAdd",    { fg = c.blk, bg = c.c10 })
hl(0, "DiffChange", { fg = c.wht, bg = c.c08 })
hl(0, "DiffText",   { fg = c.blk, bg = c.c08 })
hl(0, "DiffDelete", { fg = c.c10, bg = c.c10 })

------------------- git

hl(0, "GitSignsAdd",    { fg = c.grb })
hl(0, "GitSignsChange", { fg = c.yel })
hl(0, "GitSignsDelete", { fg = c.red })

------------------- markdown

hl(0, "MarkdownHeadingDelimiter", { fg = c.blg })
hl(0, "MarkdownCode",             { fg = c.grb })
hl(0, "MarkdownCodeBlock",        { fg = c.grb })
hl(0, "MarkdownLinkText",         { fg = c.blu, underline = true })
hl(0, "MarkdownUrl",              { fg = c.blu, underline = true })

------------------- plugins

hl(0, "BlinkCmpMenu",         { fg = c.blk, bg = c.c11 })

hl(0, "BufferCurrentSign",    { bg = c.c02 })      -- line between barbar tabs

hl(0, "TelescopeNormal",      { bg = c.c11 })
hl(0, "TelescopeSelection",   { bg = c.c09, bold = true })
hl(0, "TelescopeBorder",      VertSplit)
hl(0, "TelescopePromptBorder",VertSplit)
hl(0, "TelescopePromptNormal",{ fg = c.c02, bg = c.wht })
hl(0, "TelescopePromptPrefix",{ fg = c.c02, bg = c.wht })
hl(0, "TelescopeMatching",    { fg = c.c04, bold = true })

hl(0, "NvimTreeNormal",       { fg = c.c02, bg = c.bg })
hl(0, "NvimTreeEndOfBuffer",  { fg = c.wht, bg = c.wht })
hl(0, "NvimTreeFolderName",   { fg = c.blg })
hl(0, "NvimTreeRootFolder",   { fg = c.red, bold = true })
hl(0, "NvimTreeGitDirty",     { fg = c.yel })
hl(0, "NvimTreeGitNew",       { fg = c.grb })
hl(0, "NvimTreeGitDeleted",   { fg = c.red })

hl(0, "CmpItemAbbr",          { fg = c.c02 })
hl(0, "CmpItemAbbrMatch",     { fg = c.yel, bold = true })
hl(0, "CmpItemAbbrMatchFuzzy",{ fg = c.yel, bold = true })
hl(0, "CmpItemMenu",          { fg = c.c04 })
hl(0, "CmpItemKindFunction",  { fg = c.blg })
hl(0, "CmpItemKindMethod",    { fg = c.blg })
hl(0, "CmpItemKindVariable",  { fg = c.c02 })
hl(0, "CmpItemKindKeyword",   { fg = c.red })
hl(0, "CmpItemKindText",      { fg = c.grb })
hl(0, "CmpItemKindSnippet",   { fg = c.prp })

hl(0, "DashboardHeader",      { fg = c.blg, bold = true })
hl(0, "DashboardCenter",      { fg = c.c02 })
hl(0, "DashboardShortcut",    { fg = c.blu })
hl(0, "DashboardFooter",      { fg = c.c07, italic = true })

hl(0, "WhichKey",             { fg = c.blg })
hl(0, "WhichKeyGroup",        { fg = c.prp })
hl(0, "WhichKeyDesc",         { fg = c.c02 })
hl(0, "WhichKeySeparator",    { fg = c.c04 })
hl(0, "WhichKeyFloat",        { bg = c.c11 })

hl(0, "CodeBlock", { fg=c.c_01, bg=c.c11 })  -- headlines
hl(0, "Headline1", { fg=c.wht,  bg=c.c01 })
hl(0, "Headline2", { fg=c.wht,  bg=c.c03 })
hl(0, "Headline3", { fg=c.wht,  bg=c.c05 })
hl(0, "Headline4", { fg=c.wht,  bg=c.c07 })
hl(0, "Dash",      { fg=c.c_04, bg=c.wht })

hl(0, "MoltenCell", {})                       -- molten, defaults to CursorLine, but don't want that

--=============================================================================
-- link groups

vim.cmd([[
  hi! link TSComment  Comment
  hi! link TSString   String
  hi! link TSKeyword  Keyword
  hi! link TSFunction Function
  hi! link TSVariable Identifier
  hi! link TSConstant Constant
]])

return M
