function batdiff --description "Show git diff with bat"
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
end
