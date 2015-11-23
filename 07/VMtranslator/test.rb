require_relative "vm_translator"
require "fileutils"

ASSEMBLER_PATH = File.expand_path("../../06/Assembler/Assembler")

def translate(vm_path, bootstrap:)
  puts vm_path
  asm_path = VMTranslator.new.translate(vm_path, bootstrap: bootstrap)
  asm_cmd = "#{ASSEMBLER_PATH} #{asm_path}"
  system(asm_cmd)
end

NON_BOOTSTRAP_MODULES = [
  File.expand_path("../../07/StackArithmetic/SimpleAdd/SimpleAdd.vm"),
  File.expand_path("../../07/StackArithmetic/StackTest/StackTest.vm"),
  File.expand_path("../../07/MemoryAccess/BasicTest/BasicTest.vm"),
  File.expand_path("../../07/MemoryAccess/PointerTest/PointerTest.vm"),
  File.expand_path("../../07/MemoryAccess/StaticTest/StaticTest.vm"),

  File.expand_path("../../08/ProgramFlow/BasicLoop/BasicLoop.vm"),
  File.expand_path("../../08/ProgramFlow/FibonacciSeries/FibonacciSeries.vm"),
  File.expand_path("../../08/FunctionCalls/SimpleFunction/SimpleFunction.vm"),
  File.expand_path("../../08/FunctionCalls/NestedCall"),
].each { |vm_path| translate(vm_path, bootstrap: false) }

BOOTSTRAP_MODULES = [
  File.expand_path("../../08/FunctionCalls/FibonacciElement"),
  # File.expand_path("../../08/FunctionCalls/StaticsTest"),
].each { |vm_path| translate(vm_path, bootstrap: true) }
