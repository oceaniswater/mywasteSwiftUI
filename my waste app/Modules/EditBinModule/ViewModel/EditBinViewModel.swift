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
    
    deinit {
        print("EditBinViewModel deinit")
    }
}
