// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, the
// program clears the screen, i.e. writes "white" in every pixel.


// screen starts at 16384 0x4000
// screen is 8K (512x256)
// memory words are 16 bits so single memory location holds 16 pixels
// 1 = black, 0 = white

// keyboard is at 0x6000 24576, single word

//begin:
//  R0 = 0 // R0 = color
//  if keypressed
//    R0 = 1
//
//  // fill screen with value in @R0
//  i = 0
//  while i < screen_size
//    M[i + screen_offset] = R0
//    i = i + 1
//
//goto begin

// R0: fill value
// R1: screen pointer
// R2: loop counter

(BEGIN)
  @R0
  M=0 // fill = white

  // check for key press
  @KBD // keyboard memory map locaiton
  D=M
  @FILL_SCREEN
  D;JEQ // goto FILL_SCREEN if no key pressed

  @R0
  M=-1 // fill = black

(FILL_SCREEN)
  @SCREEN // base screen pointer
  D=A
  @R1
  M=D // R1 = screen base

  @8192 // screen size (8192)
  D=A
  @R2
  M=D // i = 8192

(PIXEL_LOOP)
  @BEGIN
  D;JEQ // if i == 0 goto BEGIN

  @R0
  D=M // D = fill
  @R1
  A=M
  M=D // M[screen base] = fill

  @R1
  MD=M+1 // screen base = screen base + 1

  @R2
  D=M
  MD=D-1 // i = i - 1

  @PIXEL_LOOP
  0;JMP // goto LOOP
