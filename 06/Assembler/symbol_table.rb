class SymbolTable
  PREDEFINED_SYMBOLS = {
    "R0" =>     0x0000,
    "R1" =>     0x0001,
    "R2" =>     0x0002,
    "R3" =>     0x0003,
    "R4" =>     0x0004,
    "R5" =>     0x0005,
    "R6" =>     0x0006,
    "R7" =>     0x0007,
    "R8" =>     0x0008,
    "R9" =>     0x0009,
    "R10" =>    0x000a,
    "R11" =>    0x000b,
    "R12" =>    0x000c,
    "R13" =>    0x000d,
    "R14" =>    0x000e,
    "R15" =>    0x000f,
    "SP" =>     0x0000,
    "LCL" =>    0x0001,
    "ARG" =>    0x0002,
    "THIS" =>   0x0003,
    "THAT" =>   0x0004,
    "SCREEN" => 0x4000,
    "KBD" =>    0x6000
  }

  def initialize
    @hash_table = {}
  end

  def add(symbol, address)
    fail "Symbol #{symbol} already in use" if contains?(symbol)
    @hash_table[symbol] = address
  end

  def contains?(symbol)
    address(symbol) != nil
  end

  def address(symbol)
    PREDEFINED_SYMBOLS[symbol] || @hash_table[symbol]
  end
end
