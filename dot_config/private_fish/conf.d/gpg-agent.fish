set -x GPG_AGENT_SOCK (gpgconf --list-dir agent-socket)
set WIN_IP (grep /etc/resolv.conf -e nameserver | awk '{print $2}')
set GPG_BRIDGE_PORT "4321"

if ss -a | grep -q "$GPG_AGENT_SOCK";
    rm -f "$GPG_AGENT_SOCK"
end
setsid nohup socat UNIX-LISTEN:"$GPG_AGENT_SOCK,fork" TCP:"$WIN_IP:$GPG_BRIDGE_PORT" >/dev/null 2>&1 &
