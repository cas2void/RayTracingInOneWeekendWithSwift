//
//  Hittable.swift
//  RayTracingInOneWeekendWithSwift
//
//  Created by cas2void on 2023/11/5.
//

struct HitData {
    var t: Float
    var position: Vec3
    var normal: Vec3
    var frontFace: Bool
    
    init(t: Float, position: Vec3, normal: Vec3, frontFace: Bool) {
        self.t = t
        self.position = position
        self.normal = normal
        self.frontFace = frontFace
    }
    
    init(t: Float, position: Vec3, outwardNormal: Vec3, ray: Ray) {
        var normal = outwardNormal
        var frontFace = true
        if Vec3.dot(ray.direction, outwardNormal) > 0 {
            normal = -1 * outwardNormal
            frontFace = false
        }
        
        self.init(t: t, position: position, normal: normal, frontFace: frontFace)
    }
}

protocol Hittable {
    func hit(ray: Ray, interval: Interval) -> HitData?
}

struct Sphere: Hittable {
    var center: Vec3
    var radius: Float
    
    // sphere equation, center at C: (c_x, c_y, c_z), radius: r
    // (x - c_x) * (x - c_x) + (y - c_y) * (y - c_y) + (z - c_z) * (z - c_z) = r * r
    // that is, for point P
    // dot((P - C), (P - C)) = r * r
    //
    // if ray p(t) = O + t*D ever hits the sphere, then
    // there is some t for which p(t) satisfies the sphere equation
    //
    // dot((O + t*D - C), (O + t*D - C)) = r * r
    // t * t * dot(D, D) + 2 * t * dot(D, O - C) + dot(O - C, O - C) - r * r = 0
    func hit(ray: Ray, interval: Interval) -> HitData? {
        // O - C
        let oc = ray.origin - center;
        // dot(D, D)
        let a = Vec3.dot(ray.direction, ray.direction)
        // 2 * dot(D, O - C)
        let b = 2 * Vec3.dot(ray.direction, oc)
        // dot(O - C, O - C) - r * r
        let c = Vec3.dot(oc, oc) - radius * radius
        
        let discriminant = b * b - 4 * a * c
        if discriminant >= 0 {
            let root = discriminant.squareRoot()
            var solution = (-b - root) / (2 * a)
            if let hitData = checkSolution(solution: solution, ray: ray, interval: interval) {
                return hitData
            } else {
                solution = (-b + root) / (2 * a)
                if let hitData = checkSolution(solution: solution, ray: ray, interval: interval) {
                    return hitData
                }
            }
        }
        
        return nil
    }
    
    private func checkSolution(solution: Float, ray: Ray, interval: Interval) -> HitData? {
        if interval.surrounds(solution) {
            let hitPosition = ray.at(t: solution)
            let outwardNormal = 1 / radius * (hitPosition - center)
            return HitData(t: solution, position: hitPosition, outwardNormal: outwardNormal, ray: ray)
        }
        
        return nil
    }
}
