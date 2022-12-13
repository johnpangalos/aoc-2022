const std = @import("std");
const input = @embedFile("./input.txt");

const Range = struct {
    min: usize,
    max: usize,
};
const Ranges = std.meta.Tuple(&.{ Range, Range });
pub fn main() !void {
    var iter = std.mem.tokenize(u8, input, "\n");
    var total: usize = 0;

    while (iter.next()) |line| {
        var ranges = std.mem.tokenize(u8, line, ",");

        var firstRangeStr = ranges.next().?;
        var firstRangeIter = std.mem.tokenize(u8, firstRangeStr, "-");
        var firstRange = Range{
            .min = try std.fmt.parseInt(usize, firstRangeIter.next().?, 10),
            .max = try std.fmt.parseInt(usize, firstRangeIter.next().?, 10),
        };

        var secondRangeStr = ranges.next().?;
        var secondRangeIter = std.mem.tokenize(u8, secondRangeStr, "-");
        var secondRange = Range{
            .min = try std.fmt.parseInt(usize, secondRangeIter.next().?, 10),
            .max = try std.fmt.parseInt(usize, secondRangeIter.next().?, 10),
        };

        if (firstRange.min <= secondRange.min and
            firstRange.max >= secondRange.max or
            firstRange.min >= secondRange.min and
            firstRange.max <= secondRange.max)
            total += 1;
    }

    std.debug.print("{d}\n", .{total});
}
