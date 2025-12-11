package monkey

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
	} {
		{.LET, "let"},
		{.IDENT, "five"},
		{.ASSIGN, "="},
		{.INT, "5"},
		{.SEMICOLON, ";"},
		{.LET, "let"},
		{.IDENT, "add"},
		{.ASSIGN, "="},
		{.FUNCTION, "fn"},
		{.LPAREN, "("},
		{.IDENT, "x"},
		{.COMMA, ","},
		{.IDENT, "y"},
		{.RPAREN, ")"},
		{.LBRACE, "{"},
		{.IDENT, "x"},
		{.PLUS, "+"},
		{.IDENT, "y"},
		{.RBRACE, "}"},
		{.LET, "let"},
		{.IDENT, "result"},
		{.ASSIGN, "="},
		{.IDENT, "add"},
		{.LPAREN, "("},
		{.IDENT, "five"},
		{.COMMA, ","},
		{.IDENT, "five"},
		{.RPAREN, ")"},
		{.SEMICOLON, ";"},
		{.BANG, "!"},
		{.MINUS, "-"},
		{.SLASH, "/"},
		{.ASTERISK, "*"},
		{.INT, "5"},
		{.SEMICOLON, ";"},
		{.INT, "5"},
		{.LT, "<"},
		{.INT, "10"},
		{.GT, ">"},
		{.INT, "5"},
		{.SEMICOLON, ";"},
	}

	input := `let five = 5;
let add = fn(x, y) {
    x + y
}

let result = add(five, five);
!-/*5;
5 < 10 > 5;
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

