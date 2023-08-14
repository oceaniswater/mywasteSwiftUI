//
//  BinsListViewModel.swift
//  my waste app
//
//  Created by Mark Golubev on 25/07/2023.
//

import Foundation

protocol BinsListViewModelProtocol: ObservableObject {

}

final class BinsListViewModel:  BinsListViewModelProtocol {
    
    func editBin(at offsets: IndexSet) {
        //
    }

    @Published  var isEmptyList: Bool = true
    
    var router = Router.shared
    
    func getBinsList() {
//        DataManager.fetchBinsAndWeekdays(for: UserDefaults.standard.string(forKey: "userId") ?? "") { bins in
//            self.bins = bins
//        bins = Singleton.shared.getBins()
//        }
    }
    
    func deleteNotifications(for id: String) {
        UserNotification.shared.removeNotification(id: id)
        UserNotification.shared.check(id)
    }
    
    func isEmpty() {
//        isEmptyList = bins.isEmpty
    }
        
    func showEditBin(bin: Bin) {
        self.router.showEditBin(bin: bin)
    }
}
