//
//  BinInfo.swift
//  my waste app
//
//  Created by Mark Golubev on 10/08/2023.
//

import Foundation
import UserNotifications

enum BinType: String, CaseIterable, Identifiable, Codable {
    case general, paper, glass, plastic, metal, cardboard, electronics, garden, organic, recycle
    
    var id: Self { self }
}

enum BinColor: String, CaseIterable, Identifiable, Codable {
    case green, red, blue, yellow, black, orange, brown, gray, purple, purple2, pink
    var id: Self { self }
}

struct Bin: Codable, Identifiable {
    
    var id = UUID()
    var date: Date = Date()
    var type: BinType = .cardboard
    var color: BinColor = .red
    
    
    var note:String = "Alarm"
    var noteLabel:String{
        var days: [String] = []
        for day in selectDays {
            days.append(day.dayText)
        }
        return days.joined(separator: ", ")
    }
    
//    var isOn: Bool = true {
//        didSet{
//            if isOn{
//                UserNotification.shared.addNotificationRequest(bin: self)
//            }else{
//                // 刪除推播
//                UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["\(self.id.uuidString)"])
//                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["\(self.id.uuidString)"])
//            }
//        }
//    }
    
    var selectDays:Set<Day> = []
    
    var isEdit = false
    
    var repeatDay:String{
        switch selectDays{
        case [.Sat, .Sun]:
            return "Weekend"
        case [.Sun, .Mon, .Tue, .Wed, .Thu, .Fri, .Sat]:
            return "Every day"
        case [.Mon, .Tue, .Wed, .Thu, .Fri]:
            return "Weekdays"
        case []:
            return "Never"
        default:
            let day = selectDays.sorted(by: {$0.rawValue < $1.rawValue}).map{$0.dayText}.joined(separator: " ")
            return day
        }
    }
}


