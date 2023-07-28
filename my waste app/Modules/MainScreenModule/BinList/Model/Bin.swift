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

struct Bin: Identifiable, Hashable {
    let id: String
    var color: BinColor
    var type: BinType
    var days: [String]
    
}
