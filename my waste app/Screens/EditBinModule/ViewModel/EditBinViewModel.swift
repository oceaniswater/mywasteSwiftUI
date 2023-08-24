//
//  EditBinViewModel.swift
//  my waste app
//
//  Created by Mark Golubev on 25/07/2023.
//

import Foundation

protocol EditBinViewModelProtocol: ObservableObject { }

final class EditBinViewModel: EditBinViewModelProtocol {
    @Published var selectedRows = Set<Day>()
    @Published var days = Day.allCases
    
    @Published var color: BinColor
    @Published var type: BinType
    @Published var date: Date
    @Published var atTheSameDay: Bool
    @Published var atTheDayBefore: Bool
    @Published var selectDays: Set<Day>
    
    @Published var hasError: Bool = false
    
    var nm: NotificationManager?
    
    func setup(_ nm: NotificationManager) {
        self.nm = nm
    }
    
    private let router: Router
    
    init(router: Router, bin: Bin) {
        self.router = router
        self.color = bin.color
        self.type = bin.type
        self.date = bin.date
        self.atTheSameDay = bin.atTheSameDay
        self.atTheDayBefore = bin.atTheDayBefore
        self.selectDays = bin.selectDays
    }
    
    func updateNotifications(bin: Bin) async {
        await nm?.updateNotification(for: bin)
        
    }
}
