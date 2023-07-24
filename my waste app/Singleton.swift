//
//  Singleton.swift
//  my waste app
//
//  Created by Mark Golubev on 24/07/2023.
//

import Foundation

final class Singleton {
    static let shared = Singleton()
    private init() {}
    private var bins = [Bin(color: .red, type: .glass, days: ["Mon"]), Bin(color: .green, type: .general, days: ["Tue", "Fri"]), Bin(color: .blue, type: .paper, days: ["Mon"] ), Bin(color: .green, type: .metal, days: ["Tue", "Fri"])]
    func getBins() -> [Bin] {
        return bins
    }
}
