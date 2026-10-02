//
//  DependencyContainer.swift
//  DevPulse
//
//  Created by Nikhil Rastogi on 9/24/26.
//

import Foundation


public protocol SensorEngineProtocol : Sendable {
    func startMonitoring()
    func stopMonitoring()
}

public struct MockSensorEngine: SensorEngineProtocol {
    public func startMonitoring() { }
    public func stopMonitoring() { }
}

public protocol NetworkMonitorProtocol : Sendable {
    var isConnected: Bool { get }
}

public struct MockNetworkMonitor: NetworkMonitorProtocol {
    public var isConnected: Bool
}


public final class DependencyContainer: Sendable {
    public let sensorEngine: SensorEngineProtocol
    public let networkMonitor: NetworkMonitorProtocol
    
    public init(sensorEngine: SensorEngineProtocol, networkMonitor: NetworkMonitorProtocol) {
        self.sensorEngine = sensorEngine
        self.networkMonitor = networkMonitor
    }
    
    public static let live = DependencyContainer(sensorEngine: MockSensorEngine(), networkMonitor: MockNetworkMonitor(isConnected: true))
    
    public static let mock = DependencyContainer(sensorEngine: MockSensorEngine(), networkMonitor: MockNetworkMonitor(isConnected: true))
}
