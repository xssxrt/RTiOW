//! By convention, main.zig is where your main function lives in the case that
//! you are building an executable. If you are making a library, the convention
//! is to delete this file and start with root.zig instead.
const std = @import("std");

pub fn main() !void {
    // stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
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

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // Try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}

test "fuzz example" {
    // Try passing `--fuzz` to `zig build test` and see if it manages to fail this test case!
    const input_bytes = std.testing.fuzzInput(.{});
    try std.testing.expect(!std.mem.eql(u8, "canyoufindme", input_bytes));
}
