import gleam/int
import gleam/io
import gleam/list
import gleam/string
import gleam_community/ansi
import gleam_community/colour.{type Color}

pub fn handle_error(user_input: String, error_code: Int) {
  let command = case list.first(string.split(user_input, " ")) {
    Ok(item) -> item
    Error(_) -> ""
  }

  let error_message: String = case error_code {
    0 -> "ur mom"
    1 -> "Unknown Command"
    _ -> "Error " <> int.to_string(error_code)
  }

  io.println(generate_error_message(
    error_message,
    command,
    colour.red,
    colour.red,
  ))
}

fn generate_error_message(
  message: String,
  data: String,
  message_color: Color,
  data_color: Color,
) -> String {
  let message_length = string.length(message)
  let data_length = string.length(data)

  let length: Int = case message_length >= data_length {
    True -> message_length
    False -> data_length
  }

  "\u{256D}"
  <> ansi.color(message, message_color)
  <> string.pad_end("", to: length - message_length, with: "\u{2500}")
  <> "\u{256E}\n\u{2502}"
  <> ansi.underline(ansi.color(data, data_color))
  <> string.pad_end("", to: length - data_length, with: " ")
  <> "\u{2502}\n\u{2570}"
  <> string.pad_end("", to: length, with: "\u{2500}")
  <> "\u{256F}"
}
