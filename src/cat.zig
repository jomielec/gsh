const std = @import("std");

pub fn main() !void {
    // Open the file for reading
    var file = try std.fs.cwd().openFile("gsh.gleam", .{});
    defer file.close();

    // Create a buffered reader for the file
    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    // Buffer for reading lines
    var buf: [1024]u8 = undefined;

    // Count the total number of lines in the file
    var line_number: usize = 1;
    var total_lines: usize = 0;
    while (true) {
        const line = try in_stream.readUntilDelimiterOrEof(buf[0..], '\n');
        if (line == null) break;
        total_lines += 1;
    }

    // Close the file and re-open it to reset the stream position
    file.close(); // No need to use 'try' since it doesn't return an error

    // Reopen the file
    file = try std.fs.cwd().openFile("gsh.gleam", .{});
    buf_reader = std.io.bufferedReader(file.reader());
    in_stream = buf_reader.reader();

    // Read and print lines with line numbers
    while (true) {
        const line = try in_stream.readUntilDelimiterOrEof(buf[0..], '\n');
        if (line == null) break;
        try std.io.getStdOut().writer().print("{d}\t\u{2502} {s}\n", .{line_number, line.?}); // Use the specifier {?} to handle optional type
        line_number += 1; // Increment line number
    }
}