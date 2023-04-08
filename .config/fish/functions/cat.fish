function cat
    if command -q bat
        bat $argv
    else
        cat $argv
    end
end
