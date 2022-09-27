# volta
(& volta completions powershell) | Out-String | Invoke-Expression

# startship
Invoke-Expression (&starship init powershell)

# deno
(& deno completions powershell) | Out-String | Invoke-Expression

function ghq_fzf {
    $repo = $(ghq list | fzf)
    Set-Location ( Join-Path $(ghq root) $repo)
}

Set-PSReadLineKeyHandler -Chord Ctrl+g -ScriptBlock {
    ghq_fzf
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}