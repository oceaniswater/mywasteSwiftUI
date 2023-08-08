//
//  Bin.swift
//  my waste app
//
//  Created by Mark Golubev on 24/07/2023.
//

import Foundation

enum BinType: String, CaseIterable, Identifiable {
    case general, paper, glass, plastic, metal, cardboard, electronics, garden, organic, recycle
    
    var id: Self { self }
}

enum BinColor: String, CaseIterable, Identifiable {
    case green, red, blue, yellow, black, orange, brown, gray, purple, purple2, pink
    var id: Self { self }
}

struct Bin: Identifiable, Hashable {
    let id: String
    var color: BinColor
    var type: BinType
    var days: [String]
    
}
