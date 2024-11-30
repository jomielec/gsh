const std = @import("std");

pub fn main() !void {
    var file = try std.fs.cwd().openFile("current_dir.txt", .{});
    defer file.close();

    var reader = file.reader();
    var buf: [1024]u8 = undefined;
    var last_line: ?[]const u8 = null; // Use nullable type

    while (try reader.readUntilDelimiterOrEof(buf[0..], '\n')) |line| {
        last_line = line;
    }

    if (last_line != null) {
        try std.io.getStdOut().writer().print("{s}\n", .{last_line.?}); // Unwrap nullable type
    }
}