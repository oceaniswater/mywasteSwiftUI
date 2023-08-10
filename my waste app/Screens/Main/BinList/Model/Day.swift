//
//  Day.swift
//  my waste app
//
//  Created by Mark Golubev on 10/08/2023.
//

import Foundation

enum Day:Int, Codable, CaseIterable{
    case Sun = 0,Mon,Tue,Wed,Thu,Fri,Sat
    
    var dayString:String{
        switch self {
            case .Sun: return "Sunday"
            case .Mon: return "Monday"
            case .Tue: return "Tuesday"
            case .Wed: return "Wednesday"
            case .Thu: return "Thursday"
            case .Fri: return "Friday"
            case .Sat: return "Saturday"
        }
    }
    
    var dayText:String{
        switch self {
            case .Sun: return "Sun"
            case .Mon: return "Mon"
            case .Tue: return "Tue"
            case .Wed: return "Wed"
            case .Thu: return "Thu"
            case .Fri: return "Fri"
            case .Sat: return "Sat"
        }
    }
    
    var componentWeekday: Int {
        switch self {
            case .Sun: return 1
            case .Mon: return 2
            case .Tue: return 3
            case .Wed: return 4
            case .Thu: return 5
            case .Fri: return 6
            case .Sat: return 7
        }
    }
    
}
