file_path = '../input.txt'
file = File.open(file_path)
data = file.read.split("\n\n")

ans = []
data.each do |x|
  calories = x.split("\n").map(&:to_i).sum
  ans.append calories
end
ans = ans.sort
puts ans[-3..-1].sum