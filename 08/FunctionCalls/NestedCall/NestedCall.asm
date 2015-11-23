(Sys.init) // function Sys.init

      // store arg_count in R14
        @0
        D=A
        @R14
        M=D

      // store jump address in R15
        @Sys.main
        D=A
        @R15
        M=D

      // push (return-address)
        @$L0
        D=A
          @SP // push D
          A=M
          M=D
          @SP
          M=M+1


      // call global call method
        @9999
        @$$GLOBAL.call
        0;JMP

($L0) // (return-address)

      @1 // pop temp 1
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

(Sys.init$LOOP)

      @Sys.init$LOOP // goto LOOP
      0;JMP

(Sys.main) // function Sys.main

      @123 // push constant 123
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      // store arg_count in R14
        @1
        D=A
        @R14
        M=D

      // store jump address in R15
        @Sys.add12
        D=A
        @R15
        M=D

      // push (return-address)
        @$L1
        D=A
          @SP // push D
          A=M
          M=D
          @SP
          M=M+1


      // call global call method
        @9999
        @$$GLOBAL.call
        0;JMP

($L1) // (return-address)

      @0 // pop temp 0
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

      @246 // push constant 246
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

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

        @$$GLOBAL.return
        0;JMP

(Sys.add12) // function Sys.add12
        @0 // 3 times push 0
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
          @SP // push D
          A=M
          M=D
          @SP
          M=M+1

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

      @12 // push constant 12
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

        @$$GLOBAL.return
        0;JMP

($$GLOBAL.call)
      // push LCL
        @LCL
        D=M
          @SP // push D
          A=M
          M=D
          @SP
          M=M+1

      // push ARG
        @ARG
        D=M
          @SP // push D
          A=M
          M=D
          @SP
          M=M+1

      // push THIS
        @THIS
        D=M
          @SP // push D
          A=M
          M=D
          @SP
          M=M+1

      // push THAT
        @THAT
        D=M
          @SP // push D
          A=M
          M=D
          @SP
          M=M+1

      // ARG = SP - arg_count - 5
        @SP
        D=M
        @R13
        M=D // R13 = SP
        @R14
        D=M
        @R13
        M=M-D // R13 = SP - arg_count
        @5
        D=A
        @R13
        D=M-D // D = SP - arg_count - 5
        @ARG
        M=D // ARG = SP - arg_count - 5
      // LCL = SP
        @SP
        D=M
        @LCL
        M=D
      // goto name
        @R15
        A=M
        0;JMP

($$GLOBAL.return)
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

