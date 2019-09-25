#include<stdio.h>

extern char* yytext;

int main()
{
	int token;
	while(token == yylex()){

		switch(token){
			case KEYWORD:
				printf("<KEYWORD, %d, %s>\n", token, yytext);
				break;
			case IDENTIFIER:
				printf("<IDENTIFIER, %d, %s>\n", token, yytext);
				break;
			case INT_CONST:
				printf("<INTEGER CONSTANT, %d, %s>\n", token, yytext);
				break;
			case FLOAT_CONST:
				printf("<FLOAT CONSTANT, %d, %s>\n", token, yytext);
				break;
			case ENUM_CONST:
				printf("<ENUMERATION CONSTANT, %d, %s>\n", token, yytext);
				break;
			case CHAR_CONST:
				printf("<CHARACTER CONSTANT, %d, %s>\n", token, yytext);
				break;
			case ESCAPE_SEQUENCE:
				printf("<ESCAPE SEQUENCE, %d, %s>\n", token, yytext);
				break;
			case STRING_LITERAL:
				printf("<STRING LITERAL, %d, %s>\n", token, yytext);
				break;
			case PUNCTUATOR:
				printf("<PUNCTUATOR, %d, %s>\n", token, yytext);
				break;
			case COMMENT:
				printf("<COMMENT, %d>\n", token);
				break;
			default:
				printf("<PUNCTUATOR, %d, %s>\n", token, yytext);
				break;
		}
	}
}