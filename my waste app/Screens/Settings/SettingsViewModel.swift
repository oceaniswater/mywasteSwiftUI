//
//  SettingsViewModel.swift
//  my waste app
//
//  Created by Mark Golubev on 31/07/2023.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var isNotificationEnabled: Bool = false
    @Published var selectedDate = Date()
    let nm = NotificationManager()
    private let router: Router
    
    init(router: Router) {
        self.router = router
        
        Task {
            await nm.getAuthStatus()
            isNotificationEnabled = nm.hasPermisions
        }
    }
    
    func signOut() throws {
//        try AuthenticationManager.shared.signOut()
    }
    
    func saveSettings() throws {
//        DataManager.setNotificationSettings(forUserId: UserDefaults.standard.string(forKey: "userId") ?? "", withReminderTime: selectedDate.description, isActive: isNotificationEnabled) { error in
//            //
//        }
    }
    
    func getDate() {
//        DataManager.getNotificationSettings(forUserId: UserDefaults.standard.string(forKey: "userId") ?? "") { settings, error in
//            if let error = error {
//                //
//            } else {
//                guard let settings = settings else { return }
//                // Create a DateFormatter instance
//                let dateFormatter = DateFormatter()
//
//                // Set the date format to match the input string
//                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
//                
//                if let date = dateFormatter.date(from: settings.reminderTime) {
//                    // The conversion was successful, and 'date' is now a Date object
//                    print("Converted Date: \(date)")
//                    self.selectedDate = date
//                } else {
//                    // The conversion failed
//                    print("Invalid date string")
//                }
//                
//                
//            }
//        }
    }
    
    func isNotificationsEnabled() {
        
    }
    
    func backToRoot() {
        self.router.backToRoot()
    }
}
