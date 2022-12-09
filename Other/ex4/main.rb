# frozen_string_literal: true
#
file_path = 'input.txt'
file = File.open(file_path)
data = file.read.split("\n")
ans = 0
data.each do |line|
  line = line.split(',')
  first = line[0].split('-').map(&:to_i)
  second = line[1].split('-').map(&:to_i)
  ans += 1 if (first[0] >= second[0] && first[1] <= second[1]) || (first[0] <= second[0] && first[1] >= second[1])
end
puts ans
