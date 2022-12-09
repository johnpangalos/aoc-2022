const mem = @import("std").mem;
const debug = @import("std").debug;
const input = @embedFile("./input.txt");

const itemVal = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

pub fn main() !void {
    var iter = mem.split(u8, input, "\n");
    var total: usize = 0;

    while (iter.next()) |line| {
        if (line.len == 0) break;

        const len = line.len / 2;

        for (line[0..len]) |x| {
            if (mem.indexOfScalar(u8, line[len..], x) != null) {
                total += mem.indexOfScalar(u8, itemVal, x).? + 1;
                break;
            }
        }
    }
    debug.print("{d}\n", .{total});
}
