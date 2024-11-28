// If all fails, revert to this:
const std = @import("std");

pub fn main() !void {
    const cwd = std.fs.cwd(); // Get the current working directory

    // Open the current directory explicitly with "."
    var dir = try cwd.openDir("./", .{});
    defer dir.close();

    var iterator = dir.iterate(); // Get the iterator
    while (true) {
        const entry = try iterator.next();
        if (entry == null) break; // Exit loop if no more entries

        std.debug.print("\x1b[32m{s}\n", .{entry.?.name}); // Use {s} to format the name slice
    }
}