//
//  Bin.swift
//  my waste app
//
//  Created by Mark Golubev on 24/07/2023.
//

import Foundation

enum BinType: String, CaseIterable, Identifiable {
    case general = "General waste"
    case paper = "Paper waste"
    case glass = "Glass waste"
    case plastic = "Plastic waste"
    case metal = "Metal waste"
    
    var id: Self { self }
}

enum BinColor: String, CaseIterable, Identifiable {
    case green, red, blue, yellow, black, orange
    var id: Self { self }
}

class Bin: Identifiable, Hashable {
    static func == (lhs: Bin, rhs: Bin) -> Bool {
        lhs.id == rhs.id
    }
    
    let id = UUID()
    var color: BinColor
    var type: BinType
    var days: [WeekDay]
    
    init(color: BinColor, type: BinType, days: [WeekDay]) {
        self.color = color
        self.type = type
        self.days = days
    }
    
    func hash(into hasher: inout Hasher) {
        // Combine the hash values of the properties using the Hasher
        hasher.combine(id)
        hasher.combine(color)
        hasher.combine(type)
        hasher.combine(days)
    }
}
