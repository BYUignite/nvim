local base = require('repent-base')
local c = require('repent-palette').c

local pkg = function()
    return {
        --TelescopeNormal    { bg=c.wht },
        --TelescopeSelection { bg=c.c07, gui="bold" },
        TelescopeNormal    { base.Pmenu },
        TelescopeSelection { base.PmenuSel },
    }
end

return pkg  
