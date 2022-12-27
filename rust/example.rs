use std::fs;

fn main(){
    let input = fs::read_to_string("input.txt")
        .expect("Should have been able to read the file");
    
    let split = input.split("\n\n")
        .map(|s| s.split("\n")
        .collect::<Vec<&str>>())
        .collect::<Vec<Vec<&str>>>();

    let mut ans = 0;
    for s in split {
        let mut temp_ans = 0;
        for i in s {
            temp_ans += i.parse::<i32>().unwrap();
        }
        if temp_ans > ans {
            ans = temp_ans;
        }
    }
    println!("{}", ans);
}