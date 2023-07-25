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
    private var bins: [Bin] = []
    func getBins() -> [Bin] {
        return bins
    }
    func addBin(bin: Bin) {
        let bin = Bin(color: bin.color, type: bin.type, days: bin.days)
        self.bins.append(bin)
    }
    
    func deleteBin(at offsets: IndexSet) {
        self.bins.remove(atOffsets: offsets)
    }
    
    let weekdays = [WeekDay(name: "Sunday"), WeekDay(name: "Monday"), WeekDay(name: "Tuesday"), WeekDay(name: "Wedensday"), WeekDay(name: "Thursday"), WeekDay(name: "Friday"), WeekDay(name: "Saturday")]
}
