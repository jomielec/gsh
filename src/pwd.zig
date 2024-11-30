const std = @import("std");

pub fn main() !void {
    const file = try std.fs.cwd().createFile(
        "junk_file.txt",
        .{ .read = true },
    );
    defer file.close();

    const bytes_written = try file.writeAll("Hello File!");
    _ = bytes_written;

    var buffer: [100]u8 = undefined;
    try file.seekTo(0);
    const bytes_read = try file.readAll(&buffer);
    
    //FIXME:
    try expect(eql(u8, buffer[0..bytes_read], "Hello File!"));
}
