//
//  Interval.swift
//  RayTracingInOneWeekendWithSwift
//
//  Created by cas2void on 2023/11/6.
//

struct Interval<T: BinaryFloatingPoint> {
    var min: T
    var max: T
    
    init(min: T, max: T) {
        self.min = min
        self.max = max
    }
    
    init(min: T) {
        self.init(min: min, max: T.greatestFiniteMagnitude)
    }
    
    func surrounds(_ value: T) -> Bool {
        return min < value && value < max
    }
}
