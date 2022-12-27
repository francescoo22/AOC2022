use std::fs;

pub enum ListElement {
    Int(u8),
    List(Vec<ListElement>),
}

fn parse_string (s: &str) -> ListElement {
    let mut last_elem: ListElement = ListElement::List(Vec::new());
    let mut stack: Vec<ListElement> = Vec::new();
    let mut curr = String::from("");
    for c in s.chars() {
        if c == '[' {
            stack.push(ListElement::List(Vec::new()));
        }
        if c == ']' {
            if curr != "" {
                let le = stack.pop().unwrap();
                match le {
                    ListElement::List(mut l) => {
                        l.push(ListElement::Int(curr.parse().unwrap()));
                        stack.push(ListElement::List(l));
                    }
                    _ => panic!("Should not happen")
                }
                curr = String::from("");  
            }
            last_elem = stack.pop().unwrap();
            
        }
        if c >= '0' && c <= '9' {
            curr.push(c);
        }
        if c == ',' {
            let le = stack.pop().unwrap();
            match le {
                ListElement::List(mut l) => {
                    l.push(ListElement::Int(curr.parse().unwrap()));
                    stack.push(ListElement::List(l));
                }
                _ => panic!("Should not happen")
            }
            curr = String::from("");
        }
    }

    return last_elem;
}

fn printListElement(list: ListElement) -> () {
    match list {
        ListElement::Int(i) => print!("{},", i),
        ListElement::List(l) => {
            print!("[");
            for elem in l {
                printListElement(elem);
            }
            print!("]");
        }
    }
}

fn main(){
    // let file_string = fs::read_to_string("input.txt")
    //     .expect("Should have been able to read the file");
    
    // let lines = file_string.split("\n\n")
    //     .map(|s| s.split("\n").collect::<Vec<&str>>())
    //     .collect::<Vec<Vec<&str>>>();

    // for lists in lines {
    //     let first_list = lists[0];
    //     let second_list = lists[1];
    // }

    let s = "[1,1,3,1,1]";
    let parsed = parse_string(s);
    // printListElement(parsed);
}