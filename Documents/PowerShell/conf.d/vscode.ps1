if ($env:TERM_PROGRAM -eq "vscode") {
    . "$(code --locate-shell-integration-path pwsh)"
}