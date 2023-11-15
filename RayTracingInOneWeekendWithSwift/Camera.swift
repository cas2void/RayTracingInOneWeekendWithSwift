//
//  Camera.swift
//  RayTracingInOneWeekendWithSwift
//
//  Created by cas2void on 2023/11/15.
//

struct Camera<T: BinaryFloatingPoint> {
    var film: Film
    
    private let location: Vec3<T> // camera location in world space
    private let topLeft: Vec3<T>  // pixel top left location in world space
    private let deltaU: Vec3<T>
    private let deltaV: Vec3<T>
    
    init(width: Int, height: Int) {
        self.film = Film(width: width, height: height)
        
        self.location = Vec3<T>(x: 0, y: 0, z: 0)
        
        let focalLength: T = 1
        let viewportHeight: T = 2
        let viewportWidth = viewportHeight * T(width) / T(height)
        let viewportTopLeft = location + Vec3<T>(x: 0, y: 0, z: focalLength) + Vec3<T>(x: viewportWidth * -0.5, y: viewportHeight * 0.5, z: 0)
        
        self.deltaU = Vec3<T>(x: viewportWidth / T(width), y: 0, z: 0)
        self.deltaV = Vec3<T>(x: 0, y: -viewportHeight / T(height), z: 0)
        self.topLeft = viewportTopLeft + 0.5 * (deltaU + deltaV)
    }
    
    mutating func render(scene: Scene<T>) {
        for y in 0..<film.height {
            for x in 0..<film.width {
                let ray = shootRay(x: x, y: y)
                film.sense(x: x, y: y, color: rayColor(ray: ray, scene: scene))
            }
        }
    }
    
    private func shootRay(x: Int, y: Int) -> Ray<T> {
        let target = topLeft + T(x) * deltaU + T(y) * deltaV
        return Ray(origin: location, direction: target - location)
    }
    
    private func rayColor(ray: Ray<T>, scene: Scene<T>) -> Color {
        if let hitData = scene.hit(ray: ray, interval: Interval(min: 0)) {
            return Color.make(vec: 0.5 * (hitData.normal + 1))
        }
        
        let a = (ray.direction.normalized().y + 1) * 0.5
        let gradient = (1 - a) * Vec3<T>(x: 1, y: 1, z: 1) + a * Vec3<T>(x: 0.5, y: 0.7, z: 1)
        
        return Color.make(vec: gradient)
    }
}
