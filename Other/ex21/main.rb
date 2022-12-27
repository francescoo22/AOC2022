file_path = 'input.txt'
file = File.open(file_path)
data = file.read.split("\n")

solved = {}
unsolved = {}

data.each do |line|
  line = line.split(' ')
  key = line[0].tr(':', '')
  solved[key] = line[1].to_i if line.size == 2
  unsolved[key] = line[1..3] if line.size == 4
end

while solved['root'].nil?
  new_solved = {}
  solved.each do |key, value|
    unsolved.each do |key2, value2|
      value2[0] = value if value2[0] == key
      value2[2] = value if value2[2] == key
      next unless value2[0].is_a?(Integer) && value2[2].is_a?(Integer)

      new_solved[key2] = value2[0] + value2[2] if value2[1] == '+'
      new_solved[key2] = value2[0] - value2[2] if value2[1] == '-'
      new_solved[key2] = value2[0] * value2[2] if value2[1] == '*'
      new_solved[key2] = value2[0] / value2[2] if value2[1] == '/'
      unsolved.delete(key2)
    end
  end
  solved = new_solved
end

puts solved['root']
