const std = @import("std");

const Vec3 = struct {
    x: f64,
    y: f64,
    z: f64,

    pub fn init(x: f64, y: f64, z: f64) Vec3 {
        return Vec3{
            .x = x,
            .y = y,
            .z = z,
        };
    }

    pub fn negate(self: Vec3) Vec3 {
        return Vec3{
            .x = self.x * -1,
            .y = self.y * -1,
            .z = self.z * -1,
        };
    }

    pub fn add(self: Vec3, other: Vec3) Vec3 {
        return Vec3{
            .x = self.x + other.x,
            .y = self.y + other.y,
            .z = self.z + other.z,
        };
    }

    pub fn subtract(self: Vec3, other: Vec3) Vec3 {
        return Vec3{
            .x = self.x - other.x,
            .y = self.y - other.y,
            .z = self.z - other.z,
        };
    }

    pub fn multiply(self: Vec3, t: f64) Vec3 {
        return Vec3{
            .x = self.x * t,
            .y = self.y * t,
            .z = self.z * t,
        };
    }

    pub fn divide(self: Vec3, t: f64) Vec3 {
        std.debug.assert(t != 0); // 2 Thessalonians 3:10
        return Vec3{
            .x = self.x * 1 / t,
            .y = self.y * 1 / t,
            .z = self.z * 1 / t,
        };
    }

    pub fn length(self: Vec3) f64 {
        return @sqrt(self.length_squared());
    }

    pub fn length_squared(self: Vec3) f64 {
        return (self.x * self.x) + (self.y * self.y) + (self.z * self.z);
    }

    pub fn print(self: Vec3) void {
        std.debug.print("{d:.3} {d:.3} {d:.3}\n", .{ self.x, self.y, self.z });
    }
};

const expect = @import("std").testing.expect;

test "init vector" {
    const v = Vec3.init(1, 2, 3);
    try expect(v.x == 1);
    try expect(v.y == 2);
    try expect(v.z == 3);
}

test "negate vector" {
    const v1 = Vec3.init(1, 2, 3);
    const v2 = v1.negate();
    try expect(v2.x == -1);
    try expect(v2.y == -2);
    try expect(v2.z == -3);
}

test "add vectors" {
    const v1 = Vec3.init(1.0, 2.0, 3.0);
    const v2 = Vec3.init(1.0, 2.0, 3.0);
    const v3 = v1.add(v2);
    try expect(v3.x == 2);
    try expect(v3.y == 4);
    try expect(v3.z == 6);
}

test "subtract vectors" {
    const v1 = Vec3.init(1.0, 2.0, 3.0);
    const v2 = Vec3.init(1.0, 2.0, 3.0);
    const v3 = v1.subtract(v2);

    try expect(v3.length() == 0);
}

test "multiply a vector by some value" {
    const v1 = Vec3.init(1.0, 2.0, 3.0);
    const v2 = v1.multiply(2);
    try expect(v2.x == 2);
    try expect(v2.y == 4);
    try expect(v2.z == 6);
}

test "length of vector" {
    const v = Vec3.init(2, 3, 6);
    try expect(v.length() == 7);
}

test "square length of vector" {
    const v1 = Vec3.init(1.0, 2.0, 3.0);
    const v2 = Vec3.init(1.0, 2.0, 3.0);
    const v3 = v1.add(v2);
    try expect(v3.length_squared() == 56);
}
