const std = @import("std");

pub fn write(file_name: []const u8, data: []const u8) !void {
    // Get the current working directory
    const cwd = std.fs.cwd();

    // Attempt to create or open the file (allowing errors)
    const file = try cwd.createFile(file_name, .{ .truncate = true });
    defer file.close();

    // Write data to the file (this can also fail, so propagate errors)
    try file.writer().writeAll(data);

    std.debug.print("Data written to {s}\n", .{file_name});
}