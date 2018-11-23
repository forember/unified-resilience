rm logs/*
/opt/cisco/anyconnect/bin/vpnagentd
vpnagentdpid="$(ps ax | grep /opt/cisco/anyconnect/bin/vpnagentd | grep -v grep | awk '{print $1}')"
echo "$vpnagentdpid" >logs/vpnagentdpid
tail --pid="$vpnagentdpid" -f /dev/null
