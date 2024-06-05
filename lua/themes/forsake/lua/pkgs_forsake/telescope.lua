local base = require('forsake-base')
local c = require('forsake-palette').c

local pkg = function()
    return {
        --TelescopeNormal    { bg=c.blk },
        --TelescopeSelection { bg=c.c_1, gui="bold" },
        TelescopeNormal    { base.Pmenu },
        TelescopeSelection { base.PmenuSel },
    }
end

return pkg  
