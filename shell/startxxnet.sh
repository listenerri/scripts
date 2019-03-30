#!/bin/bash

run(){
    echo -e "\n测试网络>>>\n"

    ping -c 2 www.baidu.com

    if test $? -eq 0
    then
        echo -e "\n已连接网络>>>\n正在启动XXNet..."
        cd /home/ri/XX-Net/
        ./start
    else
        echo ''
        read -n 1 -p "未连接网络,是否重试??(n/任意键):" try
        echo ''

        if [ -z $try ]
        then
            run
        elif test $try = n
            then
                return
        else
            run
        fi
    fi
    return
}
#echo -e "\n等待5秒>>>"
#sleep 5
run
