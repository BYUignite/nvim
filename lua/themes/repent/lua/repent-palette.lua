
local lush = require('lush')
local hsl = lush.hsl

M = {}

M.c = {

    blk = hsl(210, 00,  0),  -- #000000 
    c00 = hsl(210, 60, 14),  -- #0e2439 
    c01 = hsl(210, 50, 22),  -- #1c3854
    c02 = hsl(210, 40, 30),  -- #2e4d6b 
    c03 = hsl(210, 30, 38),  -- #44617e 
    c04 = hsl(210, 20, 46),  -- #5e758d
    c05 = hsl(210, 20, 54),  -- #728aa1
    c06 = hsl(210, 20, 62),  -- #8b9eb1
    c07 = hsl(210, 20, 70),  -- #a3b3c2
    c08 = hsl(210, 20, 78),  -- #bcc7d2
    c09 = hsl(210, 20, 86),  -- #d4dbe2
    c10 = hsl(210, 20, 94),  -- #edf0f3
    c11 = hsl(210, 20, 96),  -- #f3f5f7
    wht = hsl(210, 00,100),  -- #ffffff

    red = hsl(  0, 50, 40),  -- #bf4040
    org = hsl( 30, 50, 40),  -- #bf8040
    yel = hsl( 60, 50, 40),  -- #bfbf40
    ylg = hsl( 90, 50, 40),  -- #80bf40
    grn = hsl(120, 50, 30),  -- #339933
    grb = hsl(150, 50, 30),  -- #339966
    blg = hsl(180, 50, 30),  -- #339999
    blu = hsl(210, 50, 40),  -- #4080bf
    blp = hsl(240, 50, 40),  -- #4040bf
    prb = hsl(270, 50, 40),  -- #8040bf
    pnk = hsl(300, 50, 40),  -- #bf40bf
    prp = hsl(320, 50, 40),  -- #bf4095
    ppr = hsl(350, 50, 40),  -- #bf4055

    -- # hsl(210, 20, 30) #3d4d5c  -- wallpaper
}

return M
