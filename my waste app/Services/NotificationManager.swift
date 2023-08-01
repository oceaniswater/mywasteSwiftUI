//
//  NotificationManager.swift
//  my waste app
//
//  Created by Mark Golubev on 01/08/2023.
//

import Foundation
import UserNotifications

@MainActor
class NotificationManager: ObservableObject {
    
    @Published private(set) var hasPermisions: Bool = false 
    
    init() {
        Task {
            await getAuthStatus()
        }
    }
    
    func request() async {
        do {
            self.hasPermisions = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
        } catch {
            print(error)
        }
        
    }
    
    func getAuthStatus() async {
        let status = await UNUserNotificationCenter.current().notificationSettings()
        switch status.authorizationStatus {
        case .authorized, .provisional, .ephemeral:
            hasPermisions = true
        default:
            hasPermisions = false
        }
    }
}
