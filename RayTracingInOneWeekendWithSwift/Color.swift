//
//  Color.swift
//  RayTracingInOneWeekendWithSwift
//
//  Created by cas2void on 2023/10/28.
//

struct Color {
    var r: Float
    var g: Float
    var b: Float
    var a: Float
    
    init(r: Float, g: Float, b: Float, a: Float) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
    }
    
    init(r: Float, g: Float, b: Float) {
        self.init(r: r, g: g, b: b, a: 1)
    }
    
    init() {
        self.init(r: 0, g: 0, b: 0, a: 1)
    }
    
    func saturated() -> Color {
        return Color(r: clamp01(r), g: clamp01(g), b: clamp01(b), a: clamp01(a))
    }
    
    private func clamp01(_ value: Float) -> Float {
        return min(max(value, 0), 1)
    }
}
