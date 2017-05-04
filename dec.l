%{
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#include "y.tab.h"

int label = 1;
char prev = 0;

%}

 /* valid symbols */
start_comment	"0"
end_comment		"1"
right			"2"
left			"3"
add				"4"
sub				"5"
out				"6"
in				"7"
start			"8"
end				"9"
whitespace		[ \t]+
endline			[\r\n]

 /* define exclusive comment states */
%x		COMMENT1

 /* record line number */
%option yylineno

%%

 /* detect comment states */
{start_comment}			{
							BEGIN COMMENT1;
							fprintf(stderr, " {COMMENT:");
						}
<COMMENT1>[^1] 			{
							if(prev)
							{
								fprintf(stderr, "%c", 
									(char)((prev-'0')*10 + (yytext[0]-'0')));
								prev = 0;
							}
							else
								prev = yytext[0];
						}
<COMMENT1>{end_comment}	{ fprintf(stderr, "}\n"); BEGIN INITIAL; }

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
