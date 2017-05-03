#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include "code.h"

FILE* outfile;


/* Print this code at the start of the assembly file */
void file_header(char* filename)
{
	if (CODE_DEBUG) fprintf(outfile, "# file header\n");
	fprintf(outfile, "\t.file\t\"%s\"\n", filename);
	fprintf(outfile, "\t.intel_syntax noprefix\n\n");
}


/* Add input and output functions */
void add_io_code()
{
	if (CODE_DEBUG) fprintf(outfile, "\n# create io format strings\n");
	fprintf(outfile, "\t.section\t.rodata\n");
	fprintf(outfile, ".LC0: # reading\n");
	fprintf(outfile, "\t.string \"%%c\"\n");
	fprintf(outfile, ".LC1: # writing\n");
	fprintf(outfile, "\t.string \"%%c\\n\"\n");
	fprintf(outfile, "\t.text\n\n\n");
}


/* Print this code at the end of the assembly file */
void file_footer()
{
	if (CODE_DEBUG) fprintf(outfile, "\n# file footer\n");
	fprintf(outfile, 
		"\t.ident\t\"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609\"\n");
	fprintf(outfile, "\n\t.section\t.note.GNU-stack,\"\",@progbits\n");
}
