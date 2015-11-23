      // init bootstrap
      @256
      D=A
      @SP
      M=D

      // call Sys.init
      // store arg_count in R14
        @0
        D=A
        @R14
        M=D

      // store jump address in R15
        @Sys.init
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


(Class1.set) // function Class1.set

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

      @SP // pop static 0
      AM=M-1 // dec SP
      D=M // top of stack into D
      @Class1.0 // write D (top of stack) to static address
      M=D

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

      @SP // pop static 1
      AM=M-1 // dec SP
      D=M // top of stack into D
      @Class1.1 // write D (top of stack) to static address
      M=D

      @0 // push constant 0
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

(Class1.get) // function Class1.get

      @Class1.0 // push static 0
      D=M
      @SP // push D on to stack
      A=M
      M=D
      @SP
      M=M+1

      @Class1.1 // push static 1
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

        @$$GLOBAL.return
        0;JMP

(Class2.set) // function Class2.set

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

      @SP // pop static 0
      AM=M-1 // dec SP
      D=M // top of stack into D
      @Class2.0 // write D (top of stack) to static address
      M=D

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

      @SP // pop static 1
      AM=M-1 // dec SP
      D=M // top of stack into D
      @Class2.1 // write D (top of stack) to static address
      M=D

      @0 // push constant 0
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

(Class2.get) // function Class2.get

      @Class2.0 // push static 0
      D=M
      @SP // push D on to stack
      A=M
      M=D
      @SP
      M=M+1

      @Class2.1 // push static 1
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

        @$$GLOBAL.return
        0;JMP

(Sys.init) // function Sys.init

      @6 // push constant 6
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

      // store arg_count in R14
        @2
        D=A
        @R14
        M=D

      // store jump address in R15
        @Class1.set
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

      @23 // push constant 23
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      @15 // push constant 15
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1

      // store arg_count in R14
        @2
        D=A
        @R14
        M=D

      // store jump address in R15
        @Class2.set
        D=A
        @R15
        M=D

      // push (return-address)
        @$L2
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

($L2) // (return-address)

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

      // store arg_count in R14
        @0
        D=A
        @R14
        M=D

      // store jump address in R15
        @Class1.get
        D=A
        @R15
        M=D

      // push (return-address)
        @$L3
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

($L3) // (return-address)

      // store arg_count in R14
        @0
        D=A
        @R14
        M=D

      // store jump address in R15
        @Class2.get
        D=A
        @R15
        M=D

      // push (return-address)
        @$L4
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

($L4) // (return-address)

(Sys.init$WHILE)

      @Sys.init$WHILE // goto WHILE
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

