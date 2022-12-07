const std = @import("std");
const input = @embedFile("./input.txt");

const tie = 3;
const win = 6;

const rock = 1;
const paper = 2;
const scissors = 3;

const Choice = struct { rock: u8, paper: u8, scissors: u8 };
const Must = struct { win: u8, tie: u8, lose: u8 };

const opp = Choice{ .rock = "A"[0], .paper = "B"[0], .scissors = "C"[0] };
const must = Must{ .lose = "X"[0], .tie = "Y"[0], .win = "Z"[0] };

pub fn main() !void {
    var iter = std.mem.split(u8, input, "\n");
    var total: i32 = 0;
    while (iter.next()) |line| {
        if (line.len == 0) break;

        total += switch (line[0]) {
            opp.rock => switch (line[2]) {
                must.lose => scissors,
                must.tie => tie + rock,
                must.win => win + paper,
                else => return error.Error,
            },
            opp.paper => switch (line[2]) {
                must.lose => rock,
                must.tie => tie + paper,
                must.win => win + scissors,
                else => return error.Error,
            },
            opp.scissors => switch (line[2]) {
                must.lose => paper,
                must.tie => tie + scissors,
                must.win => win + rock,
                else => return error.Error,
            },
            else => return error.Error,
        };
    }

    std.debug.print("{d}\n", .{total});
}
