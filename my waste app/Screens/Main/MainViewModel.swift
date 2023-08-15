//
//  MainViewModel.swift
//  my waste app
//
//  Created by Mark Golubev on 08/08/2023.
//

import Foundation

final class MainViewModel: ObservableObject {
    @Published var notificationEnabled: Bool = false
    @Published var isNotificationBageShown: Bool = true
    
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func showAddBinView() {
        self.router.showAddBin()
    }
    
    func showSettings() {
        self.router.showSettings()
    }
}
