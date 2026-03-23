package monkey

import "core:bufio"
import "core:fmt"
import "core:io"
import "core:os"

start_repl :: proc(input: io.Reader, output: ^os.File) {
	fmt.println("Welcome to the REPL for the Monkey programming language")
	scanner: bufio.Scanner

	bufio.scanner_init(&scanner, input)

	for {
		fmt.printf(">> ")
		if !bufio.scanner_scan(&scanner) {
			break
		}

		line := bufio.scanner_text(&scanner)
		if err := bufio.scanner_error(&scanner); err != nil {
			fmt.eprintfln("error scanning input: %v", err)
		}
		l := new_lexer(line)

		for tok := next_token(&l); tok.type != .EOF; tok = next_token(&l) {
			fmt.fprintfln(output, "%+v", tok)
		}
	}
}

