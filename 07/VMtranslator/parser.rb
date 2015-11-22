class Parser
  attr_reader :current_line, :current_match, :input

  def initialize(input)
    @input = input
    @current_line = nil
  end

  def has_more_commands?
    !input.eof?
  end

  def advance
    @current_line = input.readline.strip.gsub(COMMENT_PATTERN, "").strip
  end

  COMMENT_PATTERN = %r{//.*\z}
  SEGMENT_PATTERN = /(argument|local|static|constant|this|that|pointer|temp)/

  MATH_PATTERN = /\A(?<command>add|sub|and|or|neg|not|eq|lt|gt)\z/
  PUSH_PATTERN = /\A(?<command>push)\s+(?<arg1>#{SEGMENT_PATTERN})\s+(?<arg2>\d+)\z/
  POP_PATTERN  = /\A(?<command>pop)\s+(?<arg1>#{SEGMENT_PATTERN})\s+(?<arg2>\d+)\z/

  def command_type
    return nil if current_line.empty?
    @current_match = MATH_PATTERN.match(current_line) and return :c_math
    @current_match = PUSH_PATTERN.match(current_line) and return :c_push
    @current_match = POP_PATTERN.match(current_line)  and return :c_pop

    fail "Cannot parse line: #{current_line}"
  end

  def command
    current_match[:command]
  end

  def arg1
    current_match[:arg1]
  end

  def arg2
    current_match[:arg2]
  end
end
