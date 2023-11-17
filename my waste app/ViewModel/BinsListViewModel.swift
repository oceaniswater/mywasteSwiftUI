//
//  BinsListViewModel.swift
//  my waste app
//
//  Created by Mark Golubev on 25/07/2023.
//

import SwiftUI


protocol BinsListViewModelProtocol: ObservableObject {

}

final class BinsListViewModel:  BinsListViewModelProtocol {
    @Published var isEmptyList: Bool = true
    @Published var bins: [Bin] = []
    
    var nm: NotificationManager?
    
    var router = Router.shared
    
    func setup(_ nm: NotificationManager) {
        self.nm = nm
    }
    
    func deleteNotifications(for id: String) async {
        await nm?.removeNotification(id: id)
    }
        
    func showEditBin(bin: Bin) {
        self.router.showEditBin(bin: bin)
    }
}
