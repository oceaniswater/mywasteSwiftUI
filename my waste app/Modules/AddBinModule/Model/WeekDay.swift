//
//  WeekDay.swift
//  my waste app
//
//  Created by Mark Golubev on 24/07/2023.
//

import Foundation

class WeekDay: Identifiable, Hashable {
    static func == (lhs: WeekDay, rhs: WeekDay) -> Bool {
        lhs.id == rhs.id
    }
    
    var id = UUID()
    let name: String
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
    
    func hash(into hasher: inout Hasher) {
        // Combine the hash values of the properties using the Hasher
        hasher.combine(id)
        hasher.combine(name)
    }
}
