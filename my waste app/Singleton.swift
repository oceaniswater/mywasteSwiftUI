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
//        let bin = Bin(color: bin.color, type: bin.type, days: bin.days)
//        self.bins.append(bin)
    }
    
    func deleteBin(at offsets: IndexSet) {
        self.bins.remove(atOffsets: offsets)
    }
    
    func editBin(at offsets: IndexSet, bin: Bin) {
        
    }
//    let weekdays: [WeekDay] = []
    let weekdays = [WeekDay(id: "1", name: "Sunday"), WeekDay(id: "2", name: "Monday"), WeekDay(id: "3", name: "Tuesday"), WeekDay(id: "4", name: "Wedensday"), WeekDay(id: "5", name: "Thursday"), WeekDay(id: "6", name: "Friday"), WeekDay(id: "7", name: "Saturday")]
}
