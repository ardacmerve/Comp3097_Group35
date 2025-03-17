//
//  ShoppingItem.swift
//  ShoppingList
//
//  Created by Abdurrahman Ardac on 2025-03-02.
//

import Foundation

struct ShoppingItem: Identifiable, Codable {
    let id: UUID
    var name: String
    var category: String
    var price: Double
    var tax: Double
    var isPurchased: Bool

    init(name: String, category: String, price: Double, tax: Double, isPurchased: Bool = false) {
        self.id = UUID()
        self.name = name
        self.category = category
        self.price = price
        self.tax = tax
        self.isPurchased = isPurchased
    }
}


