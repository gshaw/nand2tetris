      @0 // push constant 0
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

(.$LOOP_START)

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

      @SP // add
      D=M
      AM=D-1
      D=M
      A=A-1
      M=M+D

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

      @1 // push constant 1
      D=A
      @SP
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

      @0 // pop argument 0
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

      @SP // if-goto LOOP_START
      AM=M-1
      D=M // D = popped value from top of stack
      @.$LOOP_START
      D;JNE

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

