scriptencoding utf-8
if exists('g:sana_natori_vim#loaded')
  finish
endif

let g:sana_natori_vim#loaded = 1

if !exists('g:sana_natori_vim#play_command') || !executable(g:sana_natori_vim#play_command)
  if executable('play')
    let g:sana_natori_vim#play_command = 'play'
  elseif executable('mplayer')
    let g:sana_natori_vim#play_command = 'mplayer'
  elseif executable('afplay')
    let g:sana_natori_vim#play_command = 'afplay'
  else
    finish
  endif
endif

let s:voices_dir = expand('<sfile>:p:h') . '/../voices'

function! s:play() abort
  let voice = s:pick_voice()
  if empty(voice)
    call s:error('no voices installed. see README.md')
    sleep 1
    return
  endif
  call job_start([g:sana_natori_vim#play_command, voice], {"in_io": "null", "out_io": "null", "err_io": "null"})
endfunction

function! s:error(msg) abort
  echohl ErrorMsg
  echomsg a:msg
  echohl None
endfunction

function! s:pick_voice() abort
  let voices = glob(s:voices_dir . '/*', 1, 1)
  if empty(voices)
    return ''
  endif
  " 0 から len(voices) - 1 までの疑似乱数 (整数) を生成する
  " http://vim-jp.org/vim-users-jp/2009/11/05/Hack-98.html
  let match_end = matchend(reltimestr(reltime()), '\d\+\.') + 1
  let i = reltimestr(reltime())[l:match_end : ] % len(voices)
  return voices[i]
endfunction

function! s:prepare_mappings() abort
  inoremap <buffer> <CR> <C-o>:<C-u>call <SID>play()<CR><CR>
  augroup sana_natori-local
    autocmd!
    autocmd InsertLeave <buffer> call s:play()
  augroup END
endfunction

augroup sana_natori
  autocmd!
  autocmd InsertEnter * call s:prepare_mappings()
augroup END
