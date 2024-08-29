const std = @import("std");

pub fn main() !void {
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    const image_width = 256;
    const image_height = 256;

    try stdout.print("P3\n{} {}\n255\n", .{ image_width, image_height });

    var j: f16 = 0;
    while (j < image_height) : (j += 1) {
        std.log.info("\rScanlines remaining: {} ", .{image_height - j});
        var i: f16 = 0;
        while (i < image_width) : (i += 1) {
            const r: f32 = i / (image_width - 1);
            const g: f32 = j / (image_height - 1);
            const b = 0;

            const ir: u32 = @intFromFloat(111.999 * r);
            const ig: u32 = @intFromFloat(111.999 * g);
            const ib: u32 = @intFromFloat(255.999 * b);

            try stdout.print("{} {} {}\n", .{ ir, ig, ib });
        }
    }
    std.log.info("\rDone!", .{});

    try bw.flush(); // Don't forget to flush!
}
