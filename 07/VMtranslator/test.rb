require_relative "vm_translator"
require "fileutils"

assember_path = File.expand_path("../../06/Assembler/Assembler")

[
  File.expand_path("../StackArithmetic/SimpleAdd/SimpleAdd.vm"),
  File.expand_path("../StackArithmetic/StackTest/StackTest.vm"),
  # ["../MemoryAccess/BasicTest", "BasicTest.vm"],
].each do |vm_path|
  puts vm_path
  VMTranslator.new.translate_file(vm_path)

  asm_path = vm_path.gsub(/.vm\z/i, ".asm")
  asm_cmd = "#{assember_path} #{asm_path}"
  system(asm_cmd)
end
