//
//  BinsListViewModel.swift
//  my waste app
//
//  Created by Mark Golubev on 25/07/2023.
//

import Foundation

protocol BinsListViewModelProtocol: ObservableObject {
    func getBinsList()
    func deleteBin(at id: String)
    func editBin(at offsets: IndexSet)
}

final class BinsListViewModel:  BinsListViewModelProtocol {
    func editBin(at offsets: IndexSet) {
        //
    }
    
    @Published var bins: [Bin] = []
    func getBinsList() {
        DataManager.fetchBinsAndWeekdays(for: "01968288-7A95-4417-B2E6-D585DE49C18C") { bins in
            self.bins = bins
        }
    }
    
    func deleteBin(at id: String) {
        DataManager.deleteBin(binId: id) { error in
            print(error)
        }
    }
    
    func isEmpty() -> Bool {
        return bins.isEmpty
    }
}
