const std = @import("std");
const input = @embedFile("./input.txt");

pub fn main() !void {
    var iter = std.mem.split(u8, input, "\n");
    var curr: i32 = 0;
    var list = std.ArrayList(i32).init(std.heap.page_allocator);
    defer list.deinit();

    while (iter.next()) |line| {
        if (line.len > 0) {
            curr = curr + try std.fmt.parseInt(i32, line, 10);
            continue;
        }

        try list.append(curr);
        curr = 0;
    }

    std.sort.sort(i32, list.items, {}, comptime std.sort.desc(i32));

    std.debug.print("{d}\n", .{list.items[0] + list.items[1] + list.items[2]});
}
