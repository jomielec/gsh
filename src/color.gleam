// ANSI COLOR CODES
pub const reset = "\u{001b}[0m"
pub const black = "\u{001b}[30m"
pub const red = "\u{001b}[31m"
pub const green = "\u{001b}[32m"
pub const yellow = "\u{001b}[33m"
pub const blue = "\u{001b}[34m"
pub const magenta = "\u{001b}[35m"
pub const cyan = "\u{001b}[36m"
pub const white = "\u{001b}[37m"

// BACKGROUND COLORS
pub const bg_black = "\u{001b}[40m"
pub const bg_red = "\u{001b}[41m"
pub const bg_green = "\u{001b}[42m"
pub const bg_yellow = "\u{001b}[43m"
pub const bg_blue = "\u{001b}[44m"
pub const bg_magenta = "\u{001b}[45m"
pub const bg_cyan = "\u{001b}[46m"
pub const bg_white = "\u{001b}[47m"

pub fn color_text(text: String, color: String) -> String {
  color <> text <> reset
}