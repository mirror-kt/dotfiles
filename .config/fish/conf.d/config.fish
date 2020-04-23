function fish_user_key_bindings
    bind \cr 'peco_select_history (commandline -b)'
end

set -x GOPATH $HOME/dev/go
set -x PATH $PATH:$GOPATH/bin
set -x GPG_TTY $tty

set -g fish_prompt_pwd_dir_length 0
set -g theme_newline_cursor yes

