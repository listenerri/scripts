#! /bin/bash

login() {
    echo "进入drcom-generic/目录..."
    cd ~/drcom-generic/
    echo "启动drcom:"
    python2 latest-wired.py &
}

restart() {
    quit
    login
}


quit() {
    #四种获取drcom进程的方法
    #drcomID=`ps x | grep -e "[l]atest-wired" | grep -o -e "^\S*\s*[0-9]*" | grep -o -e "\b[0-9]*"`
    #drcomID=`ps x | grep -e "[l]atest-wired" | cut -d ' ' -f 1`
    #drcomID=`ps x | grep -e "[l]atest-wired" | awk '{print $1}'`
    drcomID=`ps x | awk '/[l]atest-wired/{print $1}'`
    if [[ -z $drcomID ]]; then
        echo "没有找到drcom进程!!"
	return 1
    else
	echo "杀死正在运行的drcom进程..."
	kill $drcomID
    fi
}

erros() {
    echo -e $drError
    exit 1
}

drError="参数错误!!\n只能选择下列选项中的一个作为参数:\n -l 登录\n -r 重启\n -q 退出"

case $# in
    0 )
	login;;
    1 )
	case $1 in
	    -l )
		login;;
	    -r )
		restart;;
	    -q )
		quit;;
	    * )
		erros;;
	esac;;
    * )
	erros;;
esac
