      @111 // push constant 111
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @333 // push constant 333
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @888 // push constant 888
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @8 // pop static 8
      D=A // D = index
      @StaticTest.8 // A = segment
      D=A // D = segment pointer + index (address to write top of stack to)
      @R13
      M=D // R13 = address to write top of stack to
      @SP // read top of stack into D
      AM=M-1 // dec SP
      D=M // top of stack into D
      @R13 // write D (top of stack) to address in R13
      A=M
      M=D

      @3 // pop static 3
      D=A // D = index
      @StaticTest.3 // A = segment
      D=A // D = segment pointer + index (address to write top of stack to)
      @R13
      M=D // R13 = address to write top of stack to
      @SP // read top of stack into D
      AM=M-1 // dec SP
      D=M // top of stack into D
      @R13 // write D (top of stack) to address in R13
      A=M
      M=D

      @1 // pop static 1
      D=A // D = index
      @StaticTest.1 // A = segment
      D=A // D = segment pointer + index (address to write top of stack to)
      @R13
      M=D // R13 = address to write top of stack to
      @SP // read top of stack into D
      AM=M-1 // dec SP
      D=M // top of stack into D
      @R13 // write D (top of stack) to address in R13
      A=M
      M=D

      @3 // push static 3
      D=A
      @StaticTest.3
      A=A
      D=M
      @SP // push D on to stack
      A=M
      M=D
      @SP
      M=M+1

      @1 // push static 1
      D=A
      @StaticTest.1
      A=A
      D=M
      @SP // push D on to stack
      A=M
      M=D
      @SP
      M=M+1

      @SP // binary operation M-D
      D=M
      AM=D-1
      D=M
      A=A-1
      M=M-D

      @8 // push static 8
      D=A
      @StaticTest.8
      A=A
      D=M
      @SP // push D on to stack
      A=M
      M=D
      @SP
      M=M+1

      @SP // binary operation M+D
      D=M
      AM=D-1
      D=M
      A=A-1
      M=M+D

