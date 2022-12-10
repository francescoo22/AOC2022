input = File.read!("../input.txt") |> String.split("\n") |> Enum.map(fn x -> String.split x, " " end) |> List.flatten

plus = fn i, acc ->
    if rem(i + 20, 40) == 0 do acc * i else 0 end
end

get_next_char = fn (i, acc) ->
    if acc-1 <= rem(i, 40) and rem(i, 40) <= acc+1 do "#" else "." end
end

print_ans = fn (ans, f) ->
    [h | t] = ans
    IO.puts h
    if t != [] do f.(t, f) end
end

get_ans1 = fn (acc, list, i, f) ->
    p = plus.(i, acc)

    if list == [] do p + f.(acc, list, i + 1, f) end

    if i <= 220 do
        [h | t] = list
        if h == "noop" || h == "addx" do
            p + f.(acc, t, i + 1, f)
        else
            p + f.(acc + String.to_integer(h), t, i + 1, f)
        end
    else
        p
    end
end

get_ans2 = fn (acc, list, i, f) ->

    if i < 240 do
        if list == [] do [get_next_char.(i, acc)] 
        else
            [h | t] = list
            next_char = get_next_char.(i, acc)

            add = if h == "noop" || h == "addx" do 0 else String.to_integer(h) end
            [h1 | t1] = f.(acc + add, t, i + 1, f)

            if rem(i + 1, 40) != 0 || i+1 == 240 do [next_char <> h1 | t1] 
            else [next_char, h1 | t1] end
        end
    else
        [""]
    end
end

ans = get_ans1.(1, input, 1, get_ans1)
ans2 = get_ans2.(1, input, 0, get_ans2)

IO.puts ans
print_ans.(ans2, print_ans)

# 16480
# PLEFULPB