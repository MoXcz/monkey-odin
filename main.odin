package monkey

import "core:fmt"
import "core:os"

main :: proc() {
	if len(os.args) != 2 {
		fmt.println("Usage: monkey-odin [CMD] | [FILE]")
		os.exit(1)
	}
	opt := os.args[1]
	if opt == "repl" {
		os.exit(0)
	}

	filename := opt
	run_file(filename)
}

