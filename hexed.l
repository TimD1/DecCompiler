%{
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "code.h"

int assembly_label_num = 1;
FILE *outfile;

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
				}
{left}			{
					fprintf(stderr, " [LEFT]");
				}
{add}			{
					fprintf(stderr, " [ADD]");
				}
{sub}			{
					fprintf(stderr, " [SUB]");
				}
{out}			{
					fprintf(stderr, " [OUT]");
				}
{in}			{
					fprintf(stderr, " [IN]");
				}
{start}			{
					fprintf(stderr, " [START LOOP]");
				}
{end}			{
					fprintf(stderr, " [END LOOP]");
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

void yyerror(char* str)
{
	fprintf(stderr, "\nERROR, LINE %d: %s\n", yylineno, str);
	exit(0);
}

int yywrap() { return 1; }

int main(int argc, char** argv)
{
	// user must enter single file name
	if(argc != 2) { yyerror("user must enter a single file name"); }

	// try to open file
	FILE *infile = fopen(argv[1], "r");
	if(!infile) { yyerror("invalid input file name given"); }

	// create output assembly file
	char* outfile_name = (char*)malloc(strlen(argv[1])-1);
	strncpy(outfile_name, (char*)argv[1], strlen(argv[1])-1);
	outfile_name[strlen(outfile_name)-1] = 's'; //assembly file
	outfile = fopen(outfile_name, "w");

	// parse input file
	yyin = infile;
	file_header(argv[1]);
	fprintf( stderr, "%d ", yylineno );
	do { yylex(); }
		while (!feof(yyin));
	file_footer();

	// clean up
	fclose(infile);
	fclose(outfile);
}
