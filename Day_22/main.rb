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

numbers.each_with_index do |number, index|
  i = 0
  while i < number
    puts current_position.to_s
    direction = directions[current_direction]
    next_position = current_position
    loop do
      next_position = [(next_position[0] + direction[0]) % height, (next_position[1] + direction[1]) % width]
      break unless map[next_position[0]][next_position[1]] == ' '
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
