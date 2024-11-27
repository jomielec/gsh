import gleam/int
import color
import gleam/erlang
import gleam/io
import gleam/string

pub fn main() {
  let user_input: String = case
    erlang.get_line(
      color.color_text("user", color.green)
      <> "@"
      <> color.color_text("gsh", color.blue)
      <> color.color_text(" /home/", color.red)
      <> " >>> ",
    )
  {
    Ok(name) -> string.trim(name)
    Error(_) -> ""
  }

  let exit_code = case user_input {
    "ls" -> 0
    "exit" -> 0
    _ -> 1
  }

  let exit_string = case exit_code {
    0 -> color.color_text(int.to_string(exit_code), color.green)
    _ -> color.color_text(int.to_string(exit_code), color.red)
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
