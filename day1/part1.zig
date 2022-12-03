const std = @import("std");
const input = @embedFile("./input.txt");

pub fn main() !void {
    var iter = std.mem.split(u8, input, "\n");
    var max: i32 = 0;
    var curr: i32 = 0;

    while (iter.next()) |line| {
        if (line.len == 0 and max < curr) {
            max = curr;
        }
        if (line.len == 0) {
            curr = 0;
            continue;
        }

        var cals: i32 = try std.fmt.parseInt(i32, line, 10);
        curr = curr + cals;
    }

    std.debug.print("{d}\n", .{max});
}
