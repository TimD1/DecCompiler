# Compiling Dec with the DecCompiler
This is my CS445 "free will" project, an extension of the [BrainFuck][1] language to include comments and operate using decimal characters. BrainFuck derived it's name from how tediously impossible it is to program in. It operates exactly like a Turing machine, and all possible operations are described below.

[1]: https://en.wikipedia.org/wiki/Brainfuck

### Key:
|Dec Character	| BrainFuck Character	| C Equivalent	| Explanation|
|:-------------:|:---------------------:|:-------------:|:-----------|
|	`0`			|		`none`			|	`/*`		| start comment
|	`1`			|		`none`			|	`*/`		| end commment
|	`2`			|		`>`				|	`++ptr;`		|increment the data pointer (to point to the next cell to the right).
|	`3`			|		`<`				|	`--ptr;`		|decrement the data pointer (to point to the next cell to the left).
|	`4`			|		`+`				|	`++*ptr;`	| increment the byte at the data pointer
|	`5`			|		`-`				|	`--*ptr;`	|decrement the byte at the data pointer
|	`6`			|		`.`				|`putchar(*ptr);`|output the byte at the data pointer
|	`7`			|		`,`				|`*ptr=getchar();`|accept one byte of input, storing its value in the byte at the data pointer
|	`8`			|		`[`				|`while(*ptr) {	`|if the byte at the data pointer is zero, jump to the matching ]
|	`9`			|		`]`				|		`}`		|if the byte at the data pointer is nonzero, jump back to the matching \[

I thought it would be interesting to extend the simple language of BrainFuck into a decimal equivalent called Dec so that a program can be written as a single decimal number. A simple 'Hello, World' program is shown below:

```
4444444482444482442444244424333359242425224839359226255564444444664446226356364446555555655555555622462446 
```

If this program is too confusing, comments may be introduced to make the code more readable. Note that although whitespace and ASCII characters are entirely legal and will be ignored by the compiler, this is highly discouraged because Dec programs were intended to consist of a single number. Any helpful comments introduced should therefore be written in decimal form, using the decimal equivalent of that letter's capital ASCII value. The letters G (ASCII value 71) and Q (ASCII value 81) should be avoided, since their usage causes the immediate ending of a comment. An annotated 'Hello, World' program is shown below.

```
44444444083698432676976763290698279328479326965846918065686832707985823284793267697676327978691244440180124406568683284877932847932676976763284877912444065686832847282696932847932676976763284728269691244406568683284728269693284793267697676327079858212406568683279786932847932676976763270738669133335068696782697769788432676976763279786932677985788469821907679798032857884737632676976763279786932906982791240656868327978693284793267697676328487791240656868327978693284793267697676328472826969125068696782697769788432676976763270798582122406568683279786932847932676976763283738818390666567753284793267697676327978691350686967826977697884326769767632906982791907679798032658469328473776983122606769767632848779327383323972391255560676976763284728269693273833239693914444444664446065686832397676793912260656868328380656769135606568683239873913608583693269887383847378743239793914446555555655555555606568683239827668391224606568683239333912446065686832399278391
```

Now, isn't that much more helpful? There is a steep learning curve, but once you have mastered Dec you will find it to be an incredibly useful programming language.

Once parsed, this tokenized program becomes:
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
