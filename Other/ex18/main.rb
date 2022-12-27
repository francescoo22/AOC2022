require 'set'

file_path = 'input.txt'
file = File.open(file_path)
data = file.read.split("\n")
coords = Set.new

data.each do |line|
  numbers = line.split(',').map(&:to_i)
  coords << numbers
end

ans = 0
coords.each do |coord|
  adj = [[0, 0, 1], [0, 0, -1], [0, 1, 0], [0, -1, 0], [1, 0, 0], [-1, 0, 0]]
  adj.each do |x, y, z|
    ans += 1 unless coords.include?([coord[0] + x, coord[1] + y, coord[2] + z])
  end
end

puts ans
