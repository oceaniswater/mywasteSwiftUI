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
    
    
    let current = UNUserNotificationCenter.current()
    let content = UNMutableNotificationContent()
    
    func addNotificationRequest(bin: Bin) async {
        
        content.title = "Waste collection day soon!"
        content.body = "Don't forget take out your \(bin.type.rawValue.capitalized(with: .current)) waste bin"
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: bin.date)
        let minute = calendar.component(.minute, from: bin.date)
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        if bin.remindDays.isEmpty {
            await triggerRequest(dateComponents: dateComponents, bin: bin, isRepeat: false)
        } else {
            for weekday in bin.remindDays.map(\.componentWeekday) {
                dateComponents.weekday = weekday
                await self.triggerRequest(dateComponents: dateComponents, bin: bin)
                
            }
        }
    }
    
    func triggerRequest(dateComponents: DateComponents, bin: Bin, isRepeat: Bool = true) async {
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isRepeat)
        let request = UNNotificationRequest(identifier: bin.id.uuidString + String(describing: dateComponents.weekday), content: content, trigger: trigger)
        do {
            try await current.add(request)
            print("successfully")
        } catch {
            print("error")
        }
    }
    
    func check(_ id: String?) {
        if let id = id {
            UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
                let isScheduled = requests.contains { $0.identifier == id }
                if isScheduled {
                    print("Notification is scheduled.")
                } else {
                    print("Notification is not scheduled.")
                }
            }
        } else {
            UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
                let d = requests.count
                dump(requests)
            }
        }
    }
    
    func removeNotification(id: String) async {
        var ids: [String] = []
        let requests = await UNUserNotificationCenter.current().pendingNotificationRequests()
        for request in requests {
            if request.identifier.hasPrefix(id) {
                ids.append(request.identifier)
            }
        }
        await withThrowingTaskGroup(of: Void.self) { group in
            for id in ids {
                group.addTask {
                    self.current.removeDeliveredNotifications(withIdentifiers: [id])
                    self.current.removePendingNotificationRequests(withIdentifiers: [id])
                }
            }
        }
        
        
        //        UNUserNotificationCenter.current().getPendingNotificationRequests { [weak self] requests in
        //            for request in requests {
        //                if request.identifier.hasPrefix(id) {
        //                    ids.append(request.identifier)
        //                }
        //            }
        //            self?.current.removeDeliveredNotifications(withIdentifiers: ids)
        //            self?.current.removePendingNotificationRequests(withIdentifiers: ids)
        //        }
        
        
    }
    
    func removeAllNot() {
        current.removeAllDeliveredNotifications()
        current.removeAllPendingNotificationRequests()
    }
    
    func updateNotification(for bin: Bin) async {
        var ids: [String] = []
        let requests = await UNUserNotificationCenter.current().pendingNotificationRequests()
        for request in requests {
            if request.identifier.hasPrefix(bin.id.uuidString) {
                ids.append(request.identifier)
            }
        }
        self.current.removeDeliveredNotifications(withIdentifiers: ids)
        self.current.removePendingNotificationRequests(withIdentifiers: ids)
        await self.addNotificationRequest(bin: bin)
    }
}
