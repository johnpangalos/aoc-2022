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

        if (line[0] == oppRock and line[2] == mustLose) {
            total = total + scissors;
        } else if (line[0] == oppRock and line[2] == mustTie) {
            total = total + tiePts + rock;
        } else if (line[0] == oppRock and line[2] == mustWin) {
            total = total + winPts + paper;
        } else if (line[0] == oppPaper and line[2] == mustLose) {
            total = total + rock;
        } else if (line[0] == oppPaper and line[2] == mustTie) {
            total = total + tiePts + paper;
        } else if (line[0] == oppPaper and line[2] == mustWin) {
            total = total + winPts + scissors;
        } else if (line[0] == oppScissors and line[2] == mustLose) {
            total = total + paper;
        } else if (line[0] == oppScissors and line[2] == mustTie) {
            total = total + tiePts + scissors;
        } else if (line[0] == oppScissors and line[2] == mustWin) {
            total = total + winPts + rock;
        }
    }

    std.debug.print("{d}\n", .{total});
}
