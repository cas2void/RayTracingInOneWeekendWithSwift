//
//  Vec3.swift
//  RayTracingInOneWeekendWithSwift
//
//  Created by cas2void on 2023/11/1.
//

struct Vec3 {
    var x: Float
    var y: Float
    var z: Float
    
    static let zero = Vec3(x: 0, y: 0, z: 0)
    
    // vector arithmetic
    static func + (lhs: Vec3, rhs: Vec3) -> Vec3 {
        return Vec3(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }
    
    static func - (lhs: Vec3, rhs: Vec3) -> Vec3 {
        return Vec3(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
    }
    
    // scalar arithmetic
    static func + (lhs: Vec3, rhs: Float) -> Vec3 {
        return Vec3(x: lhs.x + rhs, y: lhs.y + rhs, z: lhs.z + rhs)
    }
    
    static func * (lhs: Float, rhs: Vec3) -> Vec3 {
        return Vec3(x: lhs * rhs.x, y: lhs * rhs.y, z: lhs * rhs.z)
    }
    
    // geometry
    static func dot(_ lhs: Vec3, _ rhs: Vec3) -> Float {
        return lhs.x * rhs.x + lhs.y * rhs.y + lhs.z * rhs.z
    }
    
    func lengthSquared() -> Float {
        return x * x + y * y + z * z
    }
    
    func length() -> Float {
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
