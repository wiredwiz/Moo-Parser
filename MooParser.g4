parser grammar MooParser;

options { tokenVocab=MooLexer; }

/*
 * Parser Rules
 */

code
	: statementList
	;

statementList
	: statement*
	;

statement
	: expression SEMI
	| ifStatement
	;

ifStatement
	: IF '(' expression ')' statementList elseifStatement* elseStatement+? endifStatement;

elseifStatement
	: ELSEIF '(' expression ')' statementList;

elseStatement
	: ELSE statementList;

endifStatement
	: ENDIF;

list
	: '{' ((expression) (COMMA expression)*?)?  '}'
	;

expression
	: '(' expression ')'																#ParenthesisExpression
	| expression '[' (expression | '$') ']'												#IndexedExpression
	| expression '[' (expression '..' (expression | '$')) ']'							#RangeIndexedExpression
	| coreProperty																		#CorePropertyExpression
	| propertyAccess																	#PropertyAccessExpression
	| expression verb '(' callArguments ')'												#VerbCallExpression
	| DOLLAR IDENTIFIER '(' callArguments ')'											#CoreVerbCallExpression
	| IDENTIFIER '(' callArguments ')'													#BuiltinFunctionCallExpression
	| '!' expression																	#NegationExpression
	| '^' expression																	#PowerExpression
	| expression operator=('*' | '/' | '%') expression									#MultiplyDivideModulusExpression
	| expression operator=('+' | '-') expression										#PlusMinusExpression
	| expression operator=(IN | '<' | '>' | '==' | '!=' | '<=' | '>=') expression		#ComparisonExpression
	| expression operator=('||' | '&&') expression										#LogicalAndOrExpression
	| expression operator='=' expression												#AssignmentExpression
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

callArguments
	: (expression (COMMA expression)*?)?;

coreProperty
	: DOLLAR IDENTIFIER;
