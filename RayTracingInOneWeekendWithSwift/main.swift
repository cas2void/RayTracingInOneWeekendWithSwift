//
//  main.swift
//  RayTracingInOneWeekendWithSwift
//
//  Created by cas2void on 2023/10/13.
//


let imageScale = 1
let imageWidth = 320 * imageScale
let imageHeight = 180 * imageScale

let scene = Scene<Float>(hittables: [Sphere<Float>(center: Vec3<Float>(x: 0, y: 0, z: 1), radius: 0.5),
                                     Sphere<Float>(center: Vec3<Float>(x: 0, y: -100.5, z: 1), radius: 100)])
var camera = Camera<Float>(width: imageWidth, height: imageHeight)

camera.render(scene: scene)
camera.film.exportPNG(name: "test")
