require_relative "assembler"
require "fileutils"

[
  ["../add", "Add.asm"],
  ["../max", "Max.asm"],
  ["../rect", "Rect.asm"],
  ["../pong", "Pong.asm"]
].each do |pair|
  dir_path, asm_path = pair
  FileUtils.cd(dir_path)
  Assembler.new.assemble(asm_path)

  hack_path = asm_path.gsub(/.asm\z/i, ".hack")
  backup_path = hack_path.gsub(/.hack\z/i, ".test.hack")
  `mv #{hack_path} #{backup_path}`

  `../../../tools/Assembler.sh #{asm_path}`

  puts "#{asm_path}"
  puts `cmp #{hack_path} #{backup_path}`
end
