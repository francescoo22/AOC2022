def solve(p_solved, p_unsolved, _root)
  while p_solved[_root].nil?
    new_solved = {}
    p_solved.each do |key, value|
      p_unsolved.each do |key2, value2|
        value2[0] = value if value2[0] == key
        value2[2] = value if value2[2] == key
        next unless value2[0].is_a?(Integer) && value2[2].is_a?(Integer)

        new_solved[key2] = value2[0] + value2[2] if value2[1] == '+'
        new_solved[key2] = value2[0] - value2[2] if value2[1] == '-'
        new_solved[key2] = value2[0] * value2[2] if value2[1] == '*'
        new_solved[key2] = value2[0] / value2[2] if value2[1] == '/'
        p_unsolved.delete(key2)
      end
    end
    p_solved = p_solved.merge(new_solved)
    break if new_solved.empty?
  end
  p_solved
end

file_path = 'input.txt'
file = File.open(file_path)
data = file.read.split("\n")

solved = {}
unsolved = {}

data.each do |line|
  line = line.split(' ')
  key = line[0].tr(':', '')
  if key == 'humn'
    unsolved[key] = ['xxxx', '+', 'yyyy']
  else
    solved[key] = line[1].to_i if line.size == 2
    unsolved[key] = line[1..3] if line.size == 4
  end
end

solve(solved, unsolved, 'root')
puts solved

root = unsolved['root']
if root[0].is_a?(Integer)
  solved = { root[2] => root[0] }
  start = root[2]
else
  solved = { root[0] => root[2] }
  start = root[0]
end

new_unsolved = {}
opposite = { '+' => '-', '-' => '+', '*' => '/', '/' => '*' }
unsolved.each do |key, value|
  next if key == 'humn'

  if value[0].is_a?(Integer)
    new_unsolved[value[2]] = [key, opposite[value[1]], value[0]] if value[1] == '+' || value[1] == '*'
    new_unsolved[value[2]] = [value[0], value[1], key] if value[1] == '-' || value[1] == '/'
  else
    new_unsolved[value[0]] = [key, opposite[value[1]], value[2]]
  end
end

new_unsolved.delete(start)
solved = solve(solved, new_unsolved, 'humn')

puts solved['humn']