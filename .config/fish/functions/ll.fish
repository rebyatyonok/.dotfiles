function ll
    if command -q exa
        exa -l $argv
    else
        ls -l $argv
    end
end
