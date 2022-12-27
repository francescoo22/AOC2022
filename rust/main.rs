use std::fs;

pub enum ListElement {
    Int(u8),
    List(Vec<ListElement>),
}

fn parse_string (s: str) -> ListElement {
    let c = s.chars().next().unwrap();
}

fn main(){
    let file_string = fs::read_to_string("input.txt")
        .expect("Should have been able to read the file");
    
    let lines = file_string.split("\n").collect::<Vec<&str>>();

    for line in lines {
        println!("{}", line);
    }
}