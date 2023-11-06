//
//  Scene.swift
//  RayTracingInOneWeekendWithSwift
//
//  Created by cas2void on 2023/11/5.
//

struct Scene: Hittable {
    var hittables: [Hittable]
    
    func hit(ray: Ray, interval: Interval) -> HitData? {
        var hitData: HitData?
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
