//
//  Item.swift
//  ShoppingList
//
//  Created by Abdurrahman Ardac on 2025-03-02.
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
