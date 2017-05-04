%{
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>

#include "code.h"
#include "y.tab.h"
#include "externs.h"

int yydebug = 1;
FILE* outfile;

void yyerror(const char* str)
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
	fprintf(stderr, "\n");
	file_header(argv[1]);
	add_io_code();
	main_header();
	do { yyparse(); }
		while (!feof(yyin));
	fprintf(stderr, "\n\n");
	main_footer();
	file_footer();

	// clean up
	fclose(infile);
	fclose(outfile);
}

%}

%define parse.error verbose
%define parse.lac full

/* create union to hold value of current token */
%union {
	int ival;
	char *sval;
}

/* number tokens */
%token <sval> RIGHT LEFT ADD SUB OUT IN END
%token <ival> START /* keep track of assembly labels */

/* set starting variable */
%start start

%%

start
	: commands
	;

commands
	: command commands 
	| START { start_loop($1); } commands { end_loop($1); } END commands
	| /* empty */
	;

command
	: LEFT { move_left(); }
	| RIGHT { move_right(); }
	| ADD { add(); }
	| SUB { sub(); }
	| OUT { write(); }
	| IN { read(); }
	;

%%
