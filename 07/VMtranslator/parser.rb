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
  LABEL_PATTERN = /[a-zA-Z_:\.][0-9a-zA-Z_:\.]*/

  PATTERNS = {
    c_math:     /\A(?<command>add|sub|and|or|neg|not|eq|lt|gt)\z/,
    c_push:     /\A(?<command>push)\s+(?<arg1>#{SEGMENT_PATTERN})\s+(?<arg2>\d+)\z/,
    c_pop:      /\A(?<command>pop)\s+(?<arg1>#{SEGMENT_PATTERN})\s+(?<arg2>\d+)\z/,
    c_label:    /\A(?<command>label)\s+(?<arg1>#{LABEL_PATTERN})/,
    c_goto:     /\A(?<command>goto)\s+(?<arg1>#{LABEL_PATTERN})/,
    c_if:       /\A(?<command>if\-goto)\s+(?<arg1>#{LABEL_PATTERN})/,
    c_function: /\A(?<command>function)\s+(?<arg1>#{LABEL_PATTERN})\s+(?<arg2>\d+)\z/,
    c_call:     /\A(?<command>call)\s+(?<arg1>#{LABEL_PATTERN})\s+(?<arg2>\d+)\z/,
    c_return:   /\A(?<command>return)/,
  }

  def command_type
    return nil if current_line.empty?

    PATTERNS.each_pair do |type, pattern|
      @current_match = pattern.match(current_line) and return type
    end

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
