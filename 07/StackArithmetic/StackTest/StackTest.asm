      @17 // push constant 17
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @17 // push constant 17
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @SP // conditional JEQ
      AM=M-1 // dec SP
      D=M    // d = y
      A=A-1  // a -> x
      D=M-D  // d = x - y
      @$L0
      D;JEQ
      D=0
      @$L1
      0;JMP
    ($L0)
      D=-1
    ($L1)
      @SP
      A=M-1
      M=D

      @17 // push constant 17
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @16 // push constant 16
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @SP // conditional JEQ
      AM=M-1 // dec SP
      D=M    // d = y
      A=A-1  // a -> x
      D=M-D  // d = x - y
      @$L2
      D;JEQ
      D=0
      @$L3
      0;JMP
    ($L2)
      D=-1
    ($L3)
      @SP
      A=M-1
      M=D

      @16 // push constant 16
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @17 // push constant 17
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @SP // conditional JEQ
      AM=M-1 // dec SP
      D=M    // d = y
      A=A-1  // a -> x
      D=M-D  // d = x - y
      @$L4
      D;JEQ
      D=0
      @$L5
      0;JMP
    ($L4)
      D=-1
    ($L5)
      @SP
      A=M-1
      M=D

      @892 // push constant 892
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @891 // push constant 891
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @SP // conditional JLT
      AM=M-1 // dec SP
      D=M    // d = y
      A=A-1  // a -> x
      D=M-D  // d = x - y
      @$L6
      D;JLT
      D=0
      @$L7
      0;JMP
    ($L6)
      D=-1
    ($L7)
      @SP
      A=M-1
      M=D

      @891 // push constant 891
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @892 // push constant 892
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @SP // conditional JLT
      AM=M-1 // dec SP
      D=M    // d = y
      A=A-1  // a -> x
      D=M-D  // d = x - y
      @$L8
      D;JLT
      D=0
      @$L9
      0;JMP
    ($L8)
      D=-1
    ($L9)
      @SP
      A=M-1
      M=D

      @891 // push constant 891
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @891 // push constant 891
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @SP // conditional JLT
      AM=M-1 // dec SP
      D=M    // d = y
      A=A-1  // a -> x
      D=M-D  // d = x - y
      @$L10
      D;JLT
      D=0
      @$L11
      0;JMP
    ($L10)
      D=-1
    ($L11)
      @SP
      A=M-1
      M=D

      @32767 // push constant 32767
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @32766 // push constant 32766
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @SP // conditional JGT
      AM=M-1 // dec SP
      D=M    // d = y
      A=A-1  // a -> x
      D=M-D  // d = x - y
      @$L12
      D;JGT
      D=0
      @$L13
      0;JMP
    ($L12)
      D=-1
    ($L13)
      @SP
      A=M-1
      M=D

      @32766 // push constant 32766
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @32767 // push constant 32767
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @SP // conditional JGT
      AM=M-1 // dec SP
      D=M    // d = y
      A=A-1  // a -> x
      D=M-D  // d = x - y
      @$L14
      D;JGT
      D=0
      @$L15
      0;JMP
    ($L14)
      D=-1
    ($L15)
      @SP
      A=M-1
      M=D

      @32766 // push constant 32766
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @32766 // push constant 32766
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @SP // conditional JGT
      AM=M-1 // dec SP
      D=M    // d = y
      A=A-1  // a -> x
      D=M-D  // d = x - y
      @$L16
      D;JGT
      D=0
      @$L17
      0;JMP
    ($L16)
      D=-1
    ($L17)
      @SP
      A=M-1
      M=D

      @57 // push constant 57
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @31 // push constant 31
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @53 // push constant 53
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

      @112 // push constant 112
      D=A
      @SP
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

      @SP // unary operation -M
      A=M-1
      M=-M

      @SP // binary operation M&D
      D=M
      AM=D-1
      D=M
      A=A-1
      M=M&D

      @82 // push constant 82
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @SP // binary operation M|D
      D=M
      AM=D-1
      D=M
      A=A-1
      M=M|D

      @SP // unary operation !M
      A=M-1
      M=!M

