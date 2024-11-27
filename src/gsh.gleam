import gleam/erlang
import gleam/erlang/process
import gleam/int
import gleam/io
import gleam/string
import gleam_community/ansi

pub fn count_down(code) {
  io.print("Exiting in 3\r")
  process.sleep(1000)
  io.print("Exiting in 2\r")
  process.sleep(1000)
  io.print("Exiting in 1")
  process.sleep(1000)
  io.print("\nExited with code: ")
  io.debug(code)
}

pub fn main() {
  // Start the interactive loop with an initial exit code
  main_loop("0")
}

fn main_loop(exitcode: String) {
  let prompt =
    ansi.green("user")
    <> "@"
    <> ansi.blue("gsh")
    <> ansi.red(" /home/")
    <> " >| "
    <> exitcode
    <> " |> "

  let user_input = case erlang.get_line(prompt) {
    Ok(input) -> string.trim(input)
    Error(_) -> ""
  }

  let exit_code = case user_input {
    "ls" -> 0
    "clear" -> 0
    "exit" -> 0
    _ -> 1
  }

  let internal_exit_string = case exit_code {
    0 -> ansi.green(int.to_string(exit_code))
    _ -> ansi.red(int.to_string(exit_code))
  }

  let continue_loop = case user_input {
    "exit" -> False
    _ -> True
  }

  case continue_loop {
    True -> main_loop(internal_exit_string)
    False -> count_down(0)
  }
}
