# Activate rtx
rtx activate fish | source

# Add yarn global installs to $PATH
set -x PATH $PATH:(rtx x nodejs@latest -- yarn global bin)
