def print_shape(shape)
  (-5..0).each do |i|
    (0..5).each do |j|
      if shape.include?([i, j])
        print "#"
        STDOUT.flush
      else
        print "."
        STDOUT.flush
      end
    end
    puts
  end
end

def print_map(map)
  map.each do |line|
    puts line
  end
end

file_path = 'input.txt'
file = File.open(file_path)
jets = file.read

minus = [[0, 2], [0, 3], [0, 4], [0, 5]]
plus = [[-2, 3], [-1, 2], [-1, 3], [-1, 4], [0, 3]]
elle = [[-2, 4], [-1, 4], [0, 2], [0, 3], [0, 4]]
longi = [[-3, 2], [-2, 2], [-1, 2], [0, 2]]
square = [[-1, 2], [-1, 3], [0, 2], [0, 3]]
shapes = [minus, plus, elle, longi, square]

curr_jet = 0
map = []

# shapes.each do |shape|
#   print_shape(shape)
#   puts
# end

BLOCKS_NUMBER = 2022

(0..BLOCKS_NUMBER - 1).each do |i|
  map = ['.......', '.......', '.......', '.......'].concat(map)
  # curr_shape = shapes[i % 5].dup
  curr_shape = []
  shapes[i % 5].each do |point|
    curr_shape << [point[0], point[1]]
  end
  move_down = true
  while move_down
    move_side = true
    shift = jets[curr_jet % jets.length] == '>' ? 1 : -1

    curr_shape.each do |point|
      move_side = false if point[1] == 3 * (1 + shift) # brutto ma ok
      move_side = false if point[0] >= 0 && map[point[0]][point[1] + shift] == '#'
    end
    if move_side
      curr_shape.each do |point|
        point[1] += shift
      end
    end

    curr_jet += 1

    curr_shape.each do |point|
      if point[0] == map.size - 1
        move_down = false
        break
      end
      if point[0] >= 0 && map[point[0] + 1][point[1]] == '#' # sistema il >= 0
        move_down = false
        break
      end
    end
    next unless move_down

    curr_shape.each do |point|
      point[0] += 1
    end
  end

  curr_shape.each do |point|
    map[point[0]][point[1]] = '#'
  end

  map.shift while map[0] == '.......'

  puts map.size if i == 2010

  # print_map(map)
  # puts '--------------------------------------'
  # puts map[0] if (i % 5).zero?
  # puts curr_jet % jets.length if (i % 5).zero?
end

# puts map
puts map.size
