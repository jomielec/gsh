const std = @import("std");

const lsVersion = 0;

fn max(a: usize, b: usize) usize {
    if (a > b) {
        return a;
    } else {
        return b;
    }
}

pub fn version0() !void {
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    const cwd = std.fs.cwd();

    var dir = try cwd.openDir(".", .{ .iterate = true });
    defer dir.close();

    try stdout.print("File Name:\n", .{});

    var iterator = dir.iterate();
    while (try iterator.next()) |entry| {
        const color = switch (entry.kind) {
            std.fs.File.Kind.directory => "\x1b[32m",
            std.fs.File.Kind.sym_link => "\x1b[33m",
            else => "\x1b[34m",
        };
        try stdout.print("-> {s}{s}\x1b[0m\n", .{color, entry.name});
    }
    try stdout.print(" \n", .{});
    try bw.flush();
}

fn version1() !void {
    const cwd = std.fs.cwd(); // Get the current working directory
    var files = std.ArrayList([]const u8).init(std.heap.page_allocator);

    // Open the current directory explicitly with "."
    var dir = try cwd.openDir("./", .{});
    defer dir.close();

    var iterator = dir.iterate(); // Get the iterator

    std.debug.print("\u{256D}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\n\u{2502} Name:\n\u{251C}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\n", .{});
    while (true) {
        const entry = try iterator.next();
        if (entry == null) break; // Exit loop if no more entries

        try files.append(entry.?.name); // Append the directory name
    }

    // Print each directory in the list
    for (files.items) |item| {
        std.debug.print("\u{2502} \x1b[32m{s}\x1b[0m\u{2502}\n", .{item});
    }
}

fn version2() !void {
    const allocator = std.heap.page_allocator;

    const cwd = std.fs.cwd(); // Get the current working directory
    var files = std.ArrayList([]const u8).init(allocator);

    // Open the current directory explicitly with "."
    var dir = try cwd.openDir(".", .{ .iterate = true });
    defer dir.close();

    var iterator = dir.iterate(); // Get the iterator

    // Print the top of the table
    std.debug.print("\u{256D}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{256e}\n\u{2502} Name:         \u{2502}\n\u{251C}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2500}\u{2524}\n", .{});

    // Collect directory names
    while (try iterator.next()) |entry| {
        try files.append(entry.name); // Append the directory name
    }

    // Find the maximum length of the directory names to properly align the table
    var max_len: usize = 0;
    for (files.items) |item| {
        max_len = max(max_len, item.len);
    }

    // Print each directory name
    for (files.items) |item| {
        const spaces_needed = max_len - item.len;

        // Dynamically allocate memory for spaces
        var spaces = try allocator.alloc(u8, spaces_needed);
        defer allocator.free(spaces);

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

pub fn main() !void {
    try switch (lsVersion) {
        0 => version0(),
        1 => version1(),
        2 => version2(),
        else => std.debug.print("Invalid LsVersion")
    };
}