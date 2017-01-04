" vim: ts=4 sw=4 et

function! neomake#makers#ft#go#EnabledMakers()
    return ['go', 'golint', 'govet']
endfunction


function! s:RelativeModulePath() abort
    return './' . expand('%:.:h')
endfunction

function! neomake#makers#ft#go#go()
    return {
        \ 'args': [
            \ 'test', '-c',
            \ '-o', neomake#utils#DevNull(),
        \ ],
        \ 'make_filename': function('s:RelativeModulePath'),
        \ 'errorformat':
            \ '%W%f:%l: warning: %m,' .
            \ '%E%f:%l:%c:%m,' .
            \ '%E%f:%l:%m,' .
            \ '%C%\s%\+%m,' .
            \ '%-G#%.%#'
        \ }
endfunction

function! neomake#makers#ft#go#gometalinter()
    return {
    \ 'args': [
    \     '--disable-all',
    \     '-E', 'vet',
    \     '-E', 'golint',
    \     '-E', 'errcheck',
    \     '--message-overrides', 'errcheck:{message}',
    \     '--sort', 'line',
    \     '--tests',
    \     '--exclude', 'bindata',
    \     '--exclude', '.pb.',
    \     '--enable-gc',
    \ ],
    \ 'make_filename': function('s:RelativeModulePath'),
    \ 'errorformat': '%W%f:%l:%c:%t%*[^:]: %m'
\ }
endfunction

function! neomake#makers#ft#go#golint()
    return {
        \ 'errorformat':
            \ '%W%f:%l:%c: %m,' .
            \ '%-G%.%#'
        \ }
endfunction

function! neomake#makers#ft#go#govet()
    return {
        \ 'exe': 'go',
        \ 'args': ['vet'],
        \ 'make_filename': function('s:RelativeModulePath'),
        \ 'errorformat':
            \ '%Evet: %.%\+: %f:%l:%c: %m,' .
            \ '%W%f:%l: %m,' .
            \ '%-G%.%#'
        \ }
endfunction
