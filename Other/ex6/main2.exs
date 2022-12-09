input = File.read!("../input.txt")

f = fn (acc, list, f) ->
    temp_list = Enum.uniq(Enum.take list, 14)
    if Enum.count(temp_list) == 14 do
        acc
    else
        [_ | t] = list
        f.(acc + 1, t, f)
    end 
end

s = String.graphemes input
ans = f.(14, s, f)
IO.puts ans


# level : "2"
# answer : "2263"