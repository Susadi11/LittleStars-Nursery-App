//
//  Item.swift
//  Little Stars Nursery App
//
//  Created by Susadi on 2026-03-24.
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
