package main

import (
	"fmt"
	"os"
	"os/exec"
	"runtime"
)

const (
	OSLinux = "linux"
	OSWindows = "windows"
	OSDarWin = "darwin"
)

var (
	CacheFilePath = os.TempDir() + string(os.PathSeparator) + "fakevim-smartim.cache"
)

func saveCurIM() {
	if runtime.GOOS == OSLinux {
		cmd := exec.Command("fcitx5-remote")
		output, err := cmd.Output()
		if err != nil {
			fmt.Printf("Run cmd %v error: %v\n", cmd.String(), err)
			return
		}
		err = os.WriteFile(CacheFilePath, output, 0777)
		if err != nil {
			fmt.Printf("Write file %v error: %v\n", CacheFilePath, err)
		}
	} else if runtime.GOOS == OSWindows || runtime.GOOS == OSDarWin {
		cmd := exec.Command("im-select")
		output, err := cmd.Output()
		if err != nil {
			fmt.Printf("Run cmd %v error: %v\n", cmd.String(), err)
			return
		}
		err = os.WriteFile(CacheFilePath, output, 0777)
		if err != nil {
			fmt.Printf("Write file %v error: %v\n", CacheFilePath, err)
		}
	} else {
		fmt.Printf("Unrecognized OS: %v\n", runtime.GOOS)
	}
}

func switchToEn() {
	saveCurIM()
	if runtime.GOOS == OSLinux {
		cmd := exec.Command("fcitx5-remote", "-c")
		err := cmd.Run()
		if err != nil {
			fmt.Printf("Run cmd %v error: %v\n", cmd.String(), err)
			return
		}
	} else if runtime.GOOS == OSWindows {
		cmd := exec.Command("im-select", "1033")
		err := cmd.Run()
		if err != nil {
			fmt.Printf("Run cmd %v error: %v\n", cmd.String(), err)
			return
		}
	} else if runtime.GOOS == OSDarWin {
		cmd := exec.Command("im-select", "com.apple.keylayout.ABC")
		err := cmd.Run()
		if err != nil {
			fmt.Printf("Run cmd %v error: %v\n", cmd.String(), err)
			return
		}
	} else {
		fmt.Printf("Unrecognized OS: %v\n", runtime.GOOS)
	}
}

func restoreIM() {
	data, err := os.ReadFile(CacheFilePath)
	if err != nil {
		fmt.Printf("Read file %v error: %v\n", CacheFilePath, err)
		return
	}
	preIM := string(data)
	if runtime.GOOS == OSLinux {
		var arg string
		// 1 inactive, 2 active
		if preIM == "1" {
			arg = "-c"
		} else {
			arg = "-o"
		}
		cmd := exec.Command("fcitx5-remote", arg)
		err := cmd.Run()
		if err != nil {
			fmt.Printf("Run cmd %v error: %v\n", cmd.String(), err)
			return
		}
	} else if runtime.GOOS == OSWindows || runtime.GOOS == OSDarWin {
		cmd := exec.Command("im-select", preIM)
		err := cmd.Run()
		if err != nil {
			fmt.Printf("Run cmd %v error: %v\n", cmd.String(), err)
			return
		}
	} else {
		fmt.Printf("Unrecognized OS: %v\n", runtime.GOOS)
	}
}

func printUsage() {
	fmt.Println(
		"指定要执行的动作：\n",
		"1. en 切换至英文输入法\n",
		"2. re 恢复输入法",
	)
}

func main() {
	if len(os.Args) < 2 {
		printUsage()
		os.Exit(255)
	}

	action := os.Args[1]
	if action == "en" {
		saveCurIM()
		switchToEn()
	} else if action == "re" {
		restoreIM()
	} else {
		printUsage()
		os.Exit(255)
	}
}
