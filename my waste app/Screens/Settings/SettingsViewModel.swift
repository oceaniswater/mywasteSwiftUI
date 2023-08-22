//
//  SettingsViewModel.swift
//  my waste app
//
//  Created by Mark Golubev on 31/07/2023.
//

import Foundation


final class SettingsViewModel: ObservableObject {
    
    @Published var isNotificationEnabled: Bool = false
    @Published var selectedDate = Date()
//    let nm = NotificationManager()
    private let router: Router
    
    init(router: Router) {
        self.router = router
        
//        Task {
//            if let date = UserDefaults.standard.value(forKey: "notificationTime") {
//                selectedDate = date as! Date
//            }
//            isNotificationEnabled = nm.hasPermisions
//        }
    }
    
    func saveSettings() {
//        UserDefaults.standard.setValue(selectedDate, forKey: "notificationTime")
    }
    
    func isNotificationsEnabled() {
        
    }
    
    func backToRoot() {
        self.router.backToRoot()
    }
}
