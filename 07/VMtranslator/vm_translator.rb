require_relative "parser"
require_relative "code_writer"

class VMTranslator
  def translate(input_path)
    if File.file?(input_path)
      translate_file(input_path)
    else
      translate_directory(input_path)
    end
  end

  def translate_directory(directory_path)
    output_path = directory_path + ".asm"
    code_writer = CodeWriter.new(output_path)
    code_writer.write_init
    Dir.glob("#{directory_path}/*.vm").each do |input_path|
      generate(input_path, code_writer)
    end
    code_writer.close
  end

  def translate_file(input_path)
    output_path = input_path.gsub(/.vm\z/i, ".asm")
    code_writer = CodeWriter.new(output_path)
    code_writer.write_init
    generate(input_path, code_writer)
    code_writer.close
  end

  def generate(input_path, code_writer)
    File.open(input_path, "r") do |input|
      parser = Parser.new(input)
      while parser.has_more_commands?
        parser.advance

        case parser.command_type
        when :c_math     then code_writer.write_math(parser.command)
        when :c_push     then code_writer.write_push(parser.arg1, parser.arg2)
        when :c_pop      then code_writer.write_pop(parser.arg1, parser.arg2)
        when :c_label    then code_writer.write_label(parser.arg1)
        when :c_goto     then code_writer.write_goto(parser.arg1)
        when :c_if       then code_writer.write_if(parser.arg1)
        when :c_function then code_writer.write_function(parser.arg1, parser.arg2)
        when :c_call     then code_writer.write_call(parser.arg1, parser.arg2)
        when :c_return   then code_writer.write_return

        when nil         then # ignore
        else
          puts "Unsupported: #{parser.current_line}"
        end
      end
    end
  end
end
