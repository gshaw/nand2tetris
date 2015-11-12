require_relative "parser"
require_relative "code_writer"

class VMTranslator
  def translate_file(input_path)
    File.open(input_path, "r") do |input|
      output_path = input_path.gsub(/.vm\z/i, ".asm")
      generate(input, output_path)
    end
  end

  def generate(input, output_path)
    code_writer = CodeWriter.new(output_path)
    parser = Parser.new(input)
    while parser.has_more_commands?
      parser.advance

      case parser.command_type
      when :c_math
        code_writer.write_math(parser.command)

      when :c_push, :c_pop
        code_writer.write_push_pop(parser.command, parser.arg1, parser.arg2)

      when nil
        # ignore

      else
        puts "Unsupported: #{parser.current_line}"
      end
    end
    code_writer.close
  end
end
