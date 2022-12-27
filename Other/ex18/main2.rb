require 'set'

def dfs(mat, x, y, z)
  stack = [[x, y, z]]
  while stack.length.positive?
    x, y, z = stack.pop
    next if x.negative? || y.negative? || z.negative? || x >= mat.length || y >= mat[0].length || z >= mat[0][0].length
    next if (mat[x][y][z]).zero?

    mat[x][y][z] = 0
    stack << [x + 1, y, z]
    stack << [x - 1, y, z]
    stack << [x, y + 1, z]
    stack << [x, y - 1, z]
    stack << [x, y, z + 1]
    stack << [x, y, z - 1]
  end
end

file_path = 'input.txt'
file = File.open(file_path)
data = file.read.split("\n")
coords = Set.new

mat_size = 21
mat = Array.new(mat_size) { Array.new(mat_size) { Array.new(mat_size, -1) } }


max = 0
data.each do |line|
  numbers = line.split(',').map(&:to_i)
  max = [max, numbers[0], numbers[1], numbers[2]].max
  mat[numbers[0]][numbers[1]][numbers[2]] = 0
  coords << numbers
end

dfs(mat, 20,20,20)

ans = 0
adj = [[0, 0, 1], [0, 0, -1], [0, 1, 0], [0, -1, 0], [1, 0, 0], [-1, 0, 0]]
coords.each do |coord|
  adj.each do |x, y, z|
    unless mat[coord[0] + x][coord[1] + y][coord[2] + z] == -1 || coords.include?([coord[0] + x, coord[1] + y, coord[2] + z])
      ans += 1
    end
  end
end

puts ans