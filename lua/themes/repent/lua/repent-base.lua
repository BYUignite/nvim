--
-- Built with,
--
--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--

-- This is a starter colorscheme for use with Lush,
-- for usage guides, see :h lush or :LushRunTutorial

--
-- Note: Because this is a lua file, vim will append it to the runtime,
--       which means you can require(...) it in other lua code (this is useful),
--       but you should also take care not to conflict with other libraries.
--
--       (This is a lua quirk, as it has somewhat poor support for namespacing.)
--
--       Basically, name your file,
--
--       "super_theme/lua/lush_theme/super_theme_dark.lua",
--
--       not,
--
--       "super_theme/lua/dark.lua".
--
--       With that caveat out of the way...
--

-- Enable lush.ify on this file, run:
--
--  `:Lushify`
--
--  or
--
--  `:lua require('lush').ify()`

local c = require("repent-palette").c

-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
  local sym = injected_functions.sym
  return {
    -- The following are the Neovim (as of 0.8.0-dev+100-g371dfb174) highlight
    -- groups, mostly used for styling UI elements.
    -- Comment them out and add your own properties to override the defaults.
    -- An empty definition `{}` will clear all styling, leaving elements looking
    -- like the 'Normal' group.
    -- To be able to link to a group, it must already be defined, so you may have
    -- to reorder items as you go.
    --
    -- See :h highlight-groups
    -- See :Inspect to see group under cursor

    -- for headlines plugin
    CodeBlock { fg=c.c_00, bg=c.c11 },
    Headline1  { fg=c.wht, bg=c.c02 },
    Headline2  { fg=c.wht, bg=c.c04 },
    Headline3  { fg=c.wht, bg=c.c06 },
    Dash      { fg=c.c_03, bg=c.wht },
    -- for molten plugin
    MoltenCell {},                              -- defaults to CursorLine, but we don't want that
    --

    Normal         { fg=c.c01, bg=c.wht },      -- Normal text
    NormalFloat    { Normal },                  -- Normal text in floating windows.
    FloatTitle     { Normal },                  -- Title of floating windows.
    NormalNC       { Normal },                  -- normal text in non-current windows

    -- cmakeArguments { Normal },
    -- cmakeKWtarget_sources { Normal },
    -- cmakeKWinstall { Normal },
    -- cmakeKWtry_compile { Normal },
    -- cmakeKWfind_program { Normal },
    -- cmakeKWset_tests_properties { Normal },
    -- cmakeKWget_cmake_property { Normal },
    -- cmakeKWwrite_file { Normal },
    -- cmakeKWset_source_files_properties { Normal },
    -- cmakeKWset_property { Normal },

    MatchParen     { fg=c.wht, bg=c.c04 },      -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    Folded         { fg=c.c07 },                -- Line used for closed folds

    EndOfBuffer    { Normal },                  -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.

    Search         { fg=c.wht, bg=c.c04 },      -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
    IncSearch      { Search },                  -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    CurSearch      { Search },                  -- Highlighting a search pattern under the cursor (see 'hlsearch')
    Substitute     { Search },                  -- |:substitute| replacement text highlighting

    TabLineFill    { fg=c.c01, bg=c.c10 },      -- Tab pages line, where there are no labels
    TabLine        { TabLineFill },             -- Tab pages line, not active tab page label
    TabLineSel     { fg=c.c10, bg=c.c01, gui="bold" },       -- Tab pages line, active tab page label
    WinBar         { fg=c.wht, bg=c.c00 },      -- Window bar of current window
    WinBarNC       { fg=c.wht, bg=c.c02 },      -- Window bar of not-current windows

    SLine1 { TabLineSel, gui = "bold" },        -- NEW: Helpers for formatting status line elements
    Trans1 { fg=c.c01, bg=c.c07},
    SLine2 { fg=c.c00, bg=c.c07, gui="bold" },
    Trans2 { fg=c.c07, bg=c.c10},
    SLine3 { fg=c.c00, bg=c.c10 },
    Trans3 { fg=c.c01, bg=c.c10},

    StatusLine     { fg=c.c00, bg=c.c07, gui="bold" }, -- Status line of current window
    StatusLineNC   { fg=c.c00, bg=c.c10},              -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.

    Visual         { bg=c.c09 },                -- Visual mode selection
    VisualNOS      { Visual },                  -- Visual mode selection when vim is "Not Owning the Selection".

    VertSplit      { fg=c.c02 },                -- Column separating vertically split windows
    Winseparator   { VertSplit },               -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
    -- FloatBorder    { },                      -- Border of floating windows.

    Cursor         { bg=c.blk, fg=c.wht },      -- Character under the cursor
    lCursor        { Cursor },                  -- Character under the cursor when |language-mapping| is used (see 'guicursor')
    CursorIM       { Cursor },                  -- Like Cursor, but used when in IME mode |CursorIM|
    CursorLine     { gui="bold" },              -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
    CursorColumn   { bg=c.c10 },                -- Screen-column at the cursor, when 'cursorcolumn' is set.
    TermCursor     { Cursor },                  -- Cursor in a focused terminal
    TermCursorNC   { bg=c.c06, fg=c.c10 },      -- Cursor in an unfocused terminal

    LineNr         { fg=c.c09 },                -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    LineNrAbove    { LineNr   },                -- Line number for when the 'relativenumber' option is set, above the cursor line
    LineNrBelow    { LineNrAbove },             -- Line number for when the 'relativenumber' option is set, below the cursor line
    CursorLineNr   { fg=c.c05},                 -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    FoldColumn     { fg=c.c05 },                -- 'foldcolumn'
    SignColumn     { FoldColumn},               -- Column where |signs| are displayed
    CursorLineFold { FoldColumn},               -- Like FoldColumn when 'cursorline' is set for the cursor line
    CursorLineSign { SignColumn},               -- Like SignColumn when 'cursorline' is set for the cursor line

    Pmenu          { bg=c.c10},                 -- Popup menu: Selected item.
    PmenuSel       { bg=c.c08, gui="bold" },    -- Popup menu: Normal item.
    PmenuKind      { Pmenu },                   -- Popup menu: Normal item "kind"
    PmenuKindSel   { PmenuSel},                 -- Popup menu: Selected item "kind"
    PmenuExtra     { Pmenu},                    -- Popup menu: Normal item "extra text"
    PmenuExtraSel  { PmenuSel},                 -- Popup menu: Selected item "extra text"
    PmenuSbar      { fg=c.wht, bg=c.c01 },      -- Popup menu: Scrollbar.
    PmenuThumb     { fg=c.wht, bg=c.c03},       -- Popup menu: Thumb of the scrollbar.

    SpellBad       { gui="undercurl, bold" },   -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap       { gui="undercurl, bold" },   -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellLocal     { gui="undercurl, bold" },   -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare      { gui="undercurl, bold" },   -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.

    DiffAdd        { bg=c.grb, fg=c.wht },      -- Diff mode: Added line |diff.txt|
    DiffChange     { bg=c.org, fg=c.blk},       -- Diff mode: Changed line |diff.txt|
    DiffText       { DiffChange, fg=c.wht},     -- Diff mode: Changed text within a changed line |diff.txt|
    DiffDelete     { bg=c.red, fg=c.wht },      -- Diff mode: Deleted line |diff.txt|

    WarningMsg     { bg=c.yel.li(20) },         -- Warning messages
    ErrorMsg       { fg=c.wht, bg=c.red },      -- Error messages on the command line

    ModeMsg        { fg=c.wht, bg=c.c01 },      -- 'showmode' message (e.g., "-- INSERT -- ")
    MsgArea        { Normal },                  -- Area for messages and cmdline
    MoreMsg        { Normal },                  -- |more-prompt|
    MsgSeparator   { Normal },                  -- Separator for scrolled messages, `msgsep` flag of 'display'

    Title          { fg=c.red, gui="bold" },    -- Titles for output from ":set all", ":autocmd" etc.
    Directory      { Normal },                  -- Directory names (and other special names in listings)
    Whitespace     { Normal },                  -- "nbsp", "space", "tab" and "trail" in 'listchars'
    WildMenu       { Normal },                  -- Current match in 'wildmenu' completion
    Question       { Normal },                  -- |hit-enter| prompt and yes/no questions
    QuickFixLine   { Normal },                  -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    Conceal        { Normal },                  -- Placeholder characters substituted for concealed text (see 'conceallevel')
    ColorColumn    { Normal },                  -- Columns set with 'colorcolumn'
    SpecialKey     { fg=c.red },                -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
    NonText        { TabLine },                 -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.







    -- Common vim syntax groups used for all kinds of code and markup.
    -- Commented-out groups should chain up to their preferred (*) group
    -- by default.
    --
    -- See :h group-name
    --
    -- Uncomment and edit if you want more specific syntax highlighting.

    Comment        { fg=c.c06, gui="italic" },           -- Any comment
    SpecialComment { Comment, gui="italic" },            -- Special things inside a comment (e.g. '\n')

    String         { fg=c.blu },           -- A string constant: "this is a string"
    Constant       { String },             -- (*) Any constant
    Character      { String },             -- A character constant: 'c', '\n'
    Number         { fg=c.blu },           -- A number constant: 234, 0xff
    Boolean        { Number },             -- A boolean constant: TRUE, false
    Float          { Number },             -- A floating point constant: 2.3e10

    Identifier     { Normal },             -- (*) Any variable name
    Function       { fg=c.org },           --   Function name (also: methods for classes)

    Statement      { fg=c.red },           -- (*) Any statement
    Conditional    { fg=c.red },           -- if, then, else, endif, switch, etc.
    Repeat         { fg=c.red },           -- for, do, while, etc.
    Label          { fg=c.red },           -- case, default, etc.
    Operator       { fg=c.red },           -- "sizeof", "+", "*", etc.
    Keyword        { fg=c.red },           -- any other keyword
    Exception      { fg=c.red },           -- try, catch, throw

    Include        { fg=c.prp },           -- Preprocessor #include
    PreProc        { Include },            -- (*) Generic Preprocessor
    Define         { Include },            -- Preprocessor #define
    Macro          { Include },            -- Same as Define
    PreCondit      { Include },            -- Preprocessor #if, #else, #endif, etc.

    Type           { fg=c.grn },           -- (*) int, long, char, etc.
    StorageClass   { Type },               -- static, register, volatile, etc.
    Structure      { Type },               -- struct, union, enum, etc.
    Typedef        { Type },               -- A typedef

    Special        { fg=c.prp },           -- (*) Any special symbol
    SpecialChar    { Special},             -- Special character in a constant
    Tag            { Special},             -- You can use CTRL-] on this
    Delimiter      { Special},             -- Character that needs attention
    Debug          { Special},             -- Debugging statements

    Underlined     { gui="underlined" },   -- Text that stands out, HTML links
    Ignore         { },                    -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
    Error          { ErrorMsg },           -- Any erroneous construct
    Todo           { WarningMsg },         -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    -- These groups are for the native LSP client and diagnostic system. Some
    -- other LSP clients may use these groups, or use their own. Consult your
    -- LSP client's documentation.

    -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
    --
    -- LspReferenceText            { } , -- Used for highlighting "text" references
    -- LspReferenceRead            { } , -- Used for highlighting "read" references
    -- LspReferenceWrite           { } , -- Used for highlighting "write" references
    -- LspCodeLens                 { } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
    -- LspCodeLensSeparator        { } , -- Used to color the seperator between two or more code lens.
    -- LspSignatureActiveParameter { } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

    -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
    --
    -- DiagnosticError            { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticWarn             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticInfo             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticHint             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticOk               { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticVirtualTextError { } , -- Used for "Error" diagnostic virtual text.
    -- DiagnosticVirtualTextWarn  { } , -- Used for "Warn" diagnostic virtual text.
    -- DiagnosticVirtualTextInfo  { } , -- Used for "Info" diagnostic virtual text.
    -- DiagnosticVirtualTextHint  { } , -- Used for "Hint" diagnostic virtual text.
    -- DiagnosticVirtualTextOk    { } , -- Used for "Ok" diagnostic virtual text.
    -- DiagnosticUnderlineError   { } , -- Used to underline "Error" diagnostics.
    -- DiagnosticUnderlineWarn    { } , -- Used to underline "Warn" diagnostics.
    -- DiagnosticUnderlineInfo    { } , -- Used to underline "Info" diagnostics.
    -- DiagnosticUnderlineHint    { } , -- Used to underline "Hint" diagnostics.
    -- DiagnosticUnderlineOk      { } , -- Used to underline "Ok" diagnostics.
    -- DiagnosticFloatingError    { } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
    -- DiagnosticFloatingWarn     { } , -- Used to color "Warn" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingInfo     { } , -- Used to color "Info" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingHint     { } , -- Used to color "Hint" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingOk       { } , -- Used to color "Ok" diagnostic messages in diagnostics float.
    -- DiagnosticSignError        { } , -- Used for "Error" signs in sign column.
    -- DiagnosticSignWarn         { } , -- Used for "Warn" signs in sign column.
    -- DiagnosticSignInfo         { } , -- Used for "Info" signs in sign column.
    -- DiagnosticSignHint         { } , -- Used for "Hint" signs in sign column.
    -- DiagnosticSignOk           { } , -- Used for "Ok" signs in sign column.

    -- Tree-Sitter syntax groups.
    --
    -- See :h treesitter-highlight-groups, some groups may not be listed,
    -- submit a PR fix to lush-template!
    --
    -- Tree-Sitter groups are defined with an "@" symbol, which must be
    -- specially handled to be valid lua code, we do this via the special
    -- sym function. The following are all valid ways to call the sym function,
    -- for more details see https://www.lua.org/pil/5.html
    --
    -- sym("@text.literal")
    -- sym('@text.literal')
    -- sym"@text.literal"
    -- sym'@text.literal'
    --
    -- For more information see https://github.com/rktjmp/lush.nvim/issues/109

    -- sym"@text.literal"      { }, -- Comment
    -- sym"@text.reference"    { }, -- Identifier
    -- sym"@text.title"        { }, -- Title
    -- sym"@text.uri"          { }, -- Underlined
    -- sym"@text.underline"    { }, -- Underlined
    -- sym"@text.todo"         { }, -- Todo
    -- sym"@comment"           { }, -- Comment
    -- sym"@punctuation"       { }, -- Delimiter
    -- sym"@constant"          { }, -- Constant
    -- sym"@constant.builtin"  { }, -- Special
    -- sym"@constant.macro"    { }, -- Define
    -- sym"@define"            { }, -- Define
    -- sym"@macro"             { }, -- Macro
    -- sym"@string"            { }, -- String
    -- sym"@string.escape"     { }, -- SpecialChar
    -- sym"@string.special"    { }, -- SpecialChar
    -- sym"@character"         { }, -- Character
    -- sym"@character.special" { }, -- SpecialChar
    -- sym"@number"            { }, -- Number
    -- sym"@boolean"           { }, -- Boolean
    -- sym"@float"             { }, -- Float
    -- sym"@function"          { }, -- Function
    -- sym"@function.builtin"  { }, -- Special
    -- sym"@function.macro"    { }, -- Macro
    -- sym"@parameter"         { }, -- Identifier
    -- sym"@method"            { }, -- Function
    -- sym"@field"             { }, -- Identifier
    -- sym"@property"          { }, -- Identifier
    -- sym"@constructor"       { }, -- Special
    -- sym"@conditional"       { }, -- Conditional
    -- sym"@repeat"            { }, -- Repeat
    -- sym"@label"             { }, -- Label
    -- sym"@operator"          { }, -- Operator
    -- sym"@keyword"           { }, -- Keyword
    -- sym"@exception"         { }, -- Exception
    -- sym"@variable"          { }, -- Identifier
    -- sym"@type"              { }, -- Type
    -- sym"@type.definition"   { }, -- Typedef
    -- sym"@storageclass"      { }, -- StorageClass
    -- sym"@structure"         { }, -- Structure
    -- sym"@namespace"         { }, -- Identifier
    -- sym"@include"           { }, -- Include
    -- sym"@preproc"           { }, -- PreProc
    -- sym"@debug"             { }, -- Debug
    -- sym"@tag"               { }, -- Tag
}
end)

-- Return our parsed theme for extension or use elsewhere.
return theme

-- vi:nowrap
