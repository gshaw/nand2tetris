require_relative "vm_translator"
require "fileutils"

assember_path = File.expand_path("../../06/Assembler/Assembler")

[
  # File.expand_path("../StackArithmetic/SimpleAdd/SimpleAdd.vm"),
  # File.expand_path("../StackArithmetic/StackTest/StackTest.vm"),
  # File.expand_path("../MemoryAccess/BasicTest/BasicTest.vm"),
  # File.expand_path("../MemoryAccess/PointerTest/PointerTest.vm"),
  # File.expand_path("../MemoryAccess/StaticTest/StaticTest.vm"),

  File.expand_path("../../08/ProgramFlow/BasicLoop/BasicLoop.vm"),
  File.expand_path("../../08/ProgramFlow/FibonacciSeries/FibonacciSeries.vm"),
  File.expand_path("../../08/FunctionCalls/SimpleFunction/SimpleFunction.vm"),

].each do |vm_path|
  puts vm_path
  VMTranslator.new.translate(vm_path)

  asm_path = vm_path.gsub(/.vm\z/i, ".asm")
  asm_cmd = "#{assember_path} #{asm_path}"
  system(asm_cmd)
end
