const std = @import("std");
const input = @embedFile("./input.txt");

const tie = 3;
const win = 6;
const rock = 1;
const paper = 2;
const scissors = 3;
const oppRock = "A"[0];
const oppPaper = "B"[0];
const oppScissors = "C"[0];
const usRock = "X"[0];
const usPaper = "Y"[0];
const usScissors = "Z"[0];

pub fn main() !void {
    var iter = std.mem.split(u8, input, "\n");
    var total: i32 = 0;
    while (iter.next()) |line| {
        if (line.len == 0) break;

        total = switch (line[0]) {
            oppRock => switch (line[2]) {
                usRock => total + tie + rock,
                usPaper => total + win + paper,
                usScissors => total + scissors,
                else => return error.Error,
            },
            oppPaper => switch (line[2]) {
                usRock => total + rock,
                usPaper => total + tie + paper,
                usScissors => total + win + scissors,
                else => return error.Error,
            },
            oppScissors => switch (line[2]) {
                usRock => total + win + rock,
                usPaper => total + paper,
                usScissors => total + tie + scissors,
                else => return error.Error,
            },
            else => return error.Error,
        };
    }

    std.debug.print("{d}\n", .{total});
}
