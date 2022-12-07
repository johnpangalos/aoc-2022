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

        if (line[0] == oppRock and line[2] == usRock) {
            total = total + tie + rock;
        } else if (line[0] == oppRock and line[2] == usPaper) {
            total = total + win + paper;
        } else if (line[0] == oppRock and line[2] == usScissors) {
            total = total + scissors;
        } else if (line[0] == oppPaper and line[2] == usRock) {
            total = total + rock;
        } else if (line[0] == oppPaper and line[2] == usPaper) {
            total = total + tie + paper;
        } else if (line[0] == oppPaper and line[2] == usScissors) {
            total = total + win + scissors;
        } else if (line[0] == oppScissors and line[2] == usRock) {
            total = total + win + rock;
        } else if (line[0] == oppScissors and line[2] == usPaper) {
            total = total + paper;
        } else if (line[0] == oppScissors and line[2] == usScissors) {
            total = total + tie + scissors;
        }
    }

    std.debug.print("{d}\n", .{total});
}
