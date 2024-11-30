const std = @import("std");
const stdout_file = std.io.getStdOut().writer();
var bw = std.io.bufferedWriter(stdout_file);
const stdout = bw.writer();

const lines = 0;

pub fn main() !void {
    //Code to generate junk output
    // for (1..11) |i|{
    //     try stdout.print("{}\n", .{i});
    //     try bw.flush();
    // }
    std.time.sleep(1000000000);
    if (lines == 0) {
        try clear();
    } else {
        try clear_ln(lines);
    }
}

pub fn clear() !void {
    try stdout.print("\x1B[2J\x1B[H", .{});
    try bw.flush();
}

pub fn clear_ln(num: u32) !void {
    try stdout.print("\x1B[2K\x1B[{}A", .{num});
    try bw.flush();
}
