const std = @import("std");
const input = @embedFile("./test.txt");

const Node = struct {
    name: []const u8,
    subDirs: std.ArrayList(*Node),
    size: ?usize,
    parent: ?*Node,
    fn totalSize(self: *Node) usize {
        var total = self.size;
        for (self.subDirs.items) |node| {
            if (node.*.size == null) {
                total += node.*.size;
                continue;
            }
            total += &node.totalSize();
        }
    }
    fn deinit(self: *Node) !void {
        for (self.subDirs.items) |node| {
            if (node.*.size == null) continue;
            node.*.deinit();
        }
        self.subDirs.deinit();
    }
};

pub fn main() !void {
    var iter = std.mem.tokenize(u8, input, "\n");
    var currentDir: ?*Node = null;
    var map = std.StringHashMap(Node).init(
        std.heap.page_allocator,
    );
    map.deinit();
    while (iter.next()) |line| {
        if (std.mem.eql(u8, line, "$ ls")) continue;
        if (std.mem.eql(u8, line, "$ cd ..")) {
            currentDir = currentDir.?.parent;
            continue;
        }
        if (std.mem.eql(u8, line[0..4], "$ cd")) {
            var node = Node{
                .parent = currentDir,
                .name = line[5..],
                .subDirs = std.ArrayList(*Node).init(std.heap.page_allocator),
                .size = null,
            };
            currentDir = &node;
            std.debug.print("{s}", .{node.name});
            // try map.putNoClobber(node.name, node);
            continue;
        }
        if (std.mem.eql(u8, line[0..3], "dir")) {
            var subDirs = std.ArrayList(*Node).init(std.heap.page_allocator);
            try map.put(line[5..], .{
                .parent = currentDir,
                .name = line[5..],
                .subDirs = subDirs,
                .size = null,
            });
            // try currentDir.?.subDirs.append(&node);
        }
    }
}
