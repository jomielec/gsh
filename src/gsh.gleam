import gleam/erlang
import gleam/erlang/process
import gleam/int
import gleam/io
import gleam/list
import gleam/string
import gleam_community/ansi

pub fn main() {
  // Start the interactive loop with an initial exit code
  loop(ansi.green("0"))
}

fn loop(error_code: String) {
  let prompt: String =
    ansi.green("user")
    <> "@"
    <> ansi.cyan("gsh")
    <> ansi.yellow(" /home/")
    <> " | "
    <> error_code
    <> " |> "

  let user_input: String = case erlang.get_line(prompt) {
    Ok(input) -> string.trim(input)
    Error(_) -> ""
  }

  let error_code: Int = case user_input {
    "" -> 2
    "ls" -> 0
    "exit" -> 0
    _ -> 1
  }

  case error_code {
    0 -> io.print("")
    _ -> generate_error(user_input, error_code)
  }

  let internal_exit_string: String = case error_code {
    0 -> ansi.green(int.to_string(error_code))
    _ -> ansi.red(int.to_string(error_code))
  }

  let continue_loop: Bool = case user_input {
    "exit" -> False
    _ -> True
  }

  case continue_loop {
    True -> loop(internal_exit_string)
    False -> io.println("")
    // count_down(error_code)
  }
}

// Custom functions
pub fn generate_error(user_input: String, error_code: Int) {
  let command = case list.first(string.split(user_input, " ")) {
    Ok(item) -> item
    Error(_) -> ""
  }

  let error_message: String = case error_code {
    0 -> "ur mom"
    1 -> "Unknown Command"
    _ -> "Error " <> int.to_string(error_code)
  }
  io.println("\u{256D} " <> ansi.red(error_message) <> " \u{256E}")
  io.println(
    "\u{254E} |> "
    <> string.pad_end(command, string.length(error_message), " ")
    <> "\u{254E}",
  )
  io.println(ansi.red("     \u{2500}\u{2500}\u{2500}\u{2500}"))
}

pub fn count_down(error_code: Int) {
  io.print(ansi.cyan("Exiting in 3\r"))
  process.sleep(1000)
  io.print(ansi.cyan("Exiting in 2\r"))
  process.sleep(1000)
  io.print(ansi.cyan("Exiting in 1\r"))
  process.sleep(1000)
  case error_code {
    0 ->
      io.println(ansi.green("Exited with code: " <> int.to_string(error_code)))
    _ -> io.println(ansi.red("Exited with code: " <> int.to_string(error_code)))
  }
}
