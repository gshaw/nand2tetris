Nand = 1
Not = Nand
And = Nand + Not
Or = Not + And
Xor = Nand + Or + And
Nand16 = Nand*16
Not16 = Nand16
And16 = Nand16*2
Or16 = Not16*3 + And16
Mux16 = Not + And16*2 + Or16
Or8Way = Or*8
Or16Way = Or8Way*2 + Or
HalfAdder = Xor + And
FullAdder = Or + HalfAdder*2
Add16 = FullAdder*16
Inc16 = Add16
ALU = Add16 + And16 + Mux16*16 + Not + Not16*3 + Or16Way
Mux = Not + And*2 + Or
DFF = Nand*8 + Not
Bit = Mux + DFF
Register = Bit*16
Mux4Way16 = Not*2 + And*4 + And16*4 + Or16*3
DMux = Not + And*2
DMux4Way = Not + And*2 + DMux*2
DMux8Way = DMux + DMux4Way*2
PC = Or*2 + Not*2 + And + Inc16 + Mux4Way16 + Register
Mux8Way16 = Mux16*7
RAM8 = DMux8Way + Mux8Way16 + Register*8
RAM64 = DMux8Way + Mux8Way16 + RAM8*8
RAM512 = DMux8Way + Mux8Way16 + RAM64*8
RAM4K = DMux8Way + Mux8Way16 + RAM512*8
RAM16K = DMux4Way + Mux4Way16 + RAM4K*4

Keyboard = Register
Screen = RAM4K*2
Memory = DMux4Way + Or*5 + RAM16K

Mux8Way = Mux*8
CPU = ALU + And*4 + Mux16 + Mux8Way + Not + Or + PC + Register

puts "ALU: #{ALU}"
puts "CPU: #{CPU}"
puts "RAM4K: #{RAM4K}"
puts "Memory: #{Memory}"

# ALU: 2756
# CPU: 4213
# RAM4K: 1728362
# Memory: 6913871
