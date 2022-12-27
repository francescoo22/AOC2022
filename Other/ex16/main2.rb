# def max_path adj_matrix, current_node, elephant_node, opened, rate, round, round_elephant, openable
#   return 0 if round >= 30 #mettere anche elephant round
#
#   cur_max = 0
#   openable.each do |node|
#     next unless opened[node] == false
#     openable.each do |elephant|
#       next if elephant == node || opened[elephant] == true
#
#       opened[node] = true
#       opened[elephant] = true
#       cur_rate = rate[node] * (26 - round - adj_matrix[current_node][node]) # controllo che non sia < 0
#       el_curr_rate = rate[elephant] * (26 - round_elephant - adj_matrix[elephant_node][elephant]) # controllo che non sia < 0
#       temp = cur_rate + el_curr_rate +
#         max_path(adj_matrix, node, elephant, opened, rate, round + adj_matrix[current_node][node] + 1,
#                  round_elephant + adj_matrix[elephant_node][elephant] + 1, openable)
#       cur_max = [cur_max, temp].max
#       opened[node] = false
#       opened[elephant] = false
#     end
#   end
#   cur_max
# end

$all_perm = []
$all_pair_perm = []
def all_permutations round, adj_matrix, openable, opened, curr_node, perm
  $all_perm << perm
  openable.each do |node|
    next if opened[node] == true
    opened[node] = true
    if round + adj_matrix[curr_node][node] + 1 <= 26
      all_permutations round + adj_matrix[curr_node][node] + 1, adj_matrix, openable, opened, node, perm + [node]
    end
    opened[node] = false
  end
end

def all_permutations2 round, adj_matrix, openable, opened, curr_node, perm
  $all_pair_perm << perm
  openable.each do |node|
    next if opened[node] == true
    opened[node] = true
    if round + adj_matrix[curr_node][node] + 1 <= 26
      all_permutations2 round + adj_matrix[curr_node][node] + 1, adj_matrix, openable, opened, node, perm + [node]
    end
    opened[node] = false
  end
end

def cost perm, adj_matrix, rate
  round = 1
  cost = 0
  curr_node = 0
  perm.each do |node|
    cost += rate[node] * (26 - round - adj_matrix[curr_node][node])
    round += adj_matrix[curr_node][node] + 1
    curr_node = node
  end
  cost
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
all_permutations 1, adj_matrix, openable, opened, 0, []
# puts $all_perm.size
count = 0
max = 0

$all_perm.each do |perm|
  count += 1
  puts "#{count} -> #{max}" if count % 1000 == 0
  all_permutations2 1, adj_matrix, openable - perm, opened, 0, []

  $all_pair_perm.each do |pair_perm|
    cost = cost(perm, adj_matrix, rate) + cost(pair_perm, adj_matrix, rate)
    max = [max, cost].max
  end

  $all_pair_perm = []
end

puts "answer: #{max}"

puts "Seconds: #{Time.now - start}"
