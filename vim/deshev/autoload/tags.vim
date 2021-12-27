function! tags#GenerateTags()
    let l:ctagsCmd = "ctags -R"
    " use .ctags-exclude in the current dir if it exists
    if getfperm(".run-ctags") != ""
        let l:ctagsCmd = "sh .run-ctags"
    endif
    if getfperm(".ctags-exclude") != ""
        let l:ctagsCmd = l:ctagsCmd . " --exclude=@.ctags-exclude"
    endif
    if getfperm(".ctags_exclude") != ""
        let l:ctagsCmd = l:ctagsCmd . " --exclude=@.ctags_exclude"
    endif
    if getfperm("package.json") != ""
        let l:ctagsCmd = l:ctagsCmd . " --exclude=node_modules"
    endif
    if getfperm("Gemfile") != ""
        let l:ctagsCmd = l:ctagsCmd . " --exclude=vendor --exclude=public --exclude='*.min.js' --exclude=db/migrate --exclude=log --exclude=tmp"
    endif
    if getfperm("__pycache__") != "" || getfperm("setup.py") != "" || getfperm("requirements.txt") != ""
        let l:ctagsCmd = l:ctagsCmd . " --exclude=env --exclude=venv --exclude=log --exclude=tmp --exclude=.mypy_cache"
    endif
    echo "Generating tags: " . l:ctagsCmd
    call system(l:ctagsCmd)
endfunction
