//
//  Stat.swift
//  RayTracingInOneWeekendWithSwift
//
//  Created by cas2void on 2023/11/7.
//

import Dispatch

protocol Statable {
    var name: String {get}
    var samples: [Double] {get set}
    
    mutating func add(sample: Double)
    
    var count: Int {get}
    
    func sum() -> Double
    func mean() -> Double
    func standardDeviation() -> Double
}

extension Statable {
    mutating func add(sample: Double) {
        samples.append(sample)
    }
    
    var count: Int {
        return samples.count
    }
    
    func sum() -> Double {
        return samples.reduce(0, +)
    }
    
    func mean() -> Double {
        if samples.count > 0 {
            return sum() / Double(count)
        } else {
            return 0
        }
    }
    
    func standardDeviation() -> Double {
        if count > 0 {
            let mean = mean()
            let variance = samples.reduce(0) {$0 + ($1 - mean) * ($1 - mean)} / Double(count)
            return variance.squareRoot()
        } else {
            return 0
        }
    }
}

enum TimeStatUnit {
    case seconds
    case milliseconds
    case microseconds
    case nanoseconds
    
    var description: String {
        switch self {
        case.seconds:
            return "seconds"
        case .milliseconds:
            return "milliseconds"
        case .microseconds:
            return "microseconds"
        case .nanoseconds:
            return "nanoseconds"
        }
    }
    
    var nanoPerUnit: Double {
        switch self {
        case .seconds:
            return 1_000_000_000
        case .milliseconds:
            return 1_000_000
        case .microseconds:
            return 1_000
        case .nanoseconds:
            return 1
        }
    }
}

struct TimeStat: Statable {
    let name: String
    var samples: [Double] = []
    var previousTimePoint: DispatchTime?
    
    init(name: String) {
        self.name = name
        self.samples = []
    }
    
    mutating func start() {
        previousTimePoint = DispatchTime.now()
    }
    
    mutating func end() {
        if let validPreviousTimePoint = previousTimePoint {
            let intervalInNano = DispatchTime.now().uptimeNanoseconds - validPreviousTimePoint.uptimeNanoseconds
            add(sample: Double(intervalInNano))
            previousTimePoint = nil
        }
    }
    
    func toString(sampleUnit: TimeStatUnit, sumUnit: TimeStatUnit) -> String {
        let formatString =
"""
%@
    mean  : %9.3lf %@
    SD    : %9.3lf %@
    -----------------
    count : %9ld
    total : %9.3lf %@

"""
        return String(format: formatString,
                      self.name,
                      mean() / sampleUnit.nanoPerUnit, sampleUnit.description,
                      standardDeviation() / sampleUnit.nanoPerUnit, sampleUnit.description,
                      count,
                      sum() / sumUnit.nanoPerUnit, sumUnit.description)
    }
}
