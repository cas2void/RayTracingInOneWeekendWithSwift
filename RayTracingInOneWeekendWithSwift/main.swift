//
//  main.swift
//  RayTracingInOneWeekendWithSwift
//
//  Created by cas2void on 2023/10/13.
//

var film = Film(width: 320, height: 180)

for x in 0..<film.width {
    for y in 0..<film.height {
        let r = Float(x) / Float(film.width - 1)
        let g = Float(y) / Float(film.height - 1)
        
        film.sense(x: x, y: y, color: Color(r: r, g: g, b: 0.0))
    }
}

film.savePNG(name: "test")
