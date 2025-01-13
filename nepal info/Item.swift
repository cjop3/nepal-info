//
//  Item.swift
//  nepal info
//
//  Created by Deepak Kandel on 1/13/2025.
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
