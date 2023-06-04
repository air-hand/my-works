mod cli;

// Sample: cargo run foo bar baz
fn main() {
    // parse the arguments
    let args: cli::Cli = cli::Cli::parse_args();
    println!("arg: {}", args);
    println!("Hello, world!");
}
