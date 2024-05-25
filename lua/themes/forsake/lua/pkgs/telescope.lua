local base = require('forsake-base')
local c = require('forsake-palette').c

local pkg = function()
    return {
        TelescopeNormal    { bg=c.c_5 },
        TelescopeSelection { bg=c.c_1, gui="bold" },
    }
end

return pkg  
