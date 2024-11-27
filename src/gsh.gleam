import gleam/erlang
import gleam/erlang/process
import gleam/int
import gleam/io
import gleam/string
import gleam_community/ansi

pub fn count_down(exit_code: Int) {
  io.print(ansi.cyan("Exiting in 3\r"))
  process.sleep(1000)
  io.print(ansi.cyan("Exiting in 2\r"))
  process.sleep(1000)
  io.print(ansi.cyan("Exiting in 1\r"))
  process.sleep(1000)
  case exit_code {
    0 ->
      io.println(ansi.green("Exited with code: " <> int.to_string(exit_code)))
    _ -> io.println(ansi.red("Exited with code: " <> int.to_string(exit_code)))
  }
}

pub fn main() {
  // Start the interactive loop with an initial exit code
  main_loop(ansi.green("0"))
}

fn main_loop(exit_code: String) {
  let prompt =
    ansi.green("user")
    <> "@"
    <> ansi.cyan("gsh")
    <> ansi.red(" /home/")
    <> " >| "
    <> exit_code
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
    False -> count_down(exit_code)
  }
}
