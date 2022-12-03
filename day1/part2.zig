const std = @import("std");
const input = @embedFile("./input.txt");

pub fn main() !void {
    var iter = std.mem.split(u8, input, "\n");
    var maxArr = [3]i32{ 0, 0, 0 };
    var curr: i32 = 0;

    while (iter.next()) |line| {
        if (line.len > 0) {
            curr = curr + try std.fmt.parseInt(i32, line, 10);
            continue;
        }

        for (maxArr) |max, idx| {
            if (curr > max) {
                if (idx != 2) {
                    maxArr[idx + 1] = max;
                }
                maxArr[idx] = curr;
                break;
            }
        }
        curr = 0;
    }

    var sum: i32 = 0;
    for (maxArr) |max| {
        sum = sum + max;
    }

    std.debug.print("{d}\n", .{sum});
}
