//
//  Interval.swift
//  RayTracingInOneWeekendWithSwift
//
//  Created by cas2void on 2023/11/6.
//

struct Interval {
    var min: Float
    var max: Float
    
    init(min: Float, max: Float) {
        self.min = min
        self.max = max
    }
    
    init(min: Float) {
        self.init(min: min, max: Float.greatestFiniteMagnitude)
    }
    
    func surrounds(_ value: Float) -> Bool {
        return min < value && value < max
    }
}
