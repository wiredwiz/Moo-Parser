parser grammar MooParser;

options { tokenVocab=MooLexer; }

/*
 * Parser Rules
 */

code
	: statement*
	;

statement
	: expression SEMI
	;

list
	: '{' ((listItem) (COMMA listItem)*)?  '}'
	;

listItem
	: ERROR
	| STRING
	| OBJECT
	| NUMBER
	| FLOAT
	| LIST
	| expression
	;

expression
	: '(' expression ')'																#ParenthesisExpression
	| expression '[' (expression | '$') ']'												#IndexedExpression
	| expression '[' (expression '..' (expression | '$')) ']'							#RangeIndexedExpression
	| coreProperty																		#CorePropertyExpression
	| propertyAccess																	#PropertyAccessExpression
	| expression verb '(' (argumentList)* ')'											#VerbCallExpression
	| DOLLAR IDENTIFIER '(' (argumentList)* ')'											#CoreVerbCallExpression
	| IDENTIFIER '(' (argumentList)* ')'												#BuiltinFunctionCallExpression
	| '!' expression																	#NegationExpression
	| '^' expression																	#PowerExpression
	| expression ('*' | '/' | '%') expression											#MultiplyDivideModulusExpression
	| expression ('+' | '-') expression													#PlusMinusExpression
	| expression (IN | '<' | '>' | '==' | '!=' | '<=' | '>=') expression				#ComparisonExpression
	| expression ('||' | '&&') expression												#LogicalAndOrExpression
	| expression '=' expression															#AssignmentExpression
	| ERROR																				#ErrorLiteralExpression
	| STRING																			#StringLiteralExpression
	| OBJECT																			#ObjectLiteralExpression
	| NUMBER																			#NumberLiteralExpression
	| FLOAT																				#FloatLiteralExpression
	| LIST																				#ListLiteralExpression
	| IDENTIFER																			#IdentifierExpression
	;

propertyAccess
	: (coreProperty | OBJECT) property
	| propertyAccess property
	;

property
	: '.' (IDENTIFIER | '(' expression ')');

verb
	: ':' (IDENTIFIER | '(' expression ')');

argumentList
	: expression (COMMA expression)*;

coreProperty
	: DOLLAR IDENTIFIER;
