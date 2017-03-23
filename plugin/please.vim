

if !exists("g:please_port")
  let g:please_port = 4048
endif

if !exists("g:please_open_cmd")
  let g:please_open_cmd = 'e'
endif

let s:start = 0
let s:lastFail = 0

function! s:stop()
  if exists("s:job")
    call job_stop(s:job)
    unlet s:job
  endif
endfunction

call s:stop()

function! s:start()
  call s:stop()
  let nc = [ "nc", "-l", "-p", g:please_port, "localhost" ]
  let opt = {}
  let opt['callback'] = function('s:onInput')
  let opt['exit_cb'] = function('s:onExit')
  let opt['out_io'] = 'pipe'
  let opt['err_io'] = 'out'
  let opt['in_io'] = 'null'
  let opt['out_mode'] = 'nl'
  let opt['err_mode'] = 'nl'
  let opt['stoponexit'] = 'term'
  let s:start = 1
  let s:job = job_start(nc, opt)
  let ok = (job_status(s:job) != 'fail')? 1 : 0
  if !ok
    let s:lastFail = localtime()
    echom "please: can't run nc (netcat), is it installed?"
  endif
endfunction

function! s:onInput(ch, line)
  if type(a:line) != 1
    echom 'please: invalid command'
    return
  endif
  if a:line[0:1] !=# 'e:'
    echom 'please: unknown command ('.a:line.')'
    return
  endif
  let file = a:line[2:]
  if filereadable(file)
    exec g:please_open_cmd file
  else
    echom 'please: unknown file'
  endif
endfunc

function! s:onExit(job, rc)
  if s:start && s:lastFail < localtime() -5
    call s:start()
  else
    "echom "exit"
  endif
endfunc

command! Please call s:start()

