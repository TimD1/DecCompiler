#ifndef EXTERNS_H
#define EXTERNS_H

extern int yylex();
extern int yylineno;
extern int yyparse();
extern FILE* yyin;
extern FILE* outfile;

#endif
