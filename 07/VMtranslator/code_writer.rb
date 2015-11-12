class CodeWriter
  attr_accessor :static_count
  attr_reader :basename, :output

  def initialize(path)
    @basename = File.basename(path, ".vm")
    @output = File.open(path, "w")
    @static_count = 0
  end

  def close
    output.close
  end

  def write_math(command)
    write case command
    when "add" then add_asm
    when "sub" then sub_asm
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

  def segment_address(segment, index)
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
      @#{value}
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
      @#{index}
      D=A
      @#{segment_address(segment, index)}
      A=M+D
      D=M

      #{push_d_asm}
    ASM
  end

  def pop_asm(segment, index)
    # pop the top of the stack and store it in segment[index]
    # segment[index] = stack[sp]
    # sp -= 1
    <<-ASM
      // save desination pointer in R13
      @#{index}
      D=A
      @#{segment_address(segment, index)}
      D=M+D
      @R13
      M=D
      // read value from stack into D
      @SP
      A=M
      D=M
      // write value from stack at address in R13
      @R13
      A=M
      D=M
      // dec stack pointer
      @SP
      D=M
      M=D-1

    ASM
  end

  def add_asm
    # pop, pop, push 1
    <<-ASM
      @SP
      D=M
      AM=D-1
      D=M
      A=A-1
      M=M+D
    ASM
  end

  def sub_asm
    <<-ASM
      @SP
      D=M
      AM=D-1
      D=M
      A=A-1
      M=M-D
    ASM
  end
end
