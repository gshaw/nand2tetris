      @10 // push constant 10
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @0 // pop local 0
      D=A // D = index
      @LCL // A = segment
      D=M+D // D = segment pointer + index (address to write top of stack to)
      @R13
      M=D // R13 = address to write top of stack to
      @SP // read top of stack into D
      AM=M-1 // dec SP
      D=M // top of stack into D
      @R13 // write D (top of stack) to address in R13
      A=M
      M=D

      @21 // push constant 21
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @22 // push constant 22
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @2 // pop argument 2
      D=A // D = index
      @ARG // A = segment
      D=M+D // D = segment pointer + index (address to write top of stack to)
      @R13
      M=D // R13 = address to write top of stack to
      @SP // read top of stack into D
      AM=M-1 // dec SP
      D=M // top of stack into D
      @R13 // write D (top of stack) to address in R13
      A=M
      M=D

      @1 // pop argument 1
      D=A // D = index
      @ARG // A = segment
      D=M+D // D = segment pointer + index (address to write top of stack to)
      @R13
      M=D // R13 = address to write top of stack to
      @SP // read top of stack into D
      AM=M-1 // dec SP
      D=M // top of stack into D
      @R13 // write D (top of stack) to address in R13
      A=M
      M=D

      @36 // push constant 36
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @6 // pop this 6
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

      @42 // push constant 42
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @45 // push constant 45
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @5 // pop that 5
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

      @2 // pop that 2
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

      @510 // push constant 510
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @6 // pop temp 6
      D=A // D = index
      @R5 // A = segment
      D=A+D // D = segment pointer + index (address to write top of stack to)
      @R13
      M=D // R13 = address to write top of stack to
      @SP // read top of stack into D
      AM=M-1 // dec SP
      D=M // top of stack into D
      @R13 // write D (top of stack) to address in R13
      A=M
      M=D

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

      @5 // push that 5
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

      @6 // push this 6
      D=A
      @THIS
      A=M+D
      D=M
      @SP // push D on to stack
      A=M
      M=D
      @SP
      M=M+1

      @6 // push this 6
      D=A
      @THIS
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

      @SP // sub
      D=M
      AM=D-1
      D=M
      A=A-1
      M=M-D

      @6 // push temp 6
      D=A
      @R5
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

