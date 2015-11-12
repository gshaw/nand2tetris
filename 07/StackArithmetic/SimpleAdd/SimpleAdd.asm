      // push constant 7
      @7
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      // push constant 8
      @8
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      // M+D
      @SP
      D=M
      AM=D-1
      D=M
      A=A-1
      M=M+D
