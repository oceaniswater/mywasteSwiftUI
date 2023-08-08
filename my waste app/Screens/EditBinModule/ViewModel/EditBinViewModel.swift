//
//  EditBinViewModel.swift
//  my waste app
//
//  Created by Mark Golubev on 25/07/2023.
//

import Foundation

protocol EditBinViewModelProtocol: ObservableObject { }

final class EditBinViewModel: EditBinViewModelProtocol {
    @Published var days: [WeekDay] = Singleton.shared.weekdays
    @Published var selectedRows = Set<String>()
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func makeSelectedRowSet(weekdays: [String]) {
        selectedRows.removeAll()
        for day in weekdays {
            switch day {
            case "Sunday":
                selectedRows.insert("1")
            case "Monday":
                selectedRows.insert("2")
            case "Tuesday":
                selectedRows.insert("3")
            case "Wedensday":
                selectedRows.insert("4")
            case "Thursday":
                selectedRows.insert("5")
            case "Friday":
                selectedRows.insert("6")
            case "Saturday":
                selectedRows.insert("7")
            default:
                break
            }
        }
//        selectedRows = Set(weekdays.map({$0.id}))
    }
    
    func deleteBin(at id: String) {
        DataManager.deleteBin(binId: id) { error in
        }
    }
    
    func updateBin(bin: Bin) {
        var weekdays: [WeekDay] = []
        for row in selectedRows {
            for day in days {
                if day.id == row {
                    weekdays.append(day)
                }
            }
        }
        let days = weekdays.map({$0.name})
        
        DataManager.updateBin(binId: bin.id, newColor: bin.color, newType: bin.type, newDays: days) { error in
            print(error)
        }
    }
}
