require_relative "symbol_table"
require_relative "parser"
require_relative "code"

class Assembler
  def assemble(input_path)
    output_path = input_path.gsub(/.asm\z/i, ".hack")
    input = File.open(input_path, "r")
    output = File.open(output_path, "w")

    symbol_table = analyze(input)
    input.rewind
    generate(input, output, symbol_table)

    input.close
    output.close
  end

  def analyze(input)
    symbol_table = SymbolTable.new
    rom_address = 0
    parser = Parser.new(input)
    while parser.has_more_commands?
      parser.advance
      case parser.command_type
      when :a_command, :c_command
        rom_address += 1

      when :l_command
        symbol_table.add(parser.symbol, rom_address)
      end
    end
    symbol_table
  end

  def generate(input, output, symbol_table)
    next_available_ram_address = 16
    code = Code.new
    parser = Parser.new(input)
    while parser.has_more_commands?
      parser.advance

      case parser.command_type
      when :a_command
        if parser.symbol_is_constant?
          address = parser.symbol.to_i

        elsif symbol_table.contains?(parser.symbol)
          address = symbol_table.address(parser.symbol)

        else
          address = next_available_ram_address
          symbol_table.add(parser.symbol, address)
          next_available_ram_address += 1
        end

        output.puts "%016b" % address

      when :c_command
        comp = code.comp(parser.comp)
        dest = code.dest(parser.dest)
        jump = code.jump(parser.jump)
        output.puts "111#{comp}#{dest}#{jump}"

      when :l_command
        # ignore
      end
    end
  end
end
