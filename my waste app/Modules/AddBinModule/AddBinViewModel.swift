//
//  AddBinViewModel.swift
//  my waste app
//
//  Created by Mark Golubev on 25/07/2023.
//

import Foundation

protocol AddBinViewModelProtocol {
    func addBin()
    func isBinExist(bin: Bin) -> Bool
}

final class AddBinViewModel: ObservableObject, AddBinViewModelProtocol {
    
    @Published var colorSelected: BinColor = .red
    @Published var typeSelected: BinType = .glass
    
    @Published var selectedRows = Set<String>()
    @Published var days: [WeekDay] = Singleton.shared.weekdays
    
    let userId = UserDefaults.standard.string(forKey: "userId")
    
    func addBin() {
        var weekdays: [WeekDay] = []
        for row in selectedRows {
            for day in days {
                if day.id == row {
                    weekdays.append(day)
                }
            }
        }
        let days = weekdays.map({$0.name})
        let id = UUID()
        let bin = Bin(id: "\(id)", color: colorSelected, type: typeSelected, days: days)
        
        DataManager.addBin(bin: bin, for: userId ?? "") { error in
            print(error)
        }
    }
    
    func isBinExist(bin: Bin) -> Bool {
        //
        return false
    }
}
