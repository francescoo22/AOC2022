def max_path adj_matrix, current_node, opened, rate, round, openable
  return 0 if round >= 30

  cur_max = 0
  openable.each do |node|
    next unless opened[node] == false

    opened[node] = true
    cur_rate = rate[node] * (30 - round - adj_matrix[current_node][node])
    temp = cur_rate + max_path(adj_matrix, node, opened, rate, round + adj_matrix[current_node][node] + 1, openable)
    cur_max = [cur_max, temp].max
    opened[node] = false
  end
  cur_max
end

start = Time.now
file_path = 'input.txt'
file = File.open(file_path)
data = file.read.split("\n")

node_to_int = { 'AA' => 0 }
map = {}
rate = { 0 => 0}
openable = []

v = 1
data.each do |line|
  words = line.split(' ')
  node = words[1]
  node_rate = words[4].tr('rate=;', '').to_i
  rate[v] = node_rate if node_rate > 0
  map[node] = []
  node_to_int[node] = v unless node == 'AA'
  openable << v unless node_rate == 0
  words[9..-1].each do |word|
    map[node] << word.tr(',', '')
  end
  v += 1 unless node == 'AA'
end

adj_matrix = Array.new(v) { Array.new(v, 9999) }

map.each do |node, neighbours|
  neighbours.each do |neighbour|
    adj_matrix[node_to_int[node]][node_to_int[neighbour]] = 1
  end
end

(0...v).each do |k|
  (0...v).each do |i|
    (0...v).each do |j|
      adj_matrix[i][j] = [adj_matrix[i][j], adj_matrix[i][k] + adj_matrix[k][j]].min
    end
  end
end

opened = Array.new(v, false)
puts max_path(adj_matrix, 0, opened, rate, 1, openable)
puts "Seconds: #{Time.now - start}"
