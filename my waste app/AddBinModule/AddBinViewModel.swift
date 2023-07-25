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
    
    @Published var selectedRows = Set<UUID>()
    @Published var days: [WeekDay] = Singleton.shared.weekdays
    
    func addBin() {
        var weekdays: [WeekDay] = []
        for id in selectedRows {
            for day in days {
                if day.id == id {
                    weekdays.append(day)
                }
            }
        }
        let bin = Bin(color: colorSelected, type: typeSelected, days: weekdays)
        Singleton.shared.addBin(bin: bin)
    }
    
    func isBinExist(bin: Bin) -> Bool {
        //
        return false
    }
    
}
