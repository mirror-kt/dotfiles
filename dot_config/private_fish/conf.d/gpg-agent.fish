# SSH
set -x GPG_TTY (tty)
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
if not ss -a | grep -q "$SSH_AUTH_SOCK";
  rm -f "$SSH_AUTH_SOCK"
  set wsl2_ssh_bridge_bin "$HOME/.ssh/wsl2-ssh-bridge.exe"
  if test -x "$wsl2_ssh_bridge_bin";
    setsid nohup socat UNIX-LISTEN:"$SSH_AUTH_SOCK,fork" EXEC:"$wsl2_ssh_bridge_bin" >/dev/null 2>&1 &
  else
    echo >&2 "WARNING: $wsl2_ssh_bridge_bin is not executable."
  end
  set --erase wsl2_ssh_bridge_bin
end

# GPG
set -x GPG_AGENT_SOCK (gpgconf --list-dir agent-socket)
if not ss -a | grep -q "$GPG_AGENT_SOCK";
  rm -rf "$GPG_AGENT_SOCK"
  set wsl2_ssh_bridge_bin "$HOME/.ssh/wsl2-ssh-bridge.exe"
  set config_path "C\:/Users/kanom/AppData/Local/gnupg"
  if test -x "$wsl2_ssh_bridge_bin";
    setsid nohup socat UNIX-LISTEN:"$GPG_AGENT_SOCK,fork" EXEC:"$wsl2_ssh_bridge_bin -gpgConfigBasepath $config_path --gpg S.gpg-agent" >/dev/null 2>&1 &
  else
    echo >&2 "WARNING: $wsl2_ssh_bridge_bin is not executable."
  end
  set --erase wsl2_ssh_bridge_bin
end
