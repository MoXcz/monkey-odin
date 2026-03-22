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
		{.LN, "\n"},
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
		{.LN, "\n"},
		{.IDENT, "x"},
		{.PLUS, "+"},
		{.IDENT, "y"},
		{.LN, "\n"},
		{.RBRACE, "}"},
		{.LN, "\n"},
		{.LN, "\n"},
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
		{.LN, "\n"},
		{.BANG, "!"},
		{.MINUS, "-"},
		{.SLASH, "/"},
		{.ASTERISK, "*"},
		{.INT, "5"},
		{.SEMICOLON, ";"},
		{.LN, "\n"},
		{.INT, "5"},
		{.LT, "<"},
		{.INT, "10"},
		{.GT, ">"},
		{.INT, "5"},
		{.SEMICOLON, ";"},
		{.LN, "\n"},
		{.LN, "\n"},
		{.IF, "if"},
		{.LPAREN, "("},
		{.INT, "5"},
		{.LT, "<"},
		{.INT, "10"},
		{.RPAREN, ")"},
		{.LBRACE, "{"},
		{.LN, "\n"},
		{.RETURN, "return"},
		{.TRUE, "true"},
		{.SEMICOLON, ";"},
		{.LN, "\n"},
		{.RBRACE, "}"},
		{.ELSE, "else"},
		{.LBRACE, "{"},
		{.LN, "\n"},
		{.RETURN, "return"},
		{.FALSE, "false"},
		{.SEMICOLON, ";"},
		{.LN, "\n"},
		{.RBRACE, "}"},
		{.LN, "\n"},
		{.EOF, ""},
	}

	input := `let five = 5;
let add = fn(x, y) {
    x + y
}

let result = add(five, five);
!-/*5;
5 < 10 > 5;

if (5 < 10) {
  return true;
} else {
  return false;
}
`


	l := new_lexer(input)
	for test in tests {
		tok := next_token(&l)
		testing.expectf(
			t,
			tok.type == test.expected_type && tok.literal == test.expected_literal,
			"expected type '%v' and got '%v' with expected literal '%v' and got '%v' at %d:%d",
			test.expected_type,
			tok.type,
			test.expected_literal,
			tok.literal,
			tok.pos,
			tok.row,
		)
	}
}

