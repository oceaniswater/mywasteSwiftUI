//
//  FillRandomiser.swift
//  my waste app
//
//  Created by Mark Golubev on 17/11/2023.
//

import Foundation

enum Fill: String, CaseIterable {
    case blue_b
    case violet_b
    case orange_b
    case red_b
    case teal_b
    case yellow_b
}

struct FillRandomiser {
    static func getRandomFill() -> Fill {
        let randomValue = Int.random(in: 0..<Fill.allCases.count)
        return Fill.allCases[randomValue]
    }
}
