# frozen_string_literal: true

def manhattan(x1, y1, x2, y2)
  (x1 - x2).abs + (y1 - y2).abs
end

file_path = 'input.txt'
file = File.open(file_path)
data = file.read.split("\n")

max_coord = 4_000_000
pairs = []

(0..max_coord).each do |_|
  pairs.append([])
end


data.each do |line|
  words = line.split(' ')
  x1 = words[2].tr('x=,', '').to_i
  y1 = words[3].tr('y=:', '').to_i
  x2 = words[8].tr('x=,', '').to_i
  y2 = words[9].tr('y=', '').to_i

  dist = manhattan(x1, y1, x2, y2)
  y_from = [y1 - dist, 0].max
  y_to = [y1 + dist, max_coord].min
  (y_from..y_to).each do |i|
    delta = dist - (y1 - i).abs
    pairs[i] << [[x1 - delta, 0].max, [x1 + delta, max_coord].min] if delta.positive?
  end
end

pairs.each do |pair|
  pair.sort_by! { |pair| pair[0] }
end

i = 0
ans = []
pairs.each do |pair_line|
  max_curr = 0
  pair_line.each_cons(2) do |pair1, pair2|
    if pair1[1] + 1 < pair2[0] && max_curr + 1 < pair2[0]
      ans = [pair1[1] + 1, i]
      break
    end
    max_curr = [max_curr, pair1[1]].max
  end
  i += 1
end

puts (ans[0] * 4_000_000 + ans[1]).to_s
