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
    @Published var selectedRows = Set<UUID>()
    
    func makeSetUUID(weekdays: [WeekDay]) {
        selectedRows = Set(weekdays.map({$0.id}))
    }
    
    deinit {
        print("EditBinViewModel deinit")
    }
}
