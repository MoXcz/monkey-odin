package monkey

import "core:bytes"
import "core:fmt"
import "core:strings"

main :: proc() {
	input := "let five = 5;"
	l := new_lexer(input)

	fmt.println(l)
	tok := next_token(&l)
	fmt.println(tok)
	tok = next_token(&l)
	fmt.println(tok)
	free_all()
}

