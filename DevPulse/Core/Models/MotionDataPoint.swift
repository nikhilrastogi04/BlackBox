//
//  MotionDataPoint.swift
//  DevPulse
//
//  Created by Nikhil Rastogi on 9/25/26.
//

import Foundation

public nonisolated struct MotionDataPoint: Sendable, Identifiable, Equatable {
    public let timeStamp: Date
    public let x: Double
    public let y: Double
    public let z: Double
    
    public var id: TimeInterval {
        timeStamp.timeIntervalSince1970
    }
    
    public var magnitude: Double {
        (x*x + y*y + z*z).squareRoot()
    }
}


