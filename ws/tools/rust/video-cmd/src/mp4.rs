use ffmpeg_next as ffmpeg;

pub fn read_mp4_metadata(filename: &str) {
    // TODO: init only once.
    ffmpeg::init().unwrap();

    match ffmpeg::format::input(&filename) {
        Ok(ctx) => {
            for (k, v) in ctx.metadata().iter() {
                println!("{}: {}", k, v);
            }
        }
        Err(err) => println!("error: {}", err),
    }
}
