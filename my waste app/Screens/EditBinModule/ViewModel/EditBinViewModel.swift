//
//  EditBinViewModel.swift
//  my waste app
//
//  Created by Mark Golubev on 25/07/2023.
//

import Foundation

protocol EditBinViewModelProtocol: ObservableObject { }

final class EditBinViewModel: EditBinViewModelProtocol {
    @Published var selectedRows = Set<Day>()
    @Published var days = Day.allCases
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func updateNotifications(bin: Bin) {
        UserNotification.shared.updateNotification(for: bin)
        
    }
}
