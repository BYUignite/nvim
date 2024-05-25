
local lush = require('lush')
local hsl = lush.hsl

M = {}

M.c = {
    blk = hsl(000, 00,  0),  -- #000000
    c_9 = hsl(203, 67,  2),  -- #02070a
    c_8 = hsl(204, 65,  5),  -- #040d13
    c_7 = hsl(203, 66,  7),  -- #06141d
    c_6 = hsl(202, 65,  9),  -- #081b26
    c_5 = hsl(203, 63, 12),  -- #0b2230
    c_4 = hsl(203, 63, 14),  -- #0d283a
    c_3 = hsl(203, 63, 16),  -- #0f2f43
    c_2 = hsl(203, 64, 18),  -- #11364d
    c_1 = hsl(203, 64, 21),  -- #133c56
    c00 = hsl(203, 64, 23),  -- #154360 -- base color: https://imagecolorpicker.com/color-code/154360
    c01 = hsl(203, 44, 31),  -- #2c5670
    c02 = hsl(203, 31, 38),  -- #446890
    c03 = hsl(204, 23, 46),  -- #5b7b90
    c04 = hsl(204, 19, 54),  -- #738ea0
    c05 = hsl(204, 19, 62),  -- #8aa1b0
    c06 = hsl(202, 19, 69),  -- #a1b4bf
    c07 = hsl(202, 19, 77),  -- #b9c7cf
    c08 = hsl(204, 19, 85),  -- #d0d9df
    c09 = hsl(202, 19, 88),  -- #dce3e7 -- *
    c10 = hsl(206, 18, 92),  -- #e8ecef
    c11 = hsl(204, 19, 95),  -- #eff2f4 -- *
    wht = hsl(000, 00,100),  -- #ffffff

    red = hsl(  3, 38, 56),
    org = hsl( 33, 78, 36),
    yel = hsl( 63, 60, 60),
    ylg = hsl( 93, 64, 43),
    grn = hsl(123, 40, 39),
    grb = hsl(153, 34, 42),
    blg = hsl(183, 64, 33),
    blu = hsl(204, 23, 55), --hsl(213, 38, 56),
    blp = hsl(243, 54, 43),
    prb = hsl(273, 54, 43),
    pnk = hsl(303, 49, 79),
    prp = hsl(323, 54, 38),
    ppr = hsl(353, 60, 42),
}

return M
