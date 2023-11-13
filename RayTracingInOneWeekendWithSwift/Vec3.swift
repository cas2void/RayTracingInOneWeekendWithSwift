//
//  Vec3.swift
//  RayTracingInOneWeekendWithSwift
//
//  Created by cas2void on 2023/11/1.
//

struct Vec3<T: BinaryFloatingPoint> {
    var x: T
    var y: T
    var z: T
    
    // vector arithmetic
    static func + (lhs: Vec3, rhs: Vec3) -> Vec3 {
        return Vec3(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }
    
    static func - (lhs: Vec3, rhs: Vec3) -> Vec3 {
        return Vec3(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
    }
    
    // scalar arithmetic
    static func + (lhs: Vec3, rhs: T) -> Vec3 {
        return Vec3(x: lhs.x + rhs, y: lhs.y + rhs, z: lhs.z + rhs)
    }
    
    static func * (lhs: T, rhs: Vec3) -> Vec3 {
        return Vec3(x: lhs * rhs.x, y: lhs * rhs.y, z: lhs * rhs.z)
    }
    
    // geometry
    static func dot(_ lhs: Vec3, _ rhs: Vec3) -> T {
        return lhs.x * rhs.x + lhs.y * rhs.y + lhs.z * rhs.z
    }
    
    func lengthSquared() -> T {
        return x * x + y * y + z * z
    }
    
    func length() -> T {
        return lengthSquared().squareRoot()
    }
    
    func normalized() -> Vec3 {
        let mag = length()
        if mag != 0 {
            return Vec3(x: x / mag, y: y / mag, z: z / mag)
        } else {
            return self
        }
    }
}
