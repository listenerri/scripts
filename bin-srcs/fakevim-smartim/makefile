all: fakevim-smartim-linux fakevim-smartim-win fakevim-smartim-darwin

fakevim-smartim-linux: *.go
	env GOOS=linux go build -o fakevim-smartim-linux ./
fakevim-smartim-win: *.go
	env GOOS=windows go build -o fakevim-smartim-win.exe ./
fakevim-smartim-darwin: *.go
	env GOOS=darwin go build -o fakevim-smartim-darwin ./