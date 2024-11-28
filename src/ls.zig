//Version 1
// const std = @import("std");
// const ArrayList = std.ArrayList;

// pub fn main() !void {
//     const cwd = std.fs.cwd(); // Get the current working directory
//     var directories = ArrayList([]const u8).init(std.heap.page_allocator);

//     // Open the current directory explicitly with "."
//     var dir = try cwd.openDir("./", .{});
//     defer dir.close();

//     var iterator = dir.iterate(); // Get the iterator

//     std.debug.print("\u{256D}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\n\u{2502} Name:\n\u{251C}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\n", .{});
//     while (true) {
//         const entry = try iterator.next();
//         if (entry == null) break; // Exit loop if no more entries

//         try directories.append(entry.?.name); // Append the directory name
//     }

//     // Print each directory in the list
//     for (directories.items) |item| {
//         std.debug.print("\u{2502} \x1b[32m{s}\x1b[0m\u{2502}\n", .{item});
//     }
// }

// Version 2
const std = @import("std");
const ArrayList = std.ArrayList;
const Allocator = std.heap.page_allocator;
const green = "\x1b[32m";
const reset = "\x1b[0m";

fn max(a: usize, b: usize) usize {
    if (a > b) {
        return a;
    } else {
        return b;
    }
}

pub fn main() !void {
    const cwd = std.fs.cwd(); // Get the current working directory
    var directories = ArrayList([]const u8).init(Allocator);

    // Open the current directory explicitly with "."
    var dir = try cwd.openDir("./", .{});
    defer dir.close();

    var iterator = dir.iterate(); // Get the iterator

    // Print the top of the table
    std.debug.print("\u{256D}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{256e}\n\u{2502} Name:         \u{2502}\n\u{251C}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2524}\n", .{});

    // Collect directory names
    while (true) {
        const entry = try iterator.next();
        if (entry == null) break; // Exit loop if no more entries

        try directories.append(entry.?.name); // Append the directory name
    }

    // Find the maximum length of the directory names to properly align the table
    var max_len: usize = 0;
    for (directories.items) |item| {
        max_len = max(max_len, item.len);
    }

    // Print each directory name
    for (directories.items) |item| {
        const spaces_needed = max_len - item.len;

        // Dynamically allocate memory for spaces
        var spaces = try Allocator.alloc(u8, spaces_needed);
        defer Allocator.free(spaces);

        // Fill the spaces array with ' ' (spaces_needed times)
        for (0..spaces_needed) |i| {
            spaces[i] = ' ';
        }

        // Print directory name with spaces for alignment
        std.debug.print("\u{2502} \x1b[32m{s}\x1b[0m{s} \u{2502}\n", .{ item, spaces });
    }

    // Print the bottom of the table
    std.debug.print("\u{2570}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{256F}\n", .{});
}