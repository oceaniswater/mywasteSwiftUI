//
//  Route.swift
//  my waste app
//
//  Created by Mark Golubev on 02/08/2023.
//

import Foundation

enum Route: Hashable {
    case mainScreen(bins: Bin)
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
    
    static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs, rhs) {
        case (.mainScreen(bins: let lhsItem), .mainScreen(bins: let rhsItem)):
            return lhsItem.id == rhsItem.id
        }
    }
}
