ans = File.read!("../input.txt") 
    |> String.split("\n\n") 
    |> Enum.map(fn x -> String.split(x, "\n") end) 
    |> Enum.map(fn x -> Enum.map(x, fn y -> String.to_integer(y) end) end) 
    |> Enum.map(fn x -> Enum.sum(x) end) 
    |> Enum.max()

IO.puts ans