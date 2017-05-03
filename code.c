#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include "code.h"
#include "externs.h"

int current_byte = 0;


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

/* Print this code at the start of the main function */
void main_header()
{
	if (CODE_DEBUG) fprintf(outfile, "\n# main header\n");
	fprintf(outfile, "\t.globl\tmain\n");
	fprintf(outfile, "\t.type\tmain, @function\n");
	fprintf(outfile, "main:\n");
	fprintf(outfile, "\tpush\trbp\n");
	fprintf(outfile, "\tmov\t\trbp, rsp\n");

	// initialize stack to MAX_BYTES zeros
	if (CODE_DEBUG) fprintf(outfile, "\n# initialize stack to zeros\n");
	fprintf(outfile, "\tmov\t\tr8, %d\n", MAX_BYTES);
	fprintf(outfile, ".L0:\n");
	fprintf(outfile, "\tsub\t\tr8, 1\n");
	fprintf(outfile, "\tpush\t0\n");
	fprintf(outfile, "\tcmp\t\tr8, 0\n");
	fprintf(outfile, "\tjne\t\t.L0\n");

	if (CODE_DEBUG) fprintf(outfile, "\t# end function header\n");

	if (CODE_DEBUG) fprintf(outfile, "\n# main code\n");
}


/* Print this code at the end of the main function */
void main_footer()
{
	if (CODE_DEBUG) fprintf(outfile, "\n# main footer\n");
	fprintf(outfile, "\tmov\t\teax, 0\n");
	fprintf(outfile, "\tleave\n");
	fprintf(outfile, "\tret\n");
	fprintf(outfile, "\n\t.size\tmain, .-main\n\n\n");
}


/* Increment the value of the current register by one. */
void add()
{
	if (CODE_DEBUG) fprintf(outfile, "\n# add\n");
	if(current_byte == 0)
		fprintf(outfile, "\tadd\t\tBYTE PTR [rsp], 1\n");
	else
		fprintf(outfile, "\tadd\tBYTE PTR [rsp+%d], 1\n", current_byte);
}


/* Decrement the value of the current register by one. */
void sub()
{
	if (CODE_DEBUG) fprintf(outfile, "\n# sub\n");
	if(current_byte == 0)
		fprintf(outfile, "\tsub\t\tBYTE PTR [rsp], 1\n");
	else
		fprintf(outfile, "\tsub\tBYTE PTR [rsp+%d], 1\n", current_byte);
}


/* Shift the current register pointer right */
void move_right()
{
	if (CODE_DEBUG) fprintf(outfile, "\n# move right\n");
	current_byte++;
}


/* Shift the current register pointer left */
void move_left()
{
	if (CODE_DEBUG) fprintf(outfile, "\n# move left\n");
	current_byte--;
}


/* Write out the value in the current register */
void write()
{
	if (CODE_DEBUG) fprintf(outfile, "\n# write\n");
	if(current_byte == 0)
		fprintf(outfile, "\tmovzx\teax, BYTE PTR [rsp]\n");
	else
		fprintf(outfile, "\tmovzx\teax, BYTE PTR [rsp+%d]\n", current_byte);
	fprintf(outfile, "\tmovsx\tedx, al\n");
	fprintf(outfile, "\tmov\t\trax, QWORD PTR stderr[rip]\n");
	fprintf(outfile, "\tmov\t\tesi, OFFSET FLAT:.LC1\n");
	fprintf(outfile, "\tmov\t\trdi, rax\n");
	fprintf(outfile, "\tmov\t\teax, 0\n");
	fprintf(outfile, "\tcall\tfprintf\n\n");
}


/* Read a value into the current register */
void read()
{
	if (CODE_DEBUG) fprintf(outfile, "\n# read\n");
	fprintf(outfile, "\tmov\t\trax, QWORD PTR fs:40\n");
	fprintf(outfile, "\txor\t\teax, eax\n");
	fprintf(outfile, "\tmov\t\trax, QWORD PTR stdin[rip]\n");
	if(current_byte == 0)
		fprintf(outfile, "\tlea\t\trdx, [rsp]\n");
	else
		fprintf(outfile, "\tlea\t\trdx, [rsp+%d]\n", current_byte);
	fprintf(outfile, "\tmov\t\tesi, OFFSET FLAT:.LC0\n");
	fprintf(outfile, "\tmov\t\trdi, rax\n");
	fprintf(outfile, "\tmov\t\teax, 0\n");
	fprintf(outfile, "\tcall\t__isoc99_fscanf\n\n");
}

/* Start a loop */
void start_loop(int l)
{
	if (CODE_DEBUG) fprintf(outfile, "\n# start loop\n");
	fprintf(outfile, ".L%d:\n", l);
	fprintf(outfile, "\tcmp\t\tBYTE PTR [rsp+%d], 0\n", current_byte);
	fprintf(outfile, "\tje\t\t.L%d\n", l+1);
}


/* End a loop */
void end_loop(int l)
{
	if (CODE_DEBUG) fprintf(outfile, "\n# end loop\n");
	fprintf(outfile, "\tjmp\t\t.L%d\n", l);
	fprintf(outfile, ".L%d:\n", l+1);
}
