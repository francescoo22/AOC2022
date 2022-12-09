input = File.read!("../input.txt")

f = fn (acc, list, f) ->
    [a, b, c, d | _] = list
    temp_list = Enum.uniq [a, b, c, d]
    if Enum.count(temp_list) == 4 do
        acc
    else
        [_ | t] = list
        f.(acc + 1, t, f)
    end 
end

s = String.graphemes input
ans = f.(4, s, f)
IO.puts ans
