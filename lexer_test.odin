package monkey

import "core:fmt"
import "core:testing"


@(test)
test_lexer_tokens :: proc(t: ^testing.T) {
	tests := []struct {
		expected_type:    TokenType,
		expected_literal: string,
	} {
		{.ASSIGN, "="},
		{.SEMICOLON, ";"},
		{.LPAREN, "("},
		{.RPAREN, ")"},
		{.LBRACE, "{"},
		{.RBRACE, "}"},
		{.COMMA, ","},
	}

	input := "=;(){},;"
	l := new_lexer(input)
	for test in tests {
		tok := next_token(&l)
		testing.expectf(
			t,
			tok.type == test.expected_type,
			"expected %v and got %v",
			test.expected_type,
			tok.type,
		)
		testing.expectf(
			t,
			tok.literal == test.expected_literal,
			"expected %s and got %s",
			test.expected_literal,
			tok.literal,
		)
	}
}

@(test)
test_lexer_expressions :: proc(t: ^testing.T) {
	tests := []struct {
		expected_type:    TokenType,
		expected_literal: string,
	}{{.LET, "let"}, {.IDENT, "five"}, {.ASSIGN, "="}, {.INT, "5"}}

	input := `let five = 5;
let ten = 10;

let add = fn(x, y) {
  x + y
}

let result = add(five, ten);
`


	l := new_lexer(input)
	for test in tests {
		tok := next_token(&l)
		testing.expectf(
			t,
			tok.type == test.expected_type,
			"expected %v and got %v",
			test.expected_type,
			tok.type,
		)
		testing.expectf(
			t,
			tok.literal == test.expected_literal,
			"expected %s and got %s",
			test.expected_literal,
			tok.literal,
		)
	}
}

