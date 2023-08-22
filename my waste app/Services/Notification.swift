//
//  Notification.swift
//  my waste app
//
//  Created by Mark Golubev on 10/08/2023.
//

import Foundation
import UserNotifications
import AVFoundation


class UserNotification{
    
    static let shared = UserNotification()
    
    let current = UNUserNotificationCenter.current()
    let content = UNMutableNotificationContent()
    
    func addNotificationRequest(bin: Bin) {

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
            triggerRequest(dateComponents: dateComponents, bin: bin, isRepeat: false)
        } else {
            let weekdays = bin.remindDays.map { $0.componentWeekday }
            weekdays.forEach { weekDay in
                dateComponents.weekday = weekDay
                triggerRequest(dateComponents: dateComponents, bin: bin)
            }
        }
    }
    
    func triggerRequest(dateComponents: DateComponents, bin: Bin, isRepeat: Bool = true) {
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isRepeat)
        let request = UNNotificationRequest(identifier: bin.id.uuidString + String(describing: dateComponents.weekday), content: content, trigger: trigger)
        current.add(request) { error in
            if(error == nil){
                print("successfully")
            }else{
                print("error")
            }
        }
    }
    
    func check(_ id: String?) {
        if let id = id {
            UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
                let isScheduled = requests.contains { $0.identifier == id }
                let d = requests.count
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
    
    func removeNotification(id: String) {
        var ids: [String] = []
        UNUserNotificationCenter.current().getPendingNotificationRequests { [weak self] requests in
            for request in requests {
                if request.identifier.hasPrefix(id) {
                    ids.append(request.identifier)
                }
            }
            self?.current.removeDeliveredNotifications(withIdentifiers: ids)
            self?.current.removePendingNotificationRequests(withIdentifiers: ids)
        }
        

    }
    
    func removeAllNot() {
        current.removeAllDeliveredNotifications()
        current.removeAllPendingNotificationRequests()
    }
    
    func updateNotification(for bin: Bin) {
        var ids: [String] = []
        UNUserNotificationCenter.current().getPendingNotificationRequests { [weak self] requests in
            for request in requests {
                if request.identifier.hasPrefix(bin.id.uuidString) {
                    ids.append(request.identifier)
                }
            }
            self?.current.removeDeliveredNotifications(withIdentifiers: ids)
            self?.current.removePendingNotificationRequests(withIdentifiers: ids)
            self?.addNotificationRequest(bin: bin)
        }
    }

}


