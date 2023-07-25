//
//  BinsListView.swift
//  my waste app
//
//  Created by Mark Golubev on 25/07/2023.
//

import SwiftUI

struct BinsListView: View {
    @StateObject var vm = BinsListViewModel()

    var body: some View {
        List {
            ForEach ($vm.bins) { $bin in
                BinCellView(bin: $bin)
                    .listRowBackground(Color("primary_bg"))
                    .listRowSeparator(.hidden, edges: .all)
            }
            .onDelete(perform: vm.deleteBin)

        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .onAppear {
            vm.getBinsList()
        }
    }
}

struct BinListView_Previews: PreviewProvider {
    static var previews: some View {
        BinsListView()
    }
}
