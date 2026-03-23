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
	EQ, // ==
	NOT_EQ, // !=

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
	TRUE,
	FALSE,
	IF,
	ELSE,
	RETURN,
}

Token :: struct {
	type:    TokenType,
	literal: string,
	pos:     int,
	row:     int,
}
