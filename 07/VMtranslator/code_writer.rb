class CodeWriter
  attr_reader :basename, :output
  attr_accessor :input_path

  def initialize(output_path)
    @output = File.open(output_path, "w")
    @local_label_count = 0
    @current_function_name = "."
    @input_path = nil
  end

  def close
    output.close
  end

  def write_init
    write init_asm
  end

  def write_math(command)
    write math_asm(command)
  end

  def write_push(segment, index)
    write push_asm(segment, index)
  end

  def write_pop(segment, index)
    write pop_asm(segment, index)
  end

  def write_label(label)
    write "(#{label_specification(label)})"
  end

  def write_if(label)
    write if_asm(label)
  end

  def write_goto(label)
    write goto_asm(label)
  end

  def write_function(name, arg_count)
    @current_function_name = name
    write function_asm(name, arg_count.to_i)
  end

  def write_call(name, arg_count)
    write call_asm(name, arg_count.to_i)
  end

  def write_return
    write return_asm
  end

  private

  def write(asm)
    output.puts(asm)
    output.puts
  end

  def label_specification(label)
    "#{@current_function_name}$#{label}"
  end

  def init_asm
    <<-ASM
      // init bootstrap
      @256
      D=A
      @SP
      M=D

      // call Sys.init
#{call_asm("Sys.init", 0)}
    ASM
  end

  def function_asm(name, arg_count)
    asm = "(#{name}) // function #{name}\n"
    if arg_count > 0
      asm << <<-ASM
        @0 // #{arg_count} times push 0
        D=A
      ASM
      arg_count.times do |index|
        asm << push_d_asm
      end
    end
    asm
  end

  def push_d_asm
    <<-ASM
          @SP // push D
          A=M
          M=D
          @SP
          M=M+1
    ASM
  end

  def call_asm(name, arg_count)
    return_label = next_local_label
    <<-ASM
      // push (return-address)
        @#{return_label}
        D=A
#{push_d_asm}
      // push LCL
        @LCL
        D=M
#{push_d_asm}
      // push ARG
        @ARG
        D=M
#{push_d_asm}
      // push THIS
        @THIS
        D=M
#{push_d_asm}
      // push THAT
        @THAT
        D=M
#{push_d_asm}
      // ARG = SP - arg_count - 5
        @SP
        D=M
        @R13
        M=D // R13 = SP
        @#{arg_count}
        D=A
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
        @#{name}
        0;JMP
(#{return_label}) // (return-address)
    ASM
  end

  def return_asm
    <<-ASM
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
    ASM
  end

  def if_asm(label)
    # pop stack to D
    # @label
    # if neq goto label
    # else continue
    <<-ASM
      @SP // if-goto #{label}
      AM=M-1
      D=M // D = popped value from top of stack
      @#{label_specification(label)}
      D;JNE
    ASM
  end

  def goto_asm(label)
    <<-ASM
      @#{label_specification(label)} // goto #{label}
      0;JMP
    ASM
  end

  def math_asm(command)
    case command
    when "add" then binary_operation_asm(command, "M+D")
    when "sub" then binary_operation_asm(command, "M-D")
    when "and" then binary_operation_asm(command, "M&D")
    when "or"  then binary_operation_asm(command, "M|D")

    when "neg" then unary_operation_asm(command, "-M")
    when "not" then unary_operation_asm(command, "!M")

    when "eq"  then conditional_asm(command, "JEQ")
    when "lt"  then conditional_asm(command, "JLT")
    when "gt"  then conditional_asm(command, "JGT")
    else
      fail "Unknown math command: #{command}"
    end
  end

  def next_local_label
    local_label = "$L#{@local_label_count}"
    @local_label_count += 1
    local_label
  end

  def segment_symbol(segment, index)
    case segment
    when "argument" then "ARG"
    when "local"    then "LCL"
    when "this"     then "THIS"
    when "that"     then "THAT"
    when "pointer"  then "R3"
    when "temp"     then "R5"
    when "static"   then "#{static_segment_symbol(index)}"
    else
      fail "Unknown segment #{segment}"
    end
  end

  def static_segment_symbol(index)
    basename = File.basename(input_path, ".vm")
    "#{basename}.#{index}"
  end

  def push_asm(segment, index)
    case segment
    when "constant"
      push_constant_asm(index)

    when "static"
      push_static_asm(index)

    when "pointer", "temp"
      push_indirect_asm(segment, index, "A+D")

    else
      push_indirect_asm(segment, index, "M+D")
    end
  end

  def push_constant_asm(value)
    # push value onto stack
    <<-ASM
      @#{value} // push constant #{value}
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1
    ASM
  end

  def push_static_asm(index)
    # push the value at segment[index] onto the stack
    # stack[sp] = segment[index]
    # sp += 1
    <<-ASM
      @#{segment_symbol("static", index)} // push static #{index}
      D=M
      @SP // push D on to stack
      A=M
      M=D
      @SP
      M=M+1
    ASM
  end

  def push_indirect_asm(segment, index, offset_calculation)
    # push the value at segment[index] onto the stack
    # stack[sp] = segment[index]
    # sp += 1
    <<-ASM
      @#{index} // push #{segment} #{index}
      D=A
      @#{segment_symbol(segment, index)}
      A=#{offset_calculation}
      D=M
      @SP // push D on to stack
      A=M
      M=D
      @SP
      M=M+1
    ASM
  end

  def pop_asm(segment, index)
    case segment
    when "static"
      pop_static_asm(index)

    when "pointer", "temp"
      pop_indirect_asm(segment, index, "A+D")

    else
      pop_indirect_asm(segment, index, "M+D")
    end
  end

  def pop_static_asm(index)
    <<-ASM
      @SP // pop static #{index}
      AM=M-1 // dec SP
      D=M // top of stack into D
      @#{segment_symbol("static", index)} // write D (top of stack) to static address
      M=D
    ASM
  end

  def pop_indirect_asm(segment, index, offset_calculation)
    # pop the top of the stack and store it in segment[index]
    # segment[index] = stack[sp]
    # sp -= 1
    <<-ASM
      @#{index} // pop #{segment} #{index}
      D=A // D = index
      @#{segment_symbol(segment, index)} // A = segment
      D=#{offset_calculation} // D = segment pointer + index (address to write top of stack to)
      @R13
      M=D // R13 = address to write top of stack to
      @SP // read top of stack into D
      AM=M-1 // dec SP
      D=M // top of stack into D
      @R13 // write D (top of stack) to address in R13
      A=M
      M=D
    ASM
  end

  def unary_operation_asm(command, calculation)
    <<-ASM
      @SP // #{command}
      A=M-1
      M=#{calculation}
    ASM
  end

  def binary_operation_asm(command, calculation)
    <<-ASM
      @SP // #{command}
      D=M
      AM=D-1
      D=M
      A=A-1
      M=#{calculation}
    ASM
  end

  def conditional_asm(command, jump_condition)
    equal_label = next_local_label
    end_label = next_local_label
    <<-ASM
      @SP // #{command}
      AM=M-1 // dec SP
      D=M    // d = y
      A=A-1  // a -> x
      D=M-D  // d = x - y
      @#{equal_label}
      D;#{jump_condition}
      D=0
      @#{end_label}
      0;JMP
    (#{equal_label})
      D=-1
    (#{end_label})
      @SP
      A=M-1
      M=D
    ASM
  end
end
