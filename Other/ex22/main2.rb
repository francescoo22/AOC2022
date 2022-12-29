# frozen_string_literal: true

file_path = 'input.txt'
file = File.open(file_path)
data = file.read
map = data.split("\n\n")[0].split("\n")
path = data.split("\n\n")[1]

numbers = path.split(/[RL]/).map(&:to_i)

moves = path.split(/\d+/).filter { |move| move != '' }

directions = [[0, 1], [1, 0], [0, -1], [-1, 0]]
current_direction = 0

current_position = []

map[0].each_char.with_index do |char, index|
  if char == '.'
    current_position = [0, index]
    break
  end
end

max_row = 0
map.each do |row|
  max_row = [max_row, row.length].max
end

map.each do |row|
  row << ' ' * (max_row - row.length)
end

width = map[0].length
height = map.length

edges = {}

(50..99).each do |y|
  edges[[y, 99, '>']] = [49, y + 50, '^']
  edges[[49, y + 50, 'v']] = [y, 99, '<']
end

(150..199).each do |y|
  edges[[y, 49, '>']] = [149, y - 100, '^']
  edges[[149, y - 100, 'v']] = [y, 49, '<']

  edges[[y, 0, '<']] = [0, y - 100, 'v']
  edges[[0, y - 100, '^']] = [y, 0, '>']
end

(0..49).each do |y|
  edges[[100, y, '^']] = [y + 50, 50, '>']
  edges[[y + 50, 50, '<']] = [100, y, 'v']

  edges[[y, 149, '>']] = [149 - y, 99, '<']
  edges[[149 - y, 99, '>']] = [y, 149, '<']

  edges[[y, 50, '<']] = [149 - y, 0, '>']
  edges[[149 - y, 0, '<']] = [y, 50, '>']
end

(100..149).each do |y|
  edges[[0, y, '^']] = [199, y - 100, '^']
  edges[[199, y - 100, 'v']] = [0, y, 'v']
end

dir_to_char = { [0, 1] => '>', [1, 0] => 'v', [0, -1] => '<', [-1, 0] => '^' }
char_to_int = { '>' => 0, 'v' => 1, '<' => 2, '^' => 3 }

numbers.each_with_index do |number, index|
  i = 0
  while i < number
    direction = directions[current_direction]
    next_position = current_position

    if edges[[current_position[0], current_position[1], dir_to_char[direction]]].nil?
      next_position = [(next_position[0] + direction[0]) % height, (next_position[1] + direction[1]) % width]
    else
      edge = edges[[current_position[0], current_position[1], dir_to_char[direction]]]
      next_position = [edge[0], edge[1]]
      current_direction = char_to_int[edge[2]] unless map[next_position[0]][next_position[1]] == '#'
    end

    break if map[next_position[0]][next_position[1]] == '#'

    current_position = next_position
    i += 1
  end
  current_direction = (current_direction + 1) % 4 if moves[index] == 'R'
  current_direction = (current_direction - 1) % 4 if moves[index] == 'L'
end

puts "final position #{current_position}"
final_row = current_position[0] + 1
final_column = current_position[1] + 1

password = 1000 * final_row + 4 * final_column + current_direction
puts "password: #{password}"
