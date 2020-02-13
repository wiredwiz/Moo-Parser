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
	| returnStatement SEMI
	| forStatement
	| whileStatement
	| forkStatement
	| tryExceptStatement
	| tryFinallyStatement
	| breakStatement SEMI
	| continueStatement SEMI
	;

ifStatement
	: IF '(' expression ')' statementList elseifStatement* (elseStatement+)? ENDIF;

elseifStatement
	: ELSEIF '(' expression ')' statementList;

elseStatement
	: ELSE statementList;

forStatement
	: FOR IDENTIFIER IN '(' expression ')' statementList ENDFOR
	| FOR IDENTIFIER IN '[' (expression '..' (expression | '$')) ']' statementList ENDFOR;

whileStatement
	: WHILE IDENTIFIER? '(' expression ')' statementList ENDWHILE;

forkStatement
	: FORK '(' expression ')' statementList ENDFORK;

returnStatement
	: RETURN (expression)?;

tryExceptStatement
	: TRY statementList exceptStatement+ ENDTRY;

exceptStatement
	: EXCEPT IDENTIFIER? '(' exceptionCodes ')' statementList;

exceptionCodes
	: '@' expression
	| ( IDENTIFIER | (ERROR (COMMA ERROR)*?));

tryFinallyStatement
	: TRY statementList FINALLY statementList ENDTRY;

breakStatement
	: BREAK IDENTIFIER?;

continueStatement
	: CONTINUE IDENTIFIER?;

list
	: '{' ((expression) (COMMA expression)*?)?  '}'
	;

expression
	: '(' expression ')'																#ParenthesisExpression
	| expression '?' expression '|' expression											#ConditionalExpression
	| '`' expression '!' exceptionCodes '=>' expression '\''							#ErrorCatchExpression
	| '@' expression																	#SplicerExpression
	| expression '[' (expression | '$') ']'												#IndexedExpression
	| expression '[' (expression '..' (expression | '$')) ']'							#RangeIndexedExpression
	| coreProperty																		#CorePropertyExpression
	| expression property																#PropertyExpression
	| expression verb '(' callArguments ')'												#VerbCallExpression
	| DOLLAR IDENTIFIER '(' callArguments ')'											#CoreVerbCallExpression
	| IDENTIFIER '(' callArguments ')'													#BuiltinFunctionCallExpression
	| '!' expression																	#NegationExpression
	| '^' expression																	#PowerExpression
	| expression operator=('*' | '/' | '%') expression									#MultiplyDivideModulusExpression
	| expression operator=('+' | '-') expression										#PlusMinusExpression
	| expression operator=(IN | '<' | '>' | '==' | '!=' | '<=' | '>=') expression		#ComparisonExpression
	| expression operator=('||' | '&&') expression										#LogicalAndOrExpression
	| '{' scatteringTarget '}' '=' expression											#ScatteringAssignmentExpression
	| expression operator='=' expression												#AssignmentExpression
	| ERROR																				#ErrorLiteralExpression
	| STRING																			#StringLiteralExpression
	| OBJECT																			#ObjectLiteralExpression
	| NUMBER																			#NumberLiteralExpression
	| FLOAT																				#FloatLiteralExpression
	| list																				#ListLiteralExpression
	| IDENTIFIER																		#IdentifierExpression
	;

coreProperty
	: DOLLAR IDENTIFIER;

property
	: '.' (IDENTIFIER | '(' expression ')');

verb
	: ':' (IDENTIFIER | '(' expression ')');

callArguments
	: (expression (COMMA expression)*?)?;

scatteringTarget
	: scatteringTargetItem (COMMA scatteringTargetItem)*?;

scatteringTargetItem
	: IDENTIFIER
	| '?' IDENTIFIER ('=' expression)?
	| '@' IDENTIFIER
	;
