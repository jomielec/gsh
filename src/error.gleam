import gleam/io
import gleam/string
import gleam_community/ansi
import gleam_community/colour.{type Color}

pub type Error {
  InvalidCommand
  UnknownError
  BlankCommand
}

pub fn handle_error(command: String, error_code: Int) {
  // Handle error codes
  let error_type: Error = case error_code {
    2 -> BlankCommand
    1 -> InvalidCommand
    _ -> UnknownError
  }

  let error_message = case error_type {
    InvalidCommand -> "Invalid Command"
    UnknownError -> "Unknown Error"
    BlankCommand -> "Blank Command"
  }
  let command = case command {
    "" -> "newline char"
    _ -> command
  }
  // Generate and print error message
  io.println(generate_error_message(
    error_message,
    command,
    colour.red,
    colour.red,
    1,
  ))
}

fn generate_error_message(
  message: String,
  data: String,
  message_color: Color,
  data_color: Color,
  theme: Int,
) -> String {
  // Get lengths of message and data
  let message_length = string.length(message)
  let data_length = string.length(data)

  // Get larger length
  let length: Int = case message_length >= data_length {
    True -> message_length
    False -> data_length
  }

  // Set themes

  // Modern theme
  let modern_theme =
    "\u{256D} "
    <> ansi.color(message, message_color)
    <> " "
    <> string.pad_end("", to: length - message_length, with: "\u{2500}")
    <> "\u{256E}\n\u{2502} "
    <> ansi.underline(ansi.color(data, data_color))
    <> string.pad_end("", to: length - data_length, with: " ")
    <> " \u{2502}\n\u{2570}"
    <> string.pad_end("", to: length + 2, with: "\u{2500}")
    <> "\u{256F}"

  // Classic theme
  let classic_theme =
    ansi.color(string.lowercase(message), message_color)
    <> ": "
    <> ansi.color(string.lowercase(data), message_color)

  // Select theme and return finished message
  case theme {
    1 -> modern_theme
    _ -> classic_theme
  }
}
