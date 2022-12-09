const mem = @import("std").mem;
const debug = @import("std").debug;

const input = @embedFile("./input.txt");

const itemVal = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

pub fn main() !void {
    var iter = mem.split(u8, input, "\n");
    var total: usize = 0;

    while (iter.next()) |line| {
        if (line.len == 0) break;

        var one = iter.next().?;
        var two = iter.next().?;

        for (line) |char| {
            if (mem.indexOfScalar(u8, one, char) != null and mem.indexOfScalar(u8, two, char) != null) {
                total += mem.indexOfScalar(u8, itemVal, char).? + 1;
                break;
            }
        }
    }

    debug.print("{d}\n", .{total});
}
