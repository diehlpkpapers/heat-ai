### Compilation

```bash
go build heat-ai.go 
# command-line-arguments
./heat-ai.go:5:2: "math" imported and not used
```

### Runtime

```bash
./heat-ai
panic: runtime error: index out of range [101] with length 101

goroutine 9 [running]:
main.heatEqnStep({0xc0000ae000?, 0x0?, 0x0?}, {0xc0000ae380?, 0x0?, 0x0?}, 0x0?, 0x0?, 0x0?)
	/work/diehlpk/heat-ai/go/heat-ai.go:23 +0xf7
created by main.main
	/work/diehlpk/heat-ai/go/heat-ai.go:43 +0x9d
[diehlpk@rostam1 go]$ vim README.md
[diehlpk@rostam1 go]$ ./heat-ai
panic: runtime error: index out of range [101] with length 101

goroutine 9 [running]:
main.heatEqnStep({0xc0000ae000?, 0x0?, 0x0?}, {0xc0000ae380?, 0x0?, 0x0?}, 0x0?, 0x0?, 0x0?)
	/work/diehlpk/heat-ai/go/heat-ai.go:23 +0xf7
created by main.main
	/work/diehlpk/heat-ai/go/heat-ai.go:43 +0x9d
panic: runtime error: index out of range [-1]

goroutine 6 [running]:
main.heatEqnStep({0xc0000ae000?, 0x0?, 0x0?}, {0xc0000ae380?, 0x0?, 0x0?}, 0x0?, 0x0?, 0x0?)
	/work/diehlpk/heat-ai/go/heat-ai.go:23 +0x105
created by main.main
	/work/diehlpk/heat-ai/go/heat-ai.go:43 +0x9d
[diehlpk@rostam1 go]$ vim README.md
[diehlpk@rostam1 go]$ ./heat-ai
panic: runtime error: index out of range [101] with length 101

goroutine 9 [running]:
main.heatEqnStep({0xc0000ae000?, 0x0?, 0x0?}, {0xc0000ae380?, 0x0?, 0x0?}, 0x0?, 0x0?, 0x0?)
	/work/diehlpk/heat-ai/go/heat-ai.go:23 +0xf7
created by main.main
	/work/diehlpk/heat-ai/go/heat-ai.go:43 +0x9d
```

```bash
 ./heat-ai-v4
panic: sync: negative WaitGroup counter

goroutine 101 [running]:
sync.(*WaitGroup).Add(0x0?, 0x0?)
	/usr/lib/golang/src/sync/waitgroup.go:62 +0xe5
sync.(*WaitGroup).Done(0x0?)
	/usr/lib/golang/src/sync/waitgroup.go:87 +0x25
main.main.func1(0x0?)
	/work/diehlpk/heat-ai/go/heat-ai-v4.go:46 +0xfc
created by main.main
	/work/diehlpk/heat-ai/go/heat-ai-v4.go:36 +0x1fa
```


