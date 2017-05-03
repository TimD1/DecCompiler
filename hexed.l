%{
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#include "y.tab.h"

int label = 1;

%}

 /* valid symbols */
right			">"
left			"<"
add				"+"
sub				"-"
out				"."
in				","
start			"["
end				"]"
start_comment	"{"
end_comment		"}"
whitespace		[ \t]+
endline			[\r\n]

 /* define exclusive comment states */
%x		COMMENT1

 /* record line number */
%option yylineno

%%

 /* detect comment states */
{start_comment}			{ BEGIN COMMENT1; }
<COMMENT1>[^}] 			{ ; }
<COMMENT1>{end_comment}	{ fprintf(stderr, " {COMMENT}"); BEGIN INITIAL; }

 /* tokens */
{right}			{
					fprintf(stderr, " [RIGHT]");
					yylval.sval = strdup("right");
					return RIGHT;
				}
{left}			{
					fprintf(stderr, " [LEFT]");
					yylval.sval = strdup("left");
					return LEFT;
				}
{add}			{
					fprintf(stderr, " [ADD]");
					yylval.sval = strdup("add");
					return ADD;
				}
{sub}			{
					fprintf(stderr, " [SUB]");
					yylval.sval = strdup("sub");
					return SUB;
				}
{out}			{
					fprintf(stderr, " [OUT]");
					yylval.sval = strdup("out");
					return OUT;
				}
{in}			{
					fprintf(stderr, " [IN]");
					yylval.sval = strdup("in");
					return IN;
				}
{start}			{
					fprintf(stderr, " [START LOOP]");
					yylval.ival = label;
					label += 2;
					return START;
				}
{end}			{
					fprintf(stderr, " [END LOOP]");
					yylval.sval = strdup("end");
					return END;
				}

 /* ignore whitespace and set default */
{whitespace} 	{ ; }
{endline} 		{
					fprintf( stderr, "\n%d ", yylineno );
				}
.				{
					fprintf( stderr, " {%c}", yytext[0] );
				}

%%
