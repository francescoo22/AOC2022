# frozen_string_literal: true

def manhattan(x1, y1, x2, y2)
  (x1 - x2).abs + (y1 - y2).abs
end

file_path = 'input.txt'
file = File.open(file_path)
data = file.read.split("\n")

ans_line = 2_000_000
pairs = []
beacons_at_line = []

data.each do |line|
  words = line.split(' ')
  x1 = words[2].tr('x=,', '').to_i
  y1 = words[3].tr('y=:', '').to_i
  x2 = words[8].tr('x=,', '').to_i
  y2 = words[9].tr('y=', '').to_i

  beacons_at_line << x2 if y2 == ans_line

  dist = manhattan(x1, y1, x2, y2)
  delta = dist - (y1 - ans_line).abs
  pairs << [x1 - delta, x1 + delta] if delta > 0
end

pairs.sort_by! { |pair| pair[0] }
ans = 0
pairs.each_cons(2) do |pair1, pair2|
  ans += if pair1[1] < pair2[0]
           pair1[1] - pair1[0] + 1
         else
           pair2[0] - pair1[0]
         end
end
ans += pairs[-1][1] - pairs[-1][0] + 1

puts ans - beacons_at_line.uniq.length
