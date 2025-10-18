package monkey

import "core:bytes"
import "core:fmt"
import "core:strings"

Lexer :: struct {
	input:         string,
	position:      int, // curent pos in input
	read_position: int, // current reading pos in input (after current character)
	ch:            byte, // current character
}

new_lexer :: proc(input: string) -> Lexer {
	l := Lexer {
		input = input,
	}
	read_char(&l)
	return l
}

// go to next character; avoid going over the length of the input, otherwise set to 0, which is EOF
read_char :: proc(l: ^Lexer) {
	if l.read_position >= len(l.input) {
		l.ch = 0
	} else {
		l.ch = l.input[l.read_position]
	}

	l.position = l.read_position
	l.read_position += 1
}

next_token :: proc(l: ^Lexer) -> Token {
	tok: Token
	// fmt.printf("Reading char: %c\n", l.ch)

	switch l.ch {
	case '=':
		tok = new_token(l, .ASSIGN, l.ch)
	case ';':
		tok = new_token(l, .SEMICOLON, l.ch)
	case '(':
		tok = new_token(l, .LPAREN, l.ch)
	case ')':
		tok = new_token(l, .RPAREN, l.ch)
	case '{':
		tok = new_token(l, .LBRACE, l.ch)
	case '}':
		tok = new_token(l, .RBRACE, l.ch)
	case ',':
		tok = new_token(l, .COMMA, l.ch)
	case 0:
		tok = new_token(l, .EOF, l.ch)
	}

	read_char(l)
	return tok
}

new_token :: proc(l: ^Lexer, token_type: TokenType, ch: byte) -> Token {
	lit := l.input[l.position:l.read_position]
	return Token{type = token_type, literal = lit}
}

