local base = require('repent-base')
local c = require('repent-palette').c

local pkg = function()
    return {
        TelescopeNormal    { bg=c.c10 },
        TelescopeSelection { bg=c.c07, gui="bold" },
    }
end

return pkg  
