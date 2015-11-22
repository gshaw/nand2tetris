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

      @SP // pop static 8
      AM=M-1 // dec SP
      D=M // top of stack into D
      @StaticTest.8 // write D (top of stack) to static address
      M=D

      @SP // pop static 3
      AM=M-1 // dec SP
      D=M // top of stack into D
      @StaticTest.3 // write D (top of stack) to static address
      M=D

      @SP // pop static 1
      AM=M-1 // dec SP
      D=M // top of stack into D
      @StaticTest.1 // write D (top of stack) to static address
      M=D

      @StaticTest.3 // push static 3
      D=M
      @SP // push D on to stack
      A=M
      M=D
      @SP
      M=M+1

      @StaticTest.1 // push static 1
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

      @StaticTest.8 // push static 8
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

