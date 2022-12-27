use std::fs;

fn main(){
    let file_string = fs::read_to_string("input.txt")
        .expect("Should have been able to read the file");
    
    let lines = file_string.split("\n")
        .collect::<Vec<&str>>();

    let mut max_x = 0;
    // let mut min_x = 
    let mut max_y = 0;
    for line in lines {
        
        let coords = line.split(" -> ")
            .collect::<Vec<&str>>();
        for coord in coords {

            let x = coord.split(",")
                .collect::<Vec<&str>>()[0]
                .parse::<i32>()
                .unwrap();
            let y = coord.split(",")
                .collect::<Vec<&str>>()[1]
                .parse::<i32>()
                .unwrap();

            println!("x: {}, y: {}", x, y);

            if x > max_x {
                max_x = x;
            }

            if y > max_y {
                max_y = y;
            }
        }
    }

    println!("Max x: {}, Max y: {}", max_x, max_y);
}