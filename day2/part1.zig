const std = @import("std");
const input = @embedFile("./input.txt");

const tie = 3;
const win = 6;

const rock = 1;
const paper = 2;
const scissors = 3;

const Choice = struct { rock: u8, paper: u8, scissors: u8 };

const opp = Choice{ .rock = "A"[0], .paper = "B"[0], .scissors = "C"[0] };
const us = Choice{ .rock = "X"[0], .paper = "Y"[0], .scissors = "Z"[0] };

pub fn main() !void {
    var iter = std.mem.split(u8, input, "\n");
    var total: i32 = 0;
    while (iter.next()) |line| {
        if (line.len == 0) break;

        total += switch (line[0]) {
            opp.rock => switch (line[2]) {
                us.rock => tie + rock,
                us.paper => win + paper,
                us.scissors => scissors,
                else => return error.Error,
            },
            opp.paper => switch (line[2]) {
                us.rock => rock,
                us.paper => tie + paper,
                us.scissors => win + scissors,
                else => return error.Error,
            },
            opp.scissors => switch (line[2]) {
                us.rock => win + rock,
                us.paper => paper,
                us.scissors => tie + scissors,
                else => return error.Error,
            },
            else => return error.Error,
        };
    }

    std.debug.print("{d}\n", .{total});
}
