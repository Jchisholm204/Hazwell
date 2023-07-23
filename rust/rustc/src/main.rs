fn main() -> () { // main returns nothing
    println!("Hello, world!");
    print_labeled_measurement(32, 'h');
    println!("{}", plus_one(5));
    let x : i32 = if false {2} else { match "g".trim().parse() {Ok(num) => num, Err(_) => {println!("numErr\nDefaulting to 0"); 0}}};
    println!("{}", x);

    println!("Count Loop");
    for n in (1..4){
        println!("Count is: {}", n);
    }

}


fn print_labeled_measurement(value: i32, unit_label: char){
    println!("the measurement is: {value}{unit_label}");
}

fn plus_one(value: i32) -> i32 {
    value + 1
}