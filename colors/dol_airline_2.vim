let g:airline#themes#dol_airline_2#palette = {}

let g:airline#themes#dol_airline_2#palette.accents = {
      \ 'red': [ '#87d7d7' , '' , 116 , '' , '' ],
      \ }

" Normal Mode:
let s:N3 = [ '#585858' , '#eeeeee' , 240 , 255 ] " Mode
let s:N2 = [ '#eeeeee' , '#0087af' , 255 , 31  ] " Info
let s:N1 = [ '#eeeeee' , '#005f87' , 255 , 24  ] " StatusLine


let g:airline#themes#dol_airline_2#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#dol_airline_2#palette.normal_modified = {
      \ 'airline_c': [ '#eeeeee' , '#005f87' , 255 , 24 , '' ] ,
      \ }


" Insert Mode:
let s:I3 = [ '#585858' , '#eeeeee' , 240 , 255 ] " Mode
let s:I2 = [ '#eeeeee' , '#0087af' , 255 , 31  ] " Info
let s:I1 = [ '#eeeeee' , '#005f87' , 255 , 24  ] " StatusLine


let g:airline#themes#dol_airline_2#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#dol_airline_2#palette.insert_modified = {
      \ 'airline_c': [ '#eeeeee' , '#005f87' , 255 , 24 , '' ] ,
      \ }


" Replace Mode:
let g:airline#themes#dol_airline_2#palette.replace = copy(g:airline#themes#dol_airline_2#palette.insert)
let g:airline#themes#dol_airline_2#palette.replace.airline_a = [ '#d70000'   , '#eeeeee' , 161 , 255, ''     ]
let g:airline#themes#dol_airline_2#palette.replace_modified = {
      \ 'airline_c': [ '#eeeeee' , '#005f87' , 255 , 24 , '' ] ,
      \ }


" Visual Mode:
let s:V3 = [ '#005f87', '#eeeeee', 24,  255 ]
let s:V2 = [ '',        '#0087af', '',  31  ]
let s:V1 = [ '#eeeeee', '#005f87', 255, 24  ]

let g:airline#themes#dol_airline_2#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#dol_airline_2#palette.visual_modified = {
      \ 'airline_c': [ '#eeeeee', '#005f87', 255, 24  ] ,
      \ }

" Inactive:
let s:IA = [ '#585858' , '#eeeeee' , 240 , 255 , '' ]
let g:airline#themes#dol_airline_2#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)
let g:airline#themes#dol_airline_2#palette.inactive_modified = {
      \ 'airline_c': [ '#585858' , '#eeeeee' , 240 , 255 , '' ] ,
      \ }


" CtrlP:
if !get(g:, 'loaded_ctrlp', 0)
  finish
endif
let g:airline#themes#dol_airline_2#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
      \ [ '#eeeeee' , '#005f87' , 255 , 24  , ''     ] ,
      \ [ '#eeeeee' , '#0087af' , 255 , 31  , ''     ] ,
      \ [ '#585858' , '#eeeeee' , 240 , 255 , 'bold' ] )


" Type :ColorHighlight to see colors here, with the Colorizer plugin
" Airline colors
"#005f87  24    (0,95,135)
"#0087af  31    (0,135,175)
"#87d7d7  116   (135,215,255)
"#d70000  160   (215,0,0)
"#585858  240   (88,88,88)
"#eeeeee  255   (238, 238, 238)

" Other colors
"#00875f  29    (0, 135, 95)
"#5f005f  53    (95, 0, 95)
"#9e9e9e  247   (158, 158, 158)
"#dadada  253   (218, 218, 218)
