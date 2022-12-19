const std = @import("std");
const input = @embedFile("./input.txt");

const messageLength = 14;

fn firstMarker(str: []const u8) !usize {
    for (str) |_, idx| {
        if (idx > str.len - messageLength) break;
        var subStr = str[idx .. idx + messageLength];
        var total: usize = 0;
        for (subStr) |char, y| {
            if (y == subStr.len - 1) break;
            if (contains(char, subStr[y + 1 ..])) total += 1;
        }
        if (total == messageLength - 1) return idx + messageLength;
    }
    return error.MarkerNotFound;
}

fn contains(c: u8, str: []const u8) bool {
    if (str.len == 0) return true;
    for (str) |char| if (c == char) return false;
    return true;
}

pub fn main() !void {
    std.debug.print("{d}\n", .{try firstMarker(input)});
}

test "test case 1" {
    try std.testing.expect(try firstMarker("mjqjpqmgbljsphdztnvjfqwrcgsmlb") == 19);
}

test "test case 2" {
    try std.testing.expect(try firstMarker("bvwbjplbgvbhsrlpgdmjqwftvncz") == 23);
}

test "test case 3" {
    try std.testing.expect(try firstMarker("nppdvjthqldpwncqszvftbrmjlhg") == 23);
}

test "test case 4" {
    try std.testing.expect(try firstMarker("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 29);
}

test "test case 5" {
    try std.testing.expect(try firstMarker("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 26);
}
