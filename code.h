#ifndef _CODE_H_
#define _CODE_H_

#define CODE_DEBUG 1
#define MAX_BYTES 1000

void file_header(char* filename);
void file_footer();
void main_header();
void main_footer();
void add_io_code();

void move_right();
void move_left();
void add();
void sub();
void write();
void read();
void start_loop();
void end_loop();

#endif
