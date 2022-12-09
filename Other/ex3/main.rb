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
data.each do |line|
  first_half = line[0..(line.length / 2 - 1)]
  second_half = line[(line.length / 2)..-1]
  first_half.each_char do |char|
    first_half.delete!(char) unless second_half.include?(char)
  end
  ans += get_priority first_half[0]
end

puts ans