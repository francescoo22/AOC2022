let filePath = "../input.txt"
let input = System.IO.File.ReadAllText filePath

let char_to_int c =
    match c with
    | 'A' -> 0
    | 'B' -> 1
    | 'C' -> 2
    | 'X' -> 0
    | 'Y' -> 1
    | 'Z' -> 2
    | _ -> failwith "Invalid character"

let list_to_pair l =
    match l with
    | [ a; b ] -> (a, b)
    | _ -> failwith "Invalid list"

let pair_value (a, b) = b + 1 + ((b - a + 4) % 3) * 3

let ans =
    input.Split('\n')
    |> Array.toList
    |> List.map (fun x ->
        x.Split(' ')
        |> Array.toList
        |> List.map char
        |> List.map char_to_int
        |> list_to_pair
        |> pair_value)
    |> List.sum

printfn "%A" ans
