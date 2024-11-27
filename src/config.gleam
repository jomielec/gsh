import file_streams/file_stream
import tom

fn read_config(filename: String) {
  let assert Ok(file) = file_stream.open_read(filename)
  // let assert Ok(length) = file_stream.position(file, file_stream.EndOfFile(0)) // sets position not gets it
  // TODO get lenght of file
  let assert Ok(text) = file_stream.read_chars(file, 0)
  let assert Ok(parsed) = tom.parse(text)
  parsed
}
