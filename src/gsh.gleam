import gleam/io
import gleam/erlang
import gleam/string
import gleam/int
import gleam_community/ansi

pub fn main() {
  let user_input: String = case
    erlang.get_line(
      ansi.green("user")
      <> "@"
      <> ansi.blue("gsh")
      <> ansi.red(" /home/")
      <> " >>> ",
    )
  {
    Ok(name) -> string.trim(name)
    Error(_) -> ""
  }

  let exit_code = case user_input {
    "ls" -> 0
    "clear" -> 0
    "exit" -> 0
    _ -> 1
  }

  let exit_string = case exit_code {
    0 -> ansi.green(int.to_string(exit_code))
    _ -> ansi.red(int.to_string(exit_code))
  }

  let loop = case user_input {
    "exit" -> False
    _ -> True
  }

  io.print(exit_string <> " ")

  case loop {
    True -> main()
    False -> io.println("")
  }
}