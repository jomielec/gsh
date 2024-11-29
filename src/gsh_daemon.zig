const std = @import("std");
const ls = @import("ls.zig");

pub fn handle_system_call(command: []const u8) void {
    if (std.mem.eql(u8, command, "list_files")) {
        // This will be true if `command` is the same as the string "list_files"
        ls.list_v0();
    } else {
        // Handle other system calls
    }
}