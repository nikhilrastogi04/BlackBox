//
//  Item.swift
//  DevPulse
//
//  Created by Nikhil Rastogi on 9/20/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
