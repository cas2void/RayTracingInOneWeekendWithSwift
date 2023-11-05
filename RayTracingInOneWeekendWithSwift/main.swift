//
//  main.swift
//  RayTracingInOneWeekendWithSwift
//
//  Created by cas2void on 2023/10/13.
//

func rayColor(ray: Ray, hittable: Hittable) -> Color {
    if let hitData = hittable.hit(ray: ray, tMin: 0, tMax: Float.greatestFiniteMagnitude) {
        return Color(vec: 0.5 * (hitData.normal + 1))
    }
    
    let a = (ray.direction.normalized().y + 1) * 0.5
    let gradient = (1 - a) * Vec3(x: 1, y: 1, z: 1) + a * Vec3(x: 0.5, y: 0.7, z: 1)
    
    return Color(vec: gradient)
}

let imageWidth = 320
let imageHeight = 180

let scene = Scene(hittables: [Sphere(center: Vec3(x: 0, y: 0, z: 1), radius: 0.5), Sphere(center: Vec3(x: 0, y: -100.5, z: 1), radius: 100)])

let viewportHeight: Float = 2
let viewportWidth = viewportHeight * Float(imageWidth) / Float(imageHeight)

let focalLength: Float = 1
let cameraCenter = Vec3(x: 0, y: 0, z: 0)

let viewportU = Vec3(x: viewportWidth, y: 0, z: 0)
let viewportV = Vec3(x: 0, y: -viewportHeight, z: 0)

let pixelDeltaU = Vec3(x: viewportWidth / Float(imageWidth), y: 0, z: 0)
let pixelDeltaV = Vec3(x: 0, y: -viewportHeight / Float(imageHeight), z: 0)

let viewportUpperLeft = cameraCenter + Vec3(x: 0, y: 0, z: focalLength) + Vec3(x: viewportWidth * -0.5, y: viewportHeight * 0.5, z: 0)
let pixel00Location = viewportUpperLeft + 0.5 * (pixelDeltaU + pixelDeltaV)

var film = Film(width: imageWidth, height: imageHeight)
for y in 0..<film.height {
    for x in 0..<film.width {
        let pixelCenter = pixel00Location + Float(x) * pixelDeltaU + Float(y) * pixelDeltaV
        
        let rayDirection = pixelCenter - cameraCenter
        let ray = Ray(origin: cameraCenter, direction: rayDirection)
        
        film.sense(x: x, y: y, color: rayColor(ray: ray, hittable: scene))
    }
}

film.savePNG(name: "test")
