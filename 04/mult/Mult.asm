// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// multiplication is add in a loop
// 5 * 4 = 5 + 5 + 5 + 5

// R2 = 0
// i = R1
// while i > 0
//   R2 = R2 + R0
//   i = i - 1
// end

// R0 = 5
// R1 = 4
//
// R2 = 0
// i = R1
//
// LOOP:
// if i <= 0 goto END
// R2 = R0 + R2
// i = i - 1
// goto LOOP
//
// END:
// goto END

    @R2
    M=0 // R2 = 0

    @R1
    D=M // D = R1
    @i  // assigned by assembler as symbols discoverd, starting at 10000b
    M=D // i = D = R1

(LOOP)
    @i
    D=M     // D = i
    @END    // A = @END
    D;JLE   // if (i <= 0) goto END

    @R0     // A = R0
    D=M     // D = R0
    @R2
    M=D+M   // R2 = D + R2 = R0 + R2

    @i
    D=M     // D = i
    M=D-1   // i = D - 1 = i - 1

    @LOOP
    0;JMP   // goto LOOP

(END)
    @END
    0;JMP   // infinite loop
