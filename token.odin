package monkey

TokenType :: enum {
	ILLEGAL,
	EOF,
	// identifiers and literals
	IDENT, // add, x
	INT, // 42069

	// operators
	ASSIGN,
	PLUS,

	// delimiters
	COMMA,
	SEMICOLON,
	LPAREN,
	RPAREN,
	LBRACE,
	RBRACE,

	// keywords
	FUNCTION,
	LET,
}

Token :: struct {
	type:    TokenType,
	literal: string,
}

