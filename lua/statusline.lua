-- https://alpha2phi.medium.com/neovim-for-beginners-status-line-dd0c97fba978
-- https://zignar.net/2022/01/21/a-boring-statusline-for-neovim/

------------------------------------------------------------
-- Replace vim mode keys with spelled out version

local modeMap = {
  ['n']      = 'NORMAL',
  ['i']      = 'INSERT',
  ['R']      = 'REPLACE',
  ['r']      = 'REPLACE',
  ['v']      = 'VISUAL',
  ['vs']     = 'VISUAL',
  ['V']      = 'VISUAL',
  ['Vs']     = 'VISUAL',
  ['s']      = 'SELECT',
  ['cv']     = 'EX',
  ['ce']     = 'EX',
  ['c']      = 'COMMAND',
  ['t']      = 'TERMINAL',
  ['!']      = 'SHELL',
}

local function expand_mode_to_string()
    local mode = vim.api.nvim_get_mode().mode
    return modeMap[mode] or mode
end

------------------------------------------------------------
-- Functions for adding git branch
-- Based on https://wenijinew.medium.com/vim-show-git-branch-name-in-status-line-87d942234c21
-- Two autocommands: one sets the directory to that of the current file.
--    The other sets a vim variable to the git branch on enter/new buffer; 
--    that var is used in statusline

local autocmd = vim.api.nvim_create_autocmd

autocmd({"BufEnter", "BufNew"}, {        -- update gitbranch variable for use in statusline
    callback = function()
        if vim.bo.buftype ~= "terminal" then
            --vim.cmd("lcd %:p:h")             -- connect to directory of current file; BREAKS fugitive's :Gvdiffsplit command
            local res = vim.fn.system({'git', 'rev-parse',  '--abbrev-ref', 'HEAD'})
            vim.g.gitbranchSL = "fatal:" == string.sub(res, 1, 6) and "" or " " .. string.sub(res,1,#res-1)
        end
    end
})

------------------------------------------------------------
-- Create the statusline string
-- Note, making use of highlight groups SLine1, etc. These should be set in the theme.

vim.g.gitbranchSL = ""

function make_status_line()

  local mode        = "%#SLine1#%-6( " .. expand_mode_to_string() .. " %)"
  local trans1      = "%#Trans1#%(%)"
  local file_name   = "%#SLine2# %-.30t "
  local trans2      = "%#Trans2#%(%)"
  local git         = "%#SLine3# " .. vim.g.gitbranchSL
  local right_align = "%="
  local trans3      = "%#Trans3#%(%)" 
  local line_num    = "%#SLine1# %(   %l/%L%)"
  local col_num     = "%5( 〣 %c %)"

  return mode .. trans1 .. file_name .. trans2 .. git ..
         right_align .. trans3 .. line_num .. col_num
end

------------------------------------------------------------
-- Execute the statusline

vim.opt.statusline = "%{%v:lua.make_status_line()%}"
vim.opt.laststatus = 3

