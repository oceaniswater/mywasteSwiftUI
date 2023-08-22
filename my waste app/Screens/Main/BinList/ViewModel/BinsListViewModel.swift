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
    @Published  var isEmptyList: Bool = true
    
    var nm: NotificationManager?
    
    var router = Router.shared
    
    func setup(_ nm: NotificationManager) {
        self.nm = nm
    }
    
    func editBin(at offsets: IndexSet) {
        //
    }
    
    func deleteNotifications(for id: String) async {
        await nm?.removeNotification(id: id)
    }
    
    func isEmpty() {
//        isEmptyList = bins.isEmpty
    }
        
    func showEditBin(bin: Bin) {
        self.router.showEditBin(bin: bin)
    }
}
