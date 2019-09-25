/* C Declarations and Definitions */

%{

	#define KEYWORD 1
	#define IDENTIFIER 2
	#define INT_CONST 3
	#define FLOAT_CONST 4
	#define ENUM_CONST 5
	#define CHAR_CONST 6
	#define ESCAPE_SEQUENCE 7
	#define STRING_LITERAL 8
	#define PUNCTUATOR 9
	#define COMMENT 10

%}

/************ Definitions of Regualr Expressions ****************/

KEYWORD					"auto"|"enum"|"restrict"|"unsigned"|"break"|"extern"|"return"|"void"|"case"|"float"|"short"|"volatile"|"char"|"for"|"signed"|"while"|"const"|"goto"|"sizeof"|"_Bool"|"continue"|"if"|"static"|"_Complex"|"default"|"inline"|"struct"|"_Imaginary"|"do"|"int"|"switch"|"double"|"long"|"typedef"|"else"|"register"|"union"
ALPHABET				[a-zA-Z_]
DIGIT					[0-9]
NON_ZERO_DIGIT			[1-9]
IDENTIFIER				{ALPHABET}({ALPHABET}|{DIGIT})*
INTEGER_CONSTANT		{NON_ZERO_DIGIT}{DIGIT}*
DIGIT_SEQUENCE			{DIGIT}+
FRACTIONAL_CONST		(({DIGIT}+)?\.{DIGIT}+)|(({DIGIT}+)\.)
EXPONENT_PART			([e][+-]?{DIGIT}+)|([E][+-]?{DIGIT}+)
FLOAT_CONSTANT			({FRACTIONAL_CONST}{EXPONENT_PART}?)|({DIGIT_SEQUENCE}{EXPONENT_PART})
ENUMERATION_CONST		IDENTIFIER
ESCAPE_SEQUENCE			\\['"?\\abfnrtv]
C_CHAR					[^'\\\n]|{ESCAPE_SEQUENCE}
C_CHAR_SEQUENCE			({C_CHAR}+)	
CHARACTER_CONSTANT		\'{C_CHAR_SEQUENCE}\'
S_CHAR					[^"\\\n]|{ESCAPE_SEQUENCE}
S_CHAR_SEQUENCE			({S_CHAR}+)
STRING_LITERAL			\"({S_CHAR_SEQUENCE}?)\"
PUNCTUATOR				"["|"]"|"("|")"|"{"|"}"|"."|"->"|"++"|"--"|"&"|"*"|"+"|"-"|"~"|"!"|"/"|"%"|"<<"|">>"|"<"|">"|"<="|">="|"=="|"!="|"^"|"|"|"&&"|"||"|"?"|":"|";"|"..."|"="|"*="|"/="|"%="|"+="|"-="|"<<="|">>="|"&="|"^="|"|="|","|"#"
backother  				[ \t\v\n\f]
%%


{KEYWORD}					{return KEYWORD;}
{IDENTIFIER}				{return IDENTIFIER;}
{INTEGER_CONSTANT}			{return INT_CONST;}
{FLOAT_CONSTANT}			{return FLOAT_CONST;}
{ENUMERATION_CONST}			{return ENUM_CONST;}
{CHARACTER_CONSTANT}		{return CHAR_CONST;}
{ESCAPE_SEQUENCE}			{return ESCAPE_SEQUENCE;}
{STRING_LITERAL}			{return STRING_LITERAL;}
{PUNCTUATOR}				{return PUNCTUATOR;}
"/*"						{ comment(); return COMMENT;}
"//".*  	   				{ return COMMENT;}
{backother}					{ /* whitespace separates tokens */ }
%%
