import Foundation
import UserNotifications
import SwiftData

enum BinType: String, CaseIterable, Identifiable, Codable {
    case general, paper, glass, plastic, metal, cardboard, electronics, garden, organic, recycle
    
    var id: Self { self }
}

enum BinColor: String, CaseIterable, Identifiable, Codable {
    case green, red, blue, yellow, black, orange, brown, gray, indigo, purple, pink
    var id: Self { self }
}

@Model
class Bin: Identifiable {
    
    @Attribute(.unique) var id: UUID
    var date: Date
    var type: BinType
    var color: BinColor
    
    var noteLabel: String {
        var days: [Day] = []
        for day in selectDays {
            days.append(day)
        }
        days.sort(by: { $0.componentWeekday < $1.componentWeekday})
        return days.map(\.dayText).joined(separator: ", ")
    }
    var selectDays: Set<Day>
    var notifyMe: Bool
    var atTheSameDay: Bool
    var atTheDayBefore: Bool
    var remindDays: Set<Day> {
        if atTheSameDay {
            return selectDays
        } else {
            var remindSet: Set<Day> = []
            for selectDay in selectDays {
                if selectDay.componentWeekday > 1 {
                    let day = selectDay.componentWeekday - 1
                    switch day {
                    case 0:
                        remindSet.insert(.Sun)
                    case 1:
                        remindSet.insert(.Mon)
                    case 3:
                        remindSet.insert(.Tue)
                    case 4:
                        remindSet.insert(.Wed)
                    case 5:
                        remindSet.insert(.Thu)
                    case 6:
                        remindSet.insert(.Fri)
                    default:
                        continue
                    }
                } else {
                    remindSet.insert(.Sat)
                }
            }
            return remindSet
        }

    }
    
    init(id: UUID = UUID(), date: Date, type: BinType, color: BinColor, selectDays: Set<Day>, notifyMe: Bool = true, atTheSameDay: Bool = false, atTheDayBefore: Bool = true) {
        self.id = id
        self.date = date
        self.type = type
        self.color = color
        self.selectDays = selectDays
        self.notifyMe = notifyMe
        self.atTheSameDay = atTheSameDay
        self.atTheDayBefore = atTheDayBefore
    }
}
