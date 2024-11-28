import error
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
  // Define a prompt string to print out
  let prompt: String =
    ansi.green("user")
    <> "@"
    <> ansi.cyan("gsh")
    <> ansi.yellow(" /home")
    <> " | "
    <> error_code
    <> " |> "

  // Get user input
  // Note: On windows the backspace key removes
  // words instead of characters
  let user_input: String = case erlang.get_line(prompt) {
    Ok(input) -> string.trim(input)
    Error(_) -> ""
  }

  // Get command from user input
  let command = case list.first(string.split(user_input, " ")) {
    Ok(item) -> item
    Error(_) -> ""
  }

  // Generate error codes
  let error_code: Int = case command {
    "ls" | "exit" -> 0
    _ -> 1
  }

  // Handle any errorsc
  case error_code {
    0 -> io.print("")
    _ -> error.handle_error(user_input, error_code)
  }

  // Cast the error code to a string then color it
  let internal_error_string: String = case error_code {
    0 -> ansi.green(int.to_string(error_code))
    _ -> ansi.red(int.to_string(error_code))
  }

  // Check if exit was called and
  // put the result into a boolean
  let continue_loop: Bool = case command {
    "exit" -> False
    _ -> True
  }

  // Check the boolean we declared above
  // and loop if it is true otherwise exit
  case continue_loop {
    True -> loop(internal_error_string)
    False -> io.println(internal_error_string)
    // count_down(error_code)
  }
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
