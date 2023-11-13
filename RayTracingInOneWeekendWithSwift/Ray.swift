//
//  Ray.swift
//  RayTracingInOneWeekendWithSwift
//
//  Created by cas2void on 2023/11/1.
//

struct Ray<T: BinaryFloatingPoint> {
    var origin: Vec3<T>
    var direction: Vec3<T>
    
    func at(t: T) -> Vec3<T> {
        return origin + t * direction
    }
}
