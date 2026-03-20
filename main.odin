package monkey

import "core:fmt"
import "core:os"
import "core:strings"

main :: proc() {
	file, ferr := os.read_entire_file_from_path("main.monkey", context.allocator)
	if ferr != nil {
		fmt.println("invalid filename")
	}


	input, err := strings.clone_from_bytes(file)
	if err != nil {
		fmt.println("invalid file contents")
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

