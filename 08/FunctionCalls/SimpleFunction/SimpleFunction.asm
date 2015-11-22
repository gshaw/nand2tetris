(SimpleFunction.test) // function SimpleFunction.test
        @0 // 2 times push 0
        D=A
          @SP // push D
          A=M
          M=D
          @SP
          M=M+1
          @SP // push D
          A=M
          M=D
          @SP
          M=M+1

      @0 // push local 0
      D=A
      @LCL
      A=M+D
      D=M
      @SP // push D on to stack
      A=M
      M=D
      @SP
      M=M+1

      @1 // push local 1
      D=A
      @LCL
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

      @SP // not
      A=M-1
      M=!M

      @0 // push argument 0
      D=A
      @ARG
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

      @1 // push argument 1
      D=A
      @ARG
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

      // FRAME = LCL (save FRAME in R13)
        @LCL
        D=M
        @R13
        M=D
      // RET = *(FRAME-5) (save return address in R14)
        @5
        A=D-A // A = FRAME-5
        D=M // D = *(FRAME-5)
        @R14
        M=D // R14 = RET
      // *ARG = pop()
        @SP
        AM=M-1 // dec SP
        D=M // top of stack into D
        @ARG
        A=M
        M=D
      // SP = ARG+1
        @ARG
        D=M+1
        @SP
        M=D
      // THAT = *(FRAME-1)
        @1
        D=A
        @R13
        A=M-D
        D=M
        @THAT
        M=D
      // THIS = *(FRAME-2)
        @2
        D=A
        @R13
        A=M-D
        D=M
        @THIS
        M=D
      // ARG = *(FRAME-3)
        @3
        D=A
        @R13
        A=M-D
        D=M
        @ARG
        M=D
      // LCL = *(FRAME-4)
        @4
        D=A
        @R13
        A=M-D
        D=M
        @LCL
        M=D
      // goto RET
        @R14
        A=M
        0;JMP

