" markdown filetype file
if exists("did\_load\_filetypes")
 finish
endif

augroup filedetect
 au! BufRead,BufNewFile *.mkd  setfiletype mkd
 au! BufRead,BufNewFile *.vm   setfiletype velocity 
augroup END

