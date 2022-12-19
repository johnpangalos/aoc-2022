// TODO: Parse the input
// https://adventofcode.com/2022/day/5
const std = @import("std");
const input = @embedFile("./input.txt");

pub fn main() !void {
    var one = std.ArrayList(u8).init(std.heap.page_allocator);
    defer one.deinit();
    try one.appendSlice("QMGCL");

    var two = std.ArrayList(u8).init(std.heap.page_allocator);
    defer two.deinit();
    try two.appendSlice("RDLCTFHG");

    var three = std.ArrayList(u8).init(std.heap.page_allocator);
    defer three.deinit();
    try three.appendSlice("VJFNMTWR");

    var four = std.ArrayList(u8).init(std.heap.page_allocator);
    defer four.deinit();
    try four.appendSlice("JFDVQP");

    var five = std.ArrayList(u8).init(std.heap.page_allocator);
    defer five.deinit();
    try five.appendSlice("NFMSLBT");

    var six = std.ArrayList(u8).init(std.heap.page_allocator);
    defer six.deinit();
    try six.appendSlice("RNVHCDP");

    var seven = std.ArrayList(u8).init(std.heap.page_allocator);
    defer seven.deinit();
    try seven.appendSlice("HCT");

    var eight = std.ArrayList(u8).init(std.heap.page_allocator);
    defer eight.deinit();
    try eight.appendSlice("GSJVZNHP");

    var nine = std.ArrayList(u8).init(std.heap.page_allocator);
    defer nine.deinit();
    try nine.appendSlice("ZFHG");

    var stacks = std.ArrayList(@TypeOf(one)).init(std.heap.page_allocator);
    defer stacks.deinit();
    try stacks.append(one);
    try stacks.append(two);
    try stacks.append(three);
    try stacks.append(four);
    try stacks.append(five);
    try stacks.append(six);
    try stacks.append(seven);
    try stacks.append(eight);
    try stacks.append(nine);

    var iter = std.mem.tokenize(u8, input, "\n");

    while (iter.next()) |line| {
        var moveIter = std.mem.split(u8, line, " ");

        _ = moveIter.next().?;
        var move = try std.fmt.parseInt(usize, moveIter.next().?, 10);
        _ = moveIter.next().?;
        var from = try std.fmt.parseInt(usize, moveIter.next().?, 10);
        _ = moveIter.next().?;
        var to = try std.fmt.parseInt(usize, moveIter.next().?, 10);

        while (move > 0) {
            var popped = stacks.items[from - 1].pop();
            try stacks.items[to - 1].append(popped);
            move -= 1;
        }
    }
    std.debug.print("{s}{s}{s}{s}{s}{s}{s}{s}{s}\n", .{
        [_]u8{stacks.items[0].pop()},
        [_]u8{stacks.items[1].pop()},
        [_]u8{stacks.items[2].pop()},
        [_]u8{stacks.items[3].pop()},
        [_]u8{stacks.items[4].pop()},
        [_]u8{stacks.items[5].pop()},
        [_]u8{stacks.items[6].pop()},
        [_]u8{stacks.items[7].pop()},
        [_]u8{stacks.items[8].pop()},
    });
}
