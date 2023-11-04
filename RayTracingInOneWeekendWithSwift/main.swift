//
//  main.swift
//  RayTracingInOneWeekendWithSwift
//
//  Created by cas2void on 2023/10/13.
//

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
func hitSphere(center: Vec3, radius: Float, ray: Ray) -> Float {
    // O - C
    let oc = ray.origin - center;
    // dot(D, D)
    let a = Vec3.dot(ray.direction, ray.direction)
    // 2 * dot(D, O - C)
    let b = 2 * Vec3.dot(ray.direction, oc)
    // dot(O - C, O - C) - r * r
    let c = Vec3.dot(oc, oc) - radius * radius
    
    let discriminant = b * b - 4 * a * c
    if discriminant < 0 {
        return -1
    } else {
        return (-b - discriminant.squareRoot()) / (2 * a)
    }
}

func rayColor(ray: Ray) -> Color {
    let sphereCenter = Vec3(x: 0, y: 0, z: 1)
    let t = hitSphere(center: sphereCenter, radius: 0.5, ray: ray)
    if t > 0 {
        let normal = (ray.at(t: t) - sphereCenter).normalized()
        return Color(vec: 0.5 * (normal + 1))
    }
    let a = (ray.direction.normalized().y + 1) * 0.5
    let gradient = (1 - a) * Vec3(x: 1, y: 1, z: 1) + a * Vec3(x: 0.5, y: 0.7, z: 1)
    
    return Color(vec: gradient)
}

let imageWidth = 320
let imageHeight = 180

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
        
        film.sense(x: x, y: y, color: rayColor(ray: ray))
    }
}

film.savePNG(name: "test")
