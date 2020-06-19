
"" https://vim.fandom.com/wiki/Display_output_of_shell_commands_in_new_window
"command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
"function! s:RunShellCommand(cmdline)
"  echo a:cmdline
"  let expanded_cmdline = a:cmdline
"  for part in split(a:cmdline, ' ')
"     if part[0] =~ '\v[%#<]'
"        let expanded_part = fnameescape(expand(part))
"        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
"     endif
"  endfor
"  botright new
"  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
"  call setline(1, 'You entered:    ' . a:cmdline)
"  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
"  call setline(3,substitute(getline(2),'.','=','g'))
"  execute '$read !'. expanded_cmdline
"  setlocal nomodifiable
"  1
"endfunction

" https://stackoverflow.com/questions/40289706/execute-selection-from-script-in-vim/40290101
":xnoremap <leader>r :w !ipython3 --no-confirm-exit --no-term-title %<cr>
:xnoremap <leader>r :w !python3 %<cr>

"set foldmethod=indent            " for python: za toggles, space opens, etc
"set foldnestmax=2                " don't fold too deep (python)
"set foldlevelstart=99            " open all to start (python)

