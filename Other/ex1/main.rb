file_path = '../input.txt'
file = File.open(file_path)
data = file.read.split("\n\n")

ans = 0
data.each do |x|
  calories = x.split("\n").map(&:to_i).sum
  ans = calories > ans ? calories : ans
end

puts ans