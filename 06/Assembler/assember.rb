class Parser
  attr_reader :current_line, :current_match, :input

  COMMENT_PATTERN = %r{//.*\z}

  def initialize(input)
    @input = input
    @current_line = nil
  end

  def has_more_commands?
    !input.eof?
  end

  # Reads the next command from the input and makes it the current command.
  # Should be calld only if more_commands? is true.  Initially there is no
  # current command.
  def advance
    loop do
      break unless has_more_commands?
      @current_line = input.readline.strip.gsub(COMMENT_PATTERN, "").strip
      break unless current_line == ""
    end
  end

  DEST_PATTERN    = /A|AD|AM|ADM|AMD|D|DA|DM|DAM|DMA|M|MA|MD|MAD|MDA/
  COMP_A0_PATTERN = /0|1|-1|[AD]|\![AD]|-[AD]|[AD]\+1|[AD]-1|D\+A|A+D|A-D|D-A|A&D|D&A|D\|A|A\|D/
  COMP_A1_PATTERN = /M|\!M|-M|M\+1|M-1|D\+M|M\+D|D-M|M-D|D&M|M&D|D\|M|M\|D/
  JUMP_PATTERN    = /J(GT|EQ|GE|LT|NE|LE|MP)/

  A_PATTERN = /\A@(?<symbol>\d+)\z/ # @value
  L_PATTERN = /\A\((?<symbol>w+)\)\z/ # (symbol)
  # dest=comp;jump
  C_PATTERN = /\A((?<dest>#{DEST_PATTERN})\s*=\s*)?((?<comp>(#{COMP_A0_PATTERN})|(#{COMP_A1_PATTERN})))(\s*;\s*(?<jump>#{JUMP_PATTERN}))?\z/

  def command_type
    @current_match = A_PATTERN.match(current_line) and return :a_command
    @current_match = C_PATTERN.match(current_line) and return :c_command
    @current_match = L_PATTERN.match(current_line) and return :l_command

    fail "Cannot parse line: #{current_line}"
  end

  # Returns thte symbol or decimal Xxx of the current command @Xxx or (Xxx).
  # Should be called only when command_type is A_COMMAND or L_COMMAND.
  def symbol
    current_match[:symbol]
  end

  # Returns the dest mnemonic in the current C-command (8 possibilities).
  # Should be called only when command_type is C_COMMAND.
  def dest
    current_match[:dest]
  end

  def comp
    current_match[:comp]
  end

  def jump
    current_match[:jump]
  end
end

class Code
  def comp(mnemonic)
    case mnemonic
    when "0" then "0101010"
    when "1" then "0111111"
    when "-1" then "0111010"
    when "D" then "0001100"
    when "A" then "0110000"
    when "M" then "1110000"
    when "!D" then "0001101"
    when "!A" then "0110001"
    when "!M" then "1110001"
    when "D+1" then "0011111"
    when "A+1" then "0110111"
    when "M+1" then "1110111"
    when "D-1" then "0001110"
    when "A-1" then "0110010"
    when "M-1" then "1110010"
    when "D+A", "A+D" then "0000010"
    when "D+M", "M+D" then "1000010"
    when "D-A" then "0010011"
    when "D-M" then "1010011"
    when "A-D" then "0000111"
    when "M-D" then "1000111"
    when "D&A", "A&D" then "0000000"
    when "D&M", "M&D" then "1000000"
    when "D|A", "A|D" then "0010101"
    when "D|M", "M|D" then "1010101"
    else
      fail "Unknown mnemonic #{mnemonic}"
    end
  end

  def dest(mnemonic)
    case mnemonic
    when "M" then "001"
    when "D" then "010"
    when "MD", "DM" then "011"
    when "A" then "100"
    when "AM", "MA" then "101"
    when "AD", "DA" then "110"
    when "AMD", "ADM", "MAD", "MDA", "DAM", "DMA" then "111"
    else
      "000"
    end
  end

  def jump(mnemonic)
    case mnemonic
    when "JGT" then "001"
    when "JEQ" then "010"
    when "JGE" then "011"
    when "JLT" then "100"
    when "JNE" then "101"
    when "JLE" then "110"
    when "JMP" then "111"
    else
      "000"
    end
  end
end

class Assembler
  def assemble(input_path)
    output_path = input_path.gsub(/.asm\z/i, ".hack")
    input = File.open(input_path, "r")
    output = File.open(output_path, "w")
    generate(input, output)
    input.close
    output.close
  end

  def generate(input, output)
    code = Code.new
    parser = Parser.new(input)
    while parser.has_more_commands?
      parser.advance

      case parser.command_type
      when :a_command
        output.puts "%016b" % parser.symbol.to_i

      when :c_command
        comp = code.comp(parser.comp)
        dest = code.dest(parser.dest)
        jump = code.jump(parser.jump)
        output.puts "111#{comp}#{dest}#{jump}"

      when :l_command
        fail "No supported yet"
      end
    end
  end
end

Assembler.new.assemble(ARGV[0])
