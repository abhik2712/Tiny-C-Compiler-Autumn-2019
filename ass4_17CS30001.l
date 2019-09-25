%{

	#include<math.h>
	#include "y.tab.h"
	#include <stdio.h>
	#include <string.h>
	void comment(void);
	extern void yyerror(const char *);

%}

/*Definitions of regular expressions*/

KEYWORD					"auto"|"enum"|"restrict"|"unsigned"|"break"|"extern"|"return"|"void"|"case"|"float"|"short"|"volatile"|"char"|"for"|"signed"|"while"|"const"|"goto"|"sizeof"|"_Bool"|"continue"|"if"|"static"|"_Complex"|"default"|"inline"|"struct"|"_Imaginary"|"do"|"int"|"switch"|"double"|"long"|"typedef"|"else"|"register"|"union"
ALPHABET				[a-zA-Z_]
DIGIT					[0-9]
NON_ZERO_DIGIT			[1-9]
IDENTIFIER				{ALPHABET}({ALPHABET}|{DIGIT})*
INTEGER_CONSTANT		{NON_ZERO_DIGIT}{DIGIT}*
DIGIT_SEQUENCE			{DIGIT}+
FRACTIONAL_CONST		(({DIGIT}+)?\.{DIGIT}+)|(({DIGIT}+)\.)
FLOAT_CONSTANT			({FRACTIONAL_CONST}{EXPONENT_PART}?)|({DIGIT_SEQUENCE}{EXPONENT_PART})
EXPONENT_PART			([e][+-]?{DIGIT}+)|([E][+-]?{DIGIT}+)
ENUMERATION_CONST		IDENTIFIER
ESCAPE_SEQUENCE			\\['"?\\abfnrtv]
C_CHAR					[^'\\\n]|{ESCAPE_SEQUENCE}
C_CHAR_SEQUENCE			({C_CHAR}+)	
CHARACTER_CONSTANT		\'{C_CHAR_SEQUENCE}\'
S_CHAR					[^"\\\n]|{ESCAPE_SEQUENCE}
S_CHAR_SEQUENCE			({S_CHAR}+)
STRING_LITERAL			\"({S_CHAR_SEQUENCE}?)\"
PUNCTUATOR				"["|"]"|"("|")"|"{"|"}"|"."|"->"|"++"|"--"|"&"|"*"|"+"|"-"|"~"|"!"|"/"|"%"|"<<"|">>"|"<"|">"|"<="|"#"|">="|"=="|"!="|"^"|"|"|"&&"|"||"|"?"|":"|";"|"..."|"="|"*="|"/="|"%="|"+="|"-="|"<<="|">>="|"&="|"^="|"|="|","
backother  				[ \t\v\n\f]
SINGLE_LINE_COMMENT		"//"[^("\n")]*
MULTI_LINE_COMMENT		"/*"[^"*"]*"*"("*"|([^"/*"]*[^"*"]*"*"))*"/"
COMMENT 				{SINGLE_LINE_COMMENT}|{MULTI_LINE_COMMENT}

%%

{KEYWORD}		{

	if(strcmp(yytext,"auto")==0)			{ return AUTO; }
	if(strcmp(yytext,"enum")==0)			{ return ENUM; }
	if(strcmp(yytext,"restrict")==0)		{ return RESTRICT; } 
	if(strcmp(yytext,"unsigned")==0)		{ return UNSIGNED; }
	if(strcmp(yytext,"break")==0)			{ return BREAK; }
	if(strcmp(yytext,"extern")==0)			{ return EXTERN; }
	if(strcmp(yytext,"return")==0)			{ return RETURN; }
	if(strcmp(yytext,"void")==0)			{ return VOID; }
	if(strcmp(yytext,"case")==0)			{ return CASE; }
	if(strcmp(yytext,"float")==0)			{ return FLOAT; }
	if(strcmp(yytext,"short")==0)			{ return SHORT; }
	if(strcmp(yytext,"volatile")==0)		{ return VOLATILE; }
	if(strcmp(yytext,"char")==0)		  	{ return CHAR; }
	if(strcmp(yytext,"for")==0)				{ return FOR; }
	if(strcmp(yytext,"signed")==0)		  	{ return SIGNED; }
	if(strcmp(yytext,"while")==0)			{ return WHILE; }
	if(strcmp(yytext,"const")==0)			{ return CONST; }
	if(strcmp(yytext,"goto")==0)			{ return GOTO; }
	if(strcmp(yytext,"sizeof")==0)			{ return SIZEOF; }
	if(strcmp(yytext,"_Bool")==0)			{ return BOOL; }
	if(strcmp(yytext,"continue")==0)		{ return CONTINUE; }
	if(strcmp(yytext,"if")==0)				{ return IF; }
	if(strcmp(yytext,"static")==0)			{ return STATIC; }
	if(strcmp(yytext,"_Complex")==0)		{ return COMPLEX; }
	if(strcmp(yytext,"default")==0)			{ return DEFAULT; }
	if(strcmp(yytext,"inline")==0)			{ return INLINE; }
	if(strcmp(yytext,"struct")==0)			{ return STRUCT; }
	if(strcmp(yytext,"_Imaginary")==0)		{ return IMAGINARY; }
	if(strcmp(yytext,"do")==0)				{ return DO; }
	if(strcmp(yytext,"int")==0)				{ return INT; }
	if(strcmp(yytext,"switch")==0)			{ return SWITCH; }
	if(strcmp(yytext,"double")==0)			{ return DOUBLE; }
	if(strcmp(yytext,"long")==0)			{ return LONG; }
	if(strcmp(yytext,"typedef")==0)			{ return TYPEDEF; }
	if(strcmp(yytext,"else")==0)			{ return ELSE; }
	if(strcmp(yytext,"register")==0)		{ return REGISTER; }
	if(strcmp(yytext,"union")==0)			{ return UNION; }

}

{IDENTIFIER}			{return IDENTIFIER;}
{INTEGER_CONSTANT}		{return INTEGER_CONSTANT;}
{FLOAT_CONSTANT}		{return FLOAT_CONSTANT;}
{CHARACTER_CONSTANT}	{return CHARACTER_CONSTANT;}
{STRING_LITERAL}		{return STRING_LITERAL;}
{ENUMERATION_CONST}		{return ENUMERATION_CONST;}
{PUNCTUATOR}			{

	if(strcmp(yytext,"[") == 0) return SQBRAOPEN;
	if(strcmp(yytext,"]") == 0) return SQBRACLOSE;
	if(strcmp(yytext,"(") == 0) return ROBRAOPEN;
	if(strcmp(yytext,")") == 0) return ROBRACLOSE;
	if(strcmp(yytext,"{") == 0) return CURBRAOPEN;
	if(strcmp(yytext,"}") == 0) return CURBRACLOSE;
	if(strcmp(yytext,".") == 0) return DOT;
	if(strcmp(yytext,"->") == 0) return ACC;

	if(strcmp(yytext,"++") == 0) return INC;
	if(strcmp(yytext,"--") == 0) return DEC;
	if(strcmp(yytext,"&") == 0) return AMP;
	if(strcmp(yytext,"*") == 0) return MUL;
	if(strcmp(yytext,"+") == 0) return ADD;
	if(strcmp(yytext,"-") == 0) return SUB;
	if(strcmp(yytext,"~") == 0) return NEG;
	if(strcmp(yytext,"!") == 0) return EXCLAIM;

	if(strcmp(yytext,"/") == 0) return DIV;
	if(strcmp(yytext,"%") == 0) return MODULO;
	if(strcmp(yytext,"<<") == 0) return SHL;
	if(strcmp(yytext,">>") == 0) return SHR;
	if(strcmp(yytext,"<") == 0) return BITSHL;
	if(strcmp(yytext,">") == 0) return BITSHR;
	if(strcmp(yytext,"<=") == 0) return LTE;
	if(strcmp(yytext,">=") == 0) return GTE;
	if(strcmp(yytext,"==") == 0) return EQ;
	if(strcmp(yytext,"!=") == 0) return NEQ;
	if(strcmp(yytext,"^") == 0) return BITXOR;
	if(strcmp(yytext,"|") == 0) return BITOR;
	if(strcmp(yytext,"&&") == 0) return AND;
	if(strcmp(yytext,"||") == 0) return OR;

	if(strcmp(yytext,"?") == 0) return QUESTION;
	if(strcmp(yytext,":") == 0) return COLON;
	if(strcmp(yytext,";") == 0) return SEMICOLON;
	if(strcmp(yytext,"...") == 0) return DOTS;
	if(strcmp(yytext,"=") == 0) return ASSIGN;
	if(strcmp(yytext,"*=") == 0) return STAREQ;
	if(strcmp(yytext,"/=") == 0) return DIVEQ;
	if(strcmp(yytext,"%=") == 0) return MODEQ;
	if(strcmp(yytext,"+=") == 0) return PLUSEQ;
	if(strcmp(yytext,"-=") == 0) return MINUSEQ;
	if(strcmp(yytext,"<<=") == 0) return SHLEQ;
	if(strcmp(yytext,">>=") == 0) return SHREQ;
	if(strcmp(yytext,"&=") == 0) return BINANDEQ;
	if(strcmp(yytext,"^=") == 0) return BINXOREQ;
	if(strcmp(yytext,"|=") == 0) return BINOREQ;
	if(strcmp(yytext,",") == 0) return COMMA;
	if(strcmp(yytext,"#") == 0) return HASH;

}
"\n"|" "|"\t"|{COMMENT}		{}
%%