const std = @import("std");
const input = @embedFile("./input.txt");

const tiePts = 3;
const winPts = 6;
const rock = 1;
const paper = 2;
const scissors = 3;
const oppRock = "A"[0];
const oppPaper = "B"[0];
const oppScissors = "C"[0];
const mustLose = "X"[0];
const mustTie = "Y"[0];
const mustWin = "Z"[0];

pub fn main() !void {
    var iter = std.mem.split(u8, input, "\n");
    var total: i32 = 0;
    while (iter.next()) |line| {
        if (line.len == 0) break;

        total += switch (line[0]) {
            oppRock => switch (line[2]) {
                mustLose => scissors,
                mustTie => tiePts + rock,
                mustWin => winPts + paper,
                else => return error.Error,
            },
            oppPaper => switch (line[2]) {
                mustLose => rock,
                mustTie => tiePts + paper,
                mustWin => winPts + scissors,
                else => return error.Error,
            },
            oppScissors => switch (line[2]) {
                mustLose => paper,
                mustTie => tiePts + scissors,
                mustWin => winPts + rock,
                else => return error.Error,
            },
            else => return error.Error,
        };
    }

    std.debug.print("{d}\n", .{total});
}
