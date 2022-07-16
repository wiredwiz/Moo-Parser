lexer grammar ToastStuntMooLexer;

channels { COMMENTS_CHANNEL }

/* wishful thinking
SINGLE_LINE_COMMENT
	: '//' INPUT_CHARACTER* -> channel(COMMENTS_CHANNEL);
*/

DELIMITED_COMMENT
	: '/*' .*? '*/' -> channel(COMMENTS_CHANNEL);

WS
	:	[ \t\r\n] -> channel(HIDDEN)
	;

IF
	: I F
	;

ELSE
	: E L S E
	;

ELSEIF
	: E L S E I F
	;

ENDIF
	: E N D I F
	;

FOR
	: F O R;

ENDFOR
	: E N D F O R;

WHILE
	: W H I L E
	;

ENDWHILE
	: E N D W H I L E
	;

FORK
	: F O R K
	;

ENDFORK
	: E N D F O R K
	;

RETURN
	: R E T U R N
	;

BREAK
	: B R E A K
	;

CONTINUE
	: C O N T I N U E
	;

TRY
	: T R Y
	;

EXCEPT
	: E X C E P T
	;

FINALLY
	: F I N A L L Y
	;

ENDTRY
	: E N D T R Y
	;

IN
	: I N
	;

SPLICER
	: '@';

UNDERSCORE
	: '_';

DOLLAR
	: '$';

SEMI
	: ';';

COLON
	: ':';

DOT
	: '.';

COMMA
	: ',';

BANG
	: '!';

OPEN_QUOTE
	: '`';

SINGLE_QUOTE
	: '\'';

LEFT_BRACKET
	: '[';

RIGHT_BRACKET
	: ']';

LEFT_CURLY_BRACE
	: '{';

RIGHT_CURLY_BRACE
	: '}';

LEFT_PARENTHESIS
	: '(';

RIGHT_PARENTHESIS
	: ')';

PLUS
	: '+';

MINUS
	: '-';

STAR
	: '*';

DIV
	: '/';

PERCENT
	: '%';

PIPE
	: '|';

CARET
	: '^';

ASSIGNMENT
	: '=';

QMARK
	: '?';

OP_AND
	: '&&';

OP_OR
	: '||';

OP_EQUALS
	: '==';

OP_NOT_EQUAL
	: '!=';

OP_LESS_THAN
	: '<';

OP_GREATER_THAN
	: '>';

OP_LESS_THAN_OR_EQUAL_TO
	: '<=';

OP_GREATER_THAN_OR_EQUAL_TO
	: '>=';

OP_COMPLIMENT
	: '~';

OP_BITWISE_OR
	: '|.';

OP_BITWISE_AND
	: '&.';

OP_BITWISE_XOR
	: '^.';

OP_SHIFT_RIGHT
	: '>>';

OP_SHIFT_LEFT
	: '<<';

OP_MAP_ASSIGN
	: '->';

ACTION
	: '=>';

RANGE
	: '..';

ERROR
	: 'E_NONE'
	| 'E_TYPE'
	| 'E_DIV'
	| 'E_PERM'
	| 'E_PROPNF'
	| 'E_VERBNF'
	| 'E_VARNF'
	| 'E_INVIND'
	| 'E_RECMOVE'
	| 'E_MAXREC'
	| 'E_RANGE'
	| 'E_ARGS'
	| 'E_NACC'
	| 'E_INVARG'
	| 'E_QUOTA'
	| 'E_FLOAT'
	;

OBJECT
	: '#' DIGIT+
	| '#-' DIGIT+
	;

BOOLEAN
	: T R U E
	| F A L S E
	;

STRING 
	: '"' ( ESC | [ !] | [#-[] | [\]-~] | [\t] )* '"';

NUMBER
	: DIGIT+;

FLOAT
	: DIGIT+ [.] (DIGIT*)? {_input.La(1) != '.'}? (EXPONENTNOTATION EXPONENTSIGN DIGIT+)? 
	| [.] DIGIT+ (EXPONENTNOTATION EXPONENTSIGN DIGIT+)? 
	| DIGIT+ EXPONENTNOTATION EXPONENTSIGN DIGIT+
	;

IDENTIFIER
	: (LETTER | DIGIT | UNDERSCORE)+
	;

LETTER
	: LOWERCASE 
	| UPPERCASE
	;

/* 
 * fragments 
 */

fragment LOWERCASE  
	: [a-z] ;

fragment UPPERCASE  
	: [A-Z] ;

fragment EXPONENTNOTATION
	: ('E' | 'e');

fragment EXPONENTSIGN
	: ('-' | '+');

fragment DIGIT 
	: [0-9] ;

fragment ESC 
	: '\\"' | '\\\\' ;

fragment INPUT_CHARACTER
	: ~[\r\n\u0085\u2028\u2029];

fragment A : [aA];
fragment B : [bB];
fragment C : [cC];
fragment D : [dD];
fragment E : [eE];
fragment F : [fF];
fragment G : [gG];
fragment H : [hH];
fragment I : [iI];
fragment J : [jJ];
fragment K : [kK];
fragment L : [lL];
fragment M : [mM];
fragment N : [nN];
fragment O : [oO];
fragment P : [pP];
fragment Q : [qQ];
fragment R : [rR];
fragment S : [sS];
fragment T : [tT];
fragment U : [uU];
fragment V : [vV];
fragment W : [wW];
fragment X : [xX];
fragment Y : [yY];
fragment Z : [zZ];
