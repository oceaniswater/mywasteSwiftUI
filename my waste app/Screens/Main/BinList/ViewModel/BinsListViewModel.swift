//
//  BinsListViewModel.swift
//  my waste app
//
//  Created by Mark Golubev on 25/07/2023.
//

import Foundation

protocol BinsListViewModelProtocol: ObservableObject {
//    func getBinsList()
//    func deleteBin(at id: String)
//    func editBin(at offsets: IndexSet)
}

final class BinsListViewModel:  BinsListViewModelProtocol {
    
    func editBin(at offsets: IndexSet) {
        //
    }
    
    @Published var bins: [Bin] = []
    @Published  var isEmptyList: Bool = true
    var router = Router.shared
    
    func getBinsList() {
//        DataManager.fetchBinsAndWeekdays(for: UserDefaults.standard.string(forKey: "userId") ?? "") { bins in
//            self.bins = bins
        bins = Singleton.shared.getBins()
//        }
    }
    
    func deleteBin(at id: String) {
//        DataManager.deleteBin(binId: id) { error in
//            print(error)
//        }
    }
    
    func isEmpty() {
//        isEmptyList = bins.isEmpty
    }
        
    func showEditBin(bin: Bin) {
        self.router.showEditBin(bin: bin)
    }
}
