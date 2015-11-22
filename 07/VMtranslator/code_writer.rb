class CodeWriter
  attr_accessor :static_count
  attr_reader :basename, :output

  def initialize(path)
    @basename = File.basename(path, ".vm")
    @output = File.open(path, "w")
    @static_count = 0
    @local_label_count = 0
  end

  def close
    output.close
  end

  def write_math(command)
    write case command
    when "add" then binary_operation_asm("M+D")
    when "sub" then binary_operation_asm("M-D")
    when "and" then binary_operation_asm("M&D")
    when "or"  then binary_operation_asm("M|D")

    when "neg" then unary_operation_asm("-M")
    when "not" then unary_operation_asm("!M")

    when "eq"  then conditional_asm("JEQ")
    when "lt"  then conditional_asm("JLT")
    when "gt"  then conditional_asm("JGT")
    else
      fail "Unknown math command: #{command}"
    end
  end

  def write_push_pop(command, segment, index)
    write case command
    when "push" then push_asm(segment, index)
    when "pop"  then pop_asm(segment, index)
    else
      fail "Unknown push pop command: #{command}"
    end
  end

  def write(asm)
    output.puts(asm)
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
    when "constant"
      index.to_s

    when "static"
      address = "#{basename}.#{static_count}"
      self.static_count += 1
      address

    else
      fail "Unknown segment #{segment}"
    end
  end

  def push_constant(value)
    # push value onto stack
    <<-ASM
      @#{value} // push constant #{value}
      D=A
#{push_d_asm}
    ASM
  end

  def push_d_asm
    <<-ASM
      @SP
      A=M
      M=D
      @SP
      M=M+1
    ASM
  end

  def push_asm(segment, index)
    return push_constant(index) if segment == "constant"

    # push the value at segment[index] onto the stack
    # stack[sp] = segment[index]
    # sp += 1
    <<-ASM
      @#{index} // push #{segment} #{index}
      D=A
      @#{segment_symbol(segment, index)}
      A=M+D
      D=M
#{push_d_asm}
    ASM
  end

  def pop_asm(segment, index)
    # pop the top of the stack and store it in segment[index]
    # segment[index] = stack[sp]
    # sp -= 1
    # TODO: Determine if there is a way to do this without a temp register
    <<-ASM
      @#{index} // pop #{segment} #{index}
      D=A
      @#{segment_symbol(segment, index)}
      D=M+D
      @R13
      M=D
      @SP // read value from stack into D
      A=M
      D=M   // read top of stack into D
      M=M-1 // dec stack pointer
      @R13 // write D (top of stack) to address in R13
      A=M
      M=D

    ASM
  end

  def unary_operation_asm(operation)
    <<-ASM
      @SP // unary operation #{operation}
      A=M-1
      M=#{operation}
    ASM
  end

  def binary_operation_asm(operation)
    <<-ASM
      @SP // binary operation #{operation}
      D=M
      AM=D-1
      D=M
      A=A-1
      M=#{operation}

    ASM
  end

  def conditional_asm(conditional_jump_instruction)
    equal_label = next_local_label
    end_label = next_local_label
    <<-ASM
      @SP // conditional #{conditional_jump_instruction}
      AM=M-1 // dec SP
      D=M    // d = y
      A=A-1  // a -> x
      D=M-D  // d = x - y
      @#{equal_label}
      D;#{conditional_jump_instruction}
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
