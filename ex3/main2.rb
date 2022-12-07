# frozen_string_literal: true

def get_priority char
  if char >= 'a' and char <= 'z'
    char.ord - 'a'.ord + 1
  elsif char >= 'A' and char <= 'Z'
    char.ord - 'A'.ord + 27
  else
    0
  end
end

file_path = 'input.txt'
file = File.open(file_path)
data = file.read.split("\n")

ans = 0

(0..data.length / 3 - 1).each do |i|
  back_pack = data[3 * i]
  back_pack.each_char do |char|
    back_pack.delete!(char) unless data[3 * i + 1].include?(char)
    back_pack.delete!(char) unless data[3 * i + 2].include?(char)
  end
  ans += get_priority back_pack[0]
end

puts ans