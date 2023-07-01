use std::fmt;

use clap::Parser;

#[derive(Parser)]
pub struct Cli {
    pub subcommand: String,
    pub subargs: Vec<String>,
}

impl Cli {
    // just to call Parser::parse from external
    pub fn parse_args() -> Self {
        Self::parse()
    }
}


impl fmt::Display for Cli {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "subcommand: {}, subargs: {:?}", self.subcommand, self.subargs)
    }
}
