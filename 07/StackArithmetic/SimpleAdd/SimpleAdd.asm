      @7 // push constant 7
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @8 // push constant 8
      D=A
      @SP
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

