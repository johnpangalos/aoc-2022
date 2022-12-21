const std = @import("std");
const input = @embedFile("./input.txt");

fn getPath(stack: std.ArrayList([]const u8)) ![]const u8 {
    var path = std.ArrayList(u8).init(std.heap.page_allocator);

    for (stack.items) |item| {
        try path.appendSlice(item);
        if (!std.mem.eql(u8, item, "/")) try path.append('/');
    }
    return path.items;
}

pub fn main() !void {
    var iter = std.mem.tokenize(u8, input, "\n");
    var map = std.StringHashMap(usize).init(
        std.heap.page_allocator,
    );
    defer map.deinit();

    var stack = std.ArrayList([]const u8).init(std.heap.page_allocator);
    defer stack.deinit();

    while (iter.next()) |line| {
        if (std.mem.eql(u8, line, "$ ls")) continue;
        if (std.mem.eql(u8, line, "$ cd ..")) {
            _ = stack.pop();
            continue;
        }
        if (std.mem.eql(u8, line[0..4], "$ cd")) {
            try stack.append(line[5..]);
            _ = try map.getOrPutValue(try getPath(stack), 0);
            continue;
        }
        if (std.mem.eql(u8, line[0..3], "dir")) {
            // _ = try map.getOrPutValue(getPath(stack), 0);
            continue;
        }
        var temp = std.mem.tokenize(u8, line, " ");
        var size = try std.fmt.parseInt(usize, temp.next().?, 10);

        for (stack.items) |_, idx| {
            var stackClone = try stack.clone();
            stackClone.shrinkRetainingCapacity(idx + 1);
            var path = try getPath(stackClone);
            var currentSize = map.get(path) orelse 0;
            try map.put(path, currentSize + size);
        }
    }

    var mapIter = map.iterator();
    var total: usize = 0;
    while (mapIter.next()) |node| {
        if (node.value_ptr.* <= 100000) total += node.value_ptr.*;
        // std.debug.print("{s}, {d}\n", .{ node.key_ptr.*, node.value_ptr.* });
    }
    std.debug.print("{d}\n", .{total});
}
