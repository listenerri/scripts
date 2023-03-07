nameServerConf=$(cat /etc/resolv.conf | grep -P '^nameserver' | head -n 1)
hostIP=$(echo ${nameServerConf} | awk '{print $2}')
port=1080
if test -n "${hostIP}"; then
    export http_proxy=http://${hostIP}:${port} https_proxy=http://${hostIP}:${port}
fi
