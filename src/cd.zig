// const std = @import("std");
// const file = @import("files.zig");

// pub fn main() !void {
//     const cwd = std.fs.cwd();
//     const dir_name = "Test/User";

//     const result = cwd.openDir(dir_name, .{});

//     // Check if an error occurred
//     if (result) |dir| {
//         // Mutable reference to the directory to allow defer close
//         var mutable_dir = dir;
//         defer mutable_dir.close(); // Now can use defer on a mutable reference
//         std.debug.print("Directory exists: {s}\n", .{dir_name});

//         //Write the new current directory to directory storage file
//         //FIXME: This line throws error:
//         file.write("current_dir.txt", dir_name);
//     } else |err| {
//         // Handle error if directory is not found
//         switch (err) {
//             error.FileNotFound => std.debug.print("Error: Directory not found: {s}\n", .{dir_name}),
//             else => std.debug.print("An unexpected error occurred: {}\n", .{err}),
//         }
//     }
// }

const std = @import("std");
const file = @import("files.zig");

pub fn main() !void {
    const cwd = std.fs.cwd();
    const dir_name = getArgs()[1];

    const result = cwd.openDir(dir_name, .{});

    // Check if an error occurred
    if (result) |dir| {
        // Mutable reference to the directory to allow defer close
        var mutable_dir = dir;
        defer mutable_dir.close(); // Now can use defer on a mutable reference
        std.debug.print("Directory exists: {s}\n", .{dir_name});

        // Write the new current directory to directory storage file
        try file.write("current_dir.txt", dir_name); // Use try directly here without assigning to a variable
    } else |err| {
        // Handle error if directory is not found
        switch (err) {
            error.FileNotFound => std.debug.print("Error: Directory not found: {s}\n", .{dir_name}),
            else => std.debug.print("An unexpected error occurred: {}\n", .{err}),
        }
    }
}

pub fn getArgs() []const []const u8 {
    const allocator = std.heap.page_allocator;
    const args = std.process.argsAlloc(allocator) catch {
        std.debug.print("Error: Failed to retrieve arguments\n", .{});
        return &[_][]const u8{};
    };

    return args;
}