//
//  AddBinViewModel.swift
//  my waste app
//
//  Created by Mark Golubev on 25/07/2023.
//

import Foundation
import SwiftUI

protocol AddBinViewModelProtocol {
//    func addNotification(_ bin: Bin)
//    func isBinExist(bin: Bin) -> Bool
}

final class AddBinViewModel: ObservableObject, AddBinViewModelProtocol {
        
    @Published var selectedRows = Set<Day>()
    @Published var days = Day.allCases
    @Published var selectedDate = Date()
    @Published var hasError: Bool = false
    
    var nm: NotificationManager?
    
    func setup(_ nm: NotificationManager) {
        self.nm = nm
    }
    
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func addNotification(_ bin: Bin) async {
        await nm?.addNotificationRequest(bin: bin)
    }
    
    func isBinExist(bin: Bin) -> Bool {
        //
        return false
    }
}
