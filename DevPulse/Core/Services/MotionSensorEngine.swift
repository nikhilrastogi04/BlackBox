//
//  MotionSensorEngine.swift
//  DevPulse
//
//  Created by Nikhil Rastogi on 9/27/26.
//

import Foundation
import CoreMotion

public final class MotionSensorEngine: SensorProvider, @unchecked Sendable {
    public typealias DataPoint = MotionDataPoint
    private let motionManager = CMMotionManager()
    private let updateInterval: TimeInterval = 1.0 / 50.0 // 50 Hz
    
    public var isAvailable: Bool {
        motionManager.isAccelerometerAvailable
    }
    
    public func startStreaming() -> AsyncStream<MotionDataPoint> {
        AsyncStream(bufferingPolicy: .bufferingNewest(100)) { continuation in
            motionManager.accelerometerUpdateInterval = updateInterval
            motionManager.startAccelerometerUpdates(to: .main) {data, _ in
                
                guard let data else { return }
                
                let point = MotionDataPoint(
                    timeStamp: Date(),
                    x: data.acceleration.x,
                    y: data.acceleration.y,
                    z: data.acceleration.z
                )
                continuation.yield(point)
            }
            
            continuation.onTermination = { _ in
                Task { @MainActor [weak self ]in
                    self?.motionManager.stopAccelerometerUpdates()
                }
            }
        }
    }
    
    public func stopStreaming() {
        motionManager.stopAccelerometerUpdates()
    }
}


