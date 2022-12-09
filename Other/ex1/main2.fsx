let filePath = "../input.txt"
let input = System.IO.File.ReadAllText filePath

let rec f acc x =
    match x with
    | [] -> [acc]
    | x :: xs -> if x = "" then acc :: f [] xs else f (x :: acc) xs

let rec sum_first_n n list =
    match list with
    | [] -> 0
    | x :: xs -> if n = 0 then 0 else x + sum_first_n (n - 1) xs

let ans = 
    input.Split('\n') |> 
    Array.toList |>
    f [] |>
    List.map (fun x -> List.map int x) |>
    List.map (fun x -> List.sum x) |>
    List.sort |>
    List.rev |>
    sum_first_n 3

printfn "%A" ans