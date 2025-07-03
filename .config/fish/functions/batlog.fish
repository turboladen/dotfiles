function batlog --description "Show git log with bat"
    git log --oneline --decorate --color=always | bat --paging=always -l log
end
