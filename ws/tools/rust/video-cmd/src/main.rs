mod cli;
mod mp4;

// Sample: cargo run foo bar baz
fn main() {
    // parse the arguments
    let args: cli::Cli = cli::Cli::parse_args();
    println!("arg: {}", args);
    println!("Hello, world!");

    // read the mp4 metadata
    mp4::read_mp4_metadata(args.subcommand.as_str());
}
