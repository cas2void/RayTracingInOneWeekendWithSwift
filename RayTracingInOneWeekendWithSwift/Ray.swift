//
//  Ray.swift
//  RayTracingInOneWeekendWithSwift
//
//  Created by cas2void on 2023/11/1.
//

struct Ray {
    var origin: Vec3
    var direction: Vec3
    
    func at(t: Float) -> Vec3 {
        return origin + t * direction
    }
}
