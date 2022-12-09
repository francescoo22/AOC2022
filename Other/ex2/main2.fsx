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

let pair_value (a, b) =
    match b with
    | 0 -> 0 + (a + 2) % 3 + 1
    | 1 -> 3 + a + 1
    | 2 -> 6 + (a + 1) % 3 + 1
    | _ -> failwith "Invalid character"


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
