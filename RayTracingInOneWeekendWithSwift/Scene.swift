//
//  Scene.swift
//  RayTracingInOneWeekendWithSwift
//
//  Created by cas2void on 2023/11/5.
//

struct Scene: Hittable {
    var hittables: [Hittable]
    
    func hit(ray: Ray, tMin: Float, tMax: Float) -> HitData? {
        var hitData: HitData?
        var closestSoFar = tMax
        
        for hittable in hittables {
            let currentHitData = hittable.hit(ray: ray, tMin: tMin, tMax: closestSoFar)
            if let currentHitData = currentHitData {
                closestSoFar = currentHitData.t
                hitData = currentHitData
            }
        }
        return hitData
    }
}
