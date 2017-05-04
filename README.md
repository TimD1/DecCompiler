# Compiling Dec with the DecCompiler
Creating the language 'Dec' was my CS445 "free will" project, an extension of the [BrainF\*ck][1] language which allows comments and operates using decimal characters. Despite the existence of only 10 unique tokens, this language is Turing complete. All possible operations are described below, along with their BrainF\*ck and C equivalents.

[1]: https://en.wikipedia.org/wiki/Brainfuck

|Dec Character	| BrainF\*ck Character	| C Equivalent	| Explanation|
|:-------------:|:---------------------:|:-------------:|:-----------|
|	`0`			|		`none`			|	`/*`		| end code, start comment
|	`1`			|		`none`			|	`*/`		| end comment, start code
|	`2`			|		`>`				|	`++ptr;`		|increment the data pointer (to point to the next cell to the right).
|	`3`			|		`<`				|	`--ptr;`		|decrement the data pointer (to point to the next cell to the left).
|	`4`			|		`+`				|	`++*ptr;`	| increment the byte at the data pointer
|	`5`			|		`-`				|	`--*ptr;`	|decrement the byte at the data pointer
|	`6`			|		`.`				|`putchar(*ptr);`|output the byte at the data pointer
|	`7`			|		`,`				|`*ptr=getchar();`|accept one byte of input, storing its value in the byte at the data pointer
|	`8`			|		`[`				|`while(*ptr) {	`|if the byte at the data pointer is zero, jump to the matching `9`
|	`9`			|		`]`				|		`}`		|if the byte at the data pointer is nonzero, jump back to the matching `8`


I thought it would be entertaining to extend the simple language of BrainF\*ck to create a programming language in which the only valid operations are decimal values. Therefore, any valid program written in Dec will consist of a single integer. A simple 'Hello, World' program is shown below:

```
4444444482444482442444244424333359242425224839359226255564444444664446226356364446555555655555555622462446 
```

Because this code may be confusing to beginning programmers, I introduced comments to make the code more readable. Although all whitespace and ASCII characters are ignored by the compiler and theoretically *could* be used in comments, this practice is highly frowned upon because it ruins the elegant visual appeal of the language.

Therefore, any helpful comments introduced should also be converted to decimal form, using the desired letter's uppercase decimal ASCII equivalent. Please note that the letters G (ASCII value 71) and Q (ASCII value 81) should be avoided at all costs, since their usage will cause the current comment to end. An example of correct comment styling is shown below, in an annotated version of our earlier 'Hello, World' program.

```
44444444083698432676976763290698279328479326965846918065686832707985823284793267697676327978691244440180124406568683284877932847932676976763284877912444065686832847282696932847932676976763284728269691244406568683284728269693284793267697676327079858212406568683279786932847932676976763270738669133335068696782697769788432676976763279786932677985788469821907679798032857884737632676976763279786932906982791240656868327978693284793267697676328487791240656868327978693284793267697676328472826969125068696782697769788432676976763270798582122406568683279786932847932676976763283738818390666567753284793267697676327978691350686967826977697884326769767632906982791907679798032658469328473776983122606769767632848779327383323972391255560676976763284728269693273833239693914444444664446065686832397676793912260656868328380656769135606568683239873913608583693269887383847378743239793914446555555655555555606568683239827668391224606568683239333912446065686832399278391
```

As you can see, commenting your programs is incredibly beneficial to readability and understandability. Although learning Dec does initially involve a steep learning curve, you will find that after sufficient practice its simplicity makes it far easier to debug and program in than most traditional programming languages.


After the DecCompiler has parsed the input integer, the tokenized program is displayed to the programmer for convenience. Our tokenized 'Hello World' program is shown below:
```
[ADD] [ADD] [ADD] [ADD] [ADD] [ADD] [ADD] [ADD] {COMMENT:SET CELL ZERO TO ATE}
[START LOOP] [RIGHT] [ADD] [ADD] [ADD] [ADD] {COMMENT:ADD FOUR TO CELL ONE}
[START LOOP] [RIGHT] [ADD] [ADD] {COMMENT:ADD TWO TO CELL TWO}
[RIGHT] [ADD] [ADD] [ADD] {COMMENT:ADD THREE TO CELL THREE}
[RIGHT] [ADD] [ADD] [ADD] {COMMENT:ADD THREE TO CELL FOUR}
[RIGHT] [ADD] {COMMENT:ADD ONE TO CELL FIVE}
[LEFT] [LEFT] [LEFT] [LEFT] [SUB] {COMMENT:DECREMENT CELL ONE COUNTER}
[END LOOP] {COMMENT:LOOP UNTIL CELL ONE ZERO}
[RIGHT] [ADD] {COMMENT:ADD ONE TO CELL TWO}
[RIGHT] [ADD] {COMMENT:ADD ONE TO CELL THREE}
[RIGHT] [SUB] {COMMENT:DECREMENT CELL FOUR}
[RIGHT] [RIGHT] [ADD] {COMMENT:ADD ONE TO CELL SIX}
[START LOOP] [LEFT] [END LOOP] {COMMENT:BACK TO CELL ONE}
[LEFT] [SUB] {COMMENT:DECREMENT CELL ZERO}
[END LOOP] {COMMENT:LOOP ATE TIMES}
[RIGHT] [RIGHT] [OUT] {COMMENT:CELL TWO IS 'H'}
[RIGHT] [SUB] [SUB] [SUB] [OUT] {COMMENT:CELL THREE IS 'E'}
[ADD] [ADD] [ADD] [ADD] [ADD] [ADD] [ADD] [OUT] [OUT] [ADD] [ADD] [ADD] [OUT] {COMMENT:ADD 'LLO'}
[RIGHT] [RIGHT] [OUT] {COMMENT:ADD SPACE}
[LEFT] [SUB] [OUT] {COMMENT:ADD 'W'}
[LEFT] [OUT] {COMMENT:USE EXISTIN 'O'}
[ADD] [ADD] [ADD] [OUT] [SUB] [SUB] [SUB] [SUB] [SUB] [SUB] [OUT] [SUB] [SUB] [SUB] [SUB] [SUB] [SUB] [SUB] [SUB] [OUT] {COMMENT:ADD 'RLD'}
[RIGHT] [RIGHT] [ADD] [OUT] {COMMENT:ADD '!'}
[RIGHT] [ADD] [ADD] [OUT] {COMMENT:ADD '\N'}
```
