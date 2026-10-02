//
//  EnvironmentKeys.swift
//  DevPulse
//
//  Created by Nikhil Rastogi on 9/24/26.
//

import Foundation
import SwiftUI

private struct DependencyContainerKey: EnvironmentKey {
    static let defaultValue: DependencyContainer = .live
}

public extension EnvironmentValues {
    var dependencies: DependencyContainer {
        get { self[DependencyContainerKey.self] }
        set { self[DependencyContainerKey.self] = newValue }
    }
}
