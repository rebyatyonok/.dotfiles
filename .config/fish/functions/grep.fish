function rg
    if command -q rg
        rg $argv
    else
        grep $argv
    end
end