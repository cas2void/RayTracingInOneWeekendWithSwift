//
//  Scene.swift
//  RayTracingInOneWeekendWithSwift
//
//  Created by cas2void on 2023/11/5.
//

struct Scene<T: BinaryFloatingPoint>: Hittable {
    var hittables: [any Hittable<T>]
    
    func hit(ray: Ray<T>, interval: Interval<T>) -> HitData<T>? {
        var hitData: HitData<T>?
        var closestSoFar = interval.max
        
        for hittable in hittables {
            let currentHitData = hittable.hit(ray: ray, interval: Interval(min: interval.min, max: closestSoFar))
            if let currentHitData = currentHitData {
                closestSoFar = currentHitData.t
                hitData = currentHitData
            }
        }
        return hitData
    }
}
