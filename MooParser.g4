parser grammar MooParser;

options { tokenVocab=MooLexer; }

/*
 * Parser Rules
 */

code
	: statementList endOfFile
	| endOfFile
	;

endOfFile
	: EOF;

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

ifClause
	: IF '(' expression ')';

ifStatement
	: ifClause statementList elseifStatement* (elseStatement+)? endifStatement;

elseifClause
	: ELSEIF '(' expression ')';

elseifStatement
	: elseifClause statementList;

elseStatement
	: ELSE statementList;

endifStatement
	: ENDIF;

forClause
	: FOR IDENTIFIER IN '(' expression ')'
	| FOR IDENTIFIER IN '[' (expression '..' (expression | '$')) ']';

forStatement
	: forClause statementList endforStatement;

endforStatement
	: ENDFOR;

whileClause
	: WHILE IDENTIFIER? '(' expression ')';

whileStatement
	: whileClause statementList endwhileStatement;

endwhileStatement
	: ENDWHILE;

forkId
	: IDENTIFIER;

forkClause
	: FORK forkId? '(' expression ')';

forkStatement
	: forkClause statementList endforkStatement;

endforkStatement
	: ENDFORK;

returnStatement
	: RETURN (expression)?;

tryExceptStatement
	: TRY statementList exceptStatement+ endtryStatement;

exceptStatement
	:exceptClause statementList;

exceptClause
	: EXCEPT IDENTIFIER? '(' exceptionCodes ')';

exceptionCode
	: IDENTIFIER | ERROR;

exceptionCodes
	: '@' expression
	| ANY
	| (exceptionCode (COMMA exceptionCode)*?);

tryFinallyStatement
	: TRY statementList finallyStatement endtryStatement;

finallyStatement
	: FINALLY statementList;

endtryStatement
	: ENDTRY;

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
	| '`' expression '!' exceptionCodes ('=>' expression)? '\''							#ErrorCatchExpression
	| '@' expression																	#SplicerExpression
	| expression index_access															#IndexedExpression
	| expression range_access															#RangeIndexedExpression
	| CORE_REFERENCE																	#CorePropertyExpression
	| expression property_access														#PropertyExpression
	| expression verb_access '(' callArguments ')'										#VerbCallExpression
	| CORE_REFERENCE '(' callArguments ')'												#CoreVerbCallExpression
	| IDENTIFIER '(' callArguments ')'													#BuiltinFunctionCallExpression
	| '-' expression                                                                    #UnaryMinusExpression
	| '!' expression																	#NegationExpression
	| expression '^' expression															#PowerExpression
	| expression operator=('*' | '/' | '%') expression									#MultiplyDivideModulusExpression
	| expression operator=('+' | '-') expression										#PlusMinusExpression
	| expression operator=(IN | '<' | '>' | '==' | '!=' | '<=' | '>=') expression		#ComparisonExpression
	| expression operator=('||' | '&&') expression										#LogicalAndOrExpression
	| '{' scatteringTarget '}' '=' expression											#ScatteringAssignmentExpression
	| lhs=expression operator='=' rhs=expression										#AssignmentExpression
	| literal																			#LiteralExpression
	| IDENTIFIER																		#IdentifierExpression
	| '$'																				#LastIndexLiteral
	| '^'																				#FirstIndexLiteral
	;

literal
	: ERROR
	| STRING
	| OBJECT
	| NUMBER
	| FLOAT
	| list;

index_access
	: '[' expression ']';

range_access
	: '[' expression '..' expression ']';

property_access
	: '.' (IDENTIFIER | '(' expression ')');

verb_access
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
