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

lookup_ident :: proc(ident: string, keywords: map[string]TokenType) -> TokenType {
	if tok, ok := keywords[ident]; ok {
		return tok
	}
	return .IDENT
}

skip_whitespace :: proc(l: ^Lexer) {
	for l.ch == ' ' || l.ch == '\t' || l.ch == '\n' || l.ch == '\r' {
		read_char(l)
	}
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

read_number :: proc(l: ^Lexer) -> string {
	pos := l.position
	for is_digit(l.ch) {
		read_char(l)
	}
	return l.input[pos:l.position]
}

read_identifier :: proc(l: ^Lexer) -> string {
	pos := l.position
	for is_letter(l.ch) {
		read_char(l)
	}
	return l.input[pos:l.position]
}

next_token :: proc(l: ^Lexer) -> Token {
	tok: Token

	keywords := make(map[string]TokenType, context.temp_allocator)
	keywords["fn"] = .FUNCTION
	keywords["let"] = .LET

	skip_whitespace(l)

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
	case:
		if is_letter(l.ch) {
			tok.literal = read_identifier(l)
			tok.type = lookup_ident(tok.literal, keywords)
			return tok
		} else if is_digit(l.ch) {
			tok.type = .INT
			tok.literal = read_number(l)
		} else {
			tok = new_token(l, .ILLEGAL, l.ch)
		}
	}

	read_char(l)
	free_all(context.temp_allocator)
	return tok
}

new_token :: proc(l: ^Lexer, token_type: TokenType, ch: byte) -> Token {
	lit := l.input[l.position:l.read_position]
	return Token{type = token_type, literal = lit}
}

is_letter :: proc(ch: byte) -> bool {
	return 'a' <= ch && ch <= 'z' || 'A' <= ch && ch <= 'Z' || ch == '_'
}

is_digit :: proc(ch: byte) -> bool {
	return '0' <= ch && ch <= '9'
}

