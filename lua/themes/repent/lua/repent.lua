local lush  = require('lush')
local theme = require("repent-base")

---------------------------------------------------------------------------
-- add in packages

theme = lush.extends({theme}).with(require("pkgs_repent.telescope"))
return theme
