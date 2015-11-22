class Parser
  attr_reader :current_line, :current_match, :input

  def initialize(input)
    @input = input
    @current_line = nil
  end

  def has_more_commands?
    !input.eof?
  end

  # Advance current_line to next non-blank line or until EOF.
  def advance
    @current_line = input.readline.strip.gsub(COMMENT_PATTERN, "").strip
  end

  COMMENT_PATTERN = %r{//.*\z}

  DEST_PATTERN    = /A|AD|AM|ADM|AMD|D|DA|DM|DAM|DMA|M|MA|MD|MAD|MDA/
  COMP_A0_PATTERN = /0|1|-1|[AD]|\![AD]|-[AD]|[AD]\+1|[AD]-1|D\+A|A\+D|A-D|D-A|A&D|D&A|D\|A|A\|D/
  COMP_A1_PATTERN = /M|\!M|-M|M\+1|M-1|D\+M|M\+D|D-M|M-D|D&M|M&D|D\|M|M\|D/
  JUMP_PATTERN    = /J(GT|EQ|GE|LT|NE|LE|MP)/

  SYMBOL_PATTERN = /[A-Za-z\d_\.\$\:]+/
  CONSTANT_PATTERN = /\A\d+\z/

  # @symbol|constant
  A_PATTERN = /\A@(?<symbol>#{SYMBOL_PATTERN})\z/

  # (symbol)
  L_PATTERN = /\A\((?<symbol>#{SYMBOL_PATTERN})\)\z/

  # dest=comp;jump
  C_PATTERN = /\A((?<dest>#{DEST_PATTERN})\s*=\s*)?((?<comp>(#{COMP_A0_PATTERN})|(#{COMP_A1_PATTERN})))(\s*;\s*(?<jump>#{JUMP_PATTERN}))?\z/

  def command_type
    return nil if current_line.empty?
    @current_match = A_PATTERN.match(current_line) and return :a_command
    @current_match = C_PATTERN.match(current_line) and return :c_command
    @current_match = L_PATTERN.match(current_line) and return :l_command

    fail "Cannot parse line: #{current_line}"
  end

  def symbol
    current_match[:symbol]
  end

  def symbol_is_constant?
    symbol =~ CONSTANT_PATTERN
  end

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
