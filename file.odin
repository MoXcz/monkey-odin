package monkey

import "core:fmt"
import "core:os"
import "core:strings"

run_file :: proc(filename: string) {
	file, ferr := os.read_entire_file_from_path(filename, context.allocator)
	if ferr != nil {
		if ferr == .Not_Exist {
			fmt.printfln("file does not exist: %v", filename)
			return
		}

		fmt.printfln("unmanaged error type: %v", ferr)
		return
	}

	input, err := strings.clone_from_bytes(file)
	if err != nil {
		fmt.printfln("invalid file contents: %v", err)
		return
	}

	l := new_lexer(input)
	fmt.println(input)

	tok := next_token(&l)
	for (tok.type != .EOF) {
		fmt.println(tok)
		tok = next_token(&l)
	}

	// to see .EOF
	fmt.println(tok)
	free_all()
}

