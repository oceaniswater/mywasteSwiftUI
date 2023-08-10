//
//  Route.swift
//  my waste app
//
//  Created by Mark Golubev on 02/08/2023.
//

import Foundation
import SwiftUI

enum Route: Hashable {
    
//    case editBin
    case addBin
    case settings
}

final class Router: ObservableObject {
    static let shared = Router()

    @Published var path = [Route]()
    
    func showEditBin(bin: Bin) {
//        path.append(.editBin(bin))
    }

    func showAddBin() {
        path.append(.addBin)
    }
    
    func showSettings() {
        path.append(.settings)
    }
    
    func backToRoot() {
        path.removeAll()
    }
    
    func back() {
        path.removeLast()
    }
}
