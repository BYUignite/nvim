local lush  = require('lush')
local theme = require("forsake-base")

---------------------------------------------------------------------------
-- add in packages

theme = lush.extends({theme}).with(require("pkgs_forsake.telescope"))
theme = lush.extends({theme}).with(require("cmake"))
return theme
