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
    
    @Published var selectedRows = Set<Day>()
    @Published var days = Day.allCases
    @Published var selectedDate = Date()
    
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func addBin() {
        let bin = Bin(date: selectedDate, type: typeSelected, color: colorSelected, selectDays: selectedRows)
        UserNotification.shared.addNotificationRequest(bin: bin)
        UserNotification.shared.check(bin.id.uuidString)
        
        Singleton.shared.addBin(bin: bin)
    }
    
    func isBinExist(bin: Bin) -> Bool {
        //
        return false
    }
}
