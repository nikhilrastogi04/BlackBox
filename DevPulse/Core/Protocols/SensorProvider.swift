//
//  SensorProvider.swift
//  DevPulse
//
//  Created by Nikhil Rastogi on 9/25/26.
//

import Foundation

protocol SensorProvider<DataPoint>: Sendable {
    associatedtype DataPoint: Sendable & Identifiable & Equatable
    var isAvailable: Bool { get }
    func startStreaming() -> AsyncStream<DataPoint>
    func stopStreaming()
}