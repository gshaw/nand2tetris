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

      @0 // push constant 0
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @0 // pop that 0
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

      @1 // push constant 1
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @1 // pop that 1
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

      @2 // push constant 2
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

(.$MAIN_LOOP_START)

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

      @SP // if-goto COMPUTE_ELEMENT
      AM=M-1
      D=M // D = popped value from top of stack
      @.$COMPUTE_ELEMENT
      D;JNE

      @.$END_PROGRAM // goto END_PROGRAM
      0;JMP

(.$COMPUTE_ELEMENT)

      @0 // push that 0
      D=A
      @THAT
      A=M+D
      D=M
      @SP // push D on to stack
      A=M
      M=D
      @SP
      M=M+1

      @1 // push that 1
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

      @1 // push constant 1
      D=A
      @SP
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

      @.$MAIN_LOOP_START // goto MAIN_LOOP_START
      0;JMP

(.$END_PROGRAM)

