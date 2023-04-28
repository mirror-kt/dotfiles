function ghq_fzf {
    $repo = $(ghq list | fzf)
    Set-Location ( Join-Path $(ghq root) $repo)
}

# ghq integration
Set-PSReadLineKeyHandler -Chord Ctrl+g -ScriptBlock {
    ghq_fzf
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

# tab completion
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock {
    Invoke-FzfTabCompletion
}

# replace 'Ctrl+t' and 'Ctrl+r' with your preferred bindings:
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'