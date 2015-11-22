      @3030 // push constant 3030
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @0 // pop pointer 0
      D=A // D = index
      @R3 // A = segment
      D=A+D // D = segment pointer + index (address to write top of stack to)
      @R13
      M=D // R13 = address to write top of stack to
      @SP // read top of stack into D
      AM=M-1 // dec SP
      D=M // top of stack into D
      @R13 // write D (top of stack) to address in R13
      A=M
      M=D

      @3040 // push constant 3040
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @1 // pop pointer 1
      D=A // D = index
      @R3 // A = segment
      D=A+D // D = segment pointer + index (address to write top of stack to)
      @R13
      M=D // R13 = address to write top of stack to
      @SP // read top of stack into D
      AM=M-1 // dec SP
      D=M // top of stack into D
      @R13 // write D (top of stack) to address in R13
      A=M
      M=D

      @32 // push constant 32
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @2 // pop this 2
      D=A // D = index
      @THIS // A = segment
      D=M+D // D = segment pointer + index (address to write top of stack to)
      @R13
      M=D // R13 = address to write top of stack to
      @SP // read top of stack into D
      AM=M-1 // dec SP
      D=M // top of stack into D
      @R13 // write D (top of stack) to address in R13
      A=M
      M=D

      @46 // push constant 46
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @6 // pop that 6
      D=A // D = index
      @THAT // A = segment
      D=M+D // D = segment pointer + index (address to write top of stack to)
      @R13
      M=D // R13 = address to write top of stack to
      @SP // read top of stack into D
      AM=M-1 // dec SP
      D=M // top of stack into D
      @R13 // write D (top of stack) to address in R13
      A=M
      M=D

      @0 // push pointer 0
      D=A
      @R3
      A=A+D
      D=M
      @SP // push D on to stack
      A=M
      M=D
      @SP
      M=M+1

      @1 // push pointer 1
      D=A
      @R3
      A=A+D
      D=M
      @SP // push D on to stack
      A=M
      M=D
      @SP
      M=M+1

      @SP // add
      D=M
      AM=D-1
      D=M
      A=A-1
      M=M+D

      @2 // push this 2
      D=A
      @THIS
      A=M+D
      D=M
      @SP // push D on to stack
      A=M
      M=D
      @SP
      M=M+1

      @SP // sub
      D=M
      AM=D-1
      D=M
      A=A-1
      M=M-D

      @6 // push that 6
      D=A
      @THAT
      A=M+D
      D=M
      @SP // push D on to stack
      A=M
      M=D
      @SP
      M=M+1

      @SP // add
      D=M
      AM=D-1
      D=M
      A=A-1
      M=M+D

