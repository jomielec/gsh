const std = @import("std");

pub fn main() !void {
    const cwd = std.fs.cwd(); // Get the current working directory

    // TODO pass argumants
    var dir = try cwd.openDir(); // Open the directory
    defer dir.close();

    var iterator = try dir.iterate();
    while (iterator.next()) |entry| {
        std.debug.print("{}\n", .{entry.name}); // Print the name of each entry
    }
}