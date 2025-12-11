package monkey

TokenType :: enum {
	ILLEGAL,
	EOF, // end of file

	// identifiers and literals
	IDENT, // add, x
	INT, // 42069

	// operators
	ASSIGN, // =
	PLUS, // +
	MINUS, // -
	BANG, // !
	ASTERISK, // *
	SLASH, // /

	// equality
	LT, // <
	GT, // >
	LN, // \n

	// delimiters
	COMMA, // ,
	SEMICOLON, // ;
	LPAREN, // (
	RPAREN, // )
	LBRACE, // {
	RBRACE, // }

	// keywords
	FUNCTION, // fn
	LET, // let
}

Token :: struct {
	type:    TokenType,
	literal: string,
	pos:     int,
	row:     int,
}

