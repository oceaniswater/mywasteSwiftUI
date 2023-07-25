//
//  BinsListViewModel.swift
//  my waste app
//
//  Created by Mark Golubev on 25/07/2023.
//

import Foundation

protocol BinsListViewModelProtocol {
    func getBinsList()
    func deleteBin(at offsets: IndexSet)
}

final class BinsListViewModel: ObservableObject, BinsListViewModelProtocol {
    @Published var bins: [Bin] = []
    func getBinsList() {
        bins = Singleton.shared.getBins()
    }
    
    func deleteBin(at offsets: IndexSet) {
        Singleton.shared.deleteBin(at: offsets)
    }
    
}
