let filePath = "../input.txt"
let input = System.IO.File.ReadAllText filePath

let rec f acc x =
    match x with
    | [] -> [acc]
    | x :: xs -> if x = "" then acc :: f [] xs else f (x :: acc) xs

let ans = 
    input.Split('\n') |> 
    Array.toList |>
    f [] |>
    List.map (fun x -> List.map int x) |>
    List.map (fun x -> List.sum x) |>
    List.max

printfn "%A" ans