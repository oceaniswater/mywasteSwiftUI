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
        Group {
            if !vm.bins.isEmpty {
                List {
                    ForEach(vm.bins) { bin in
                        BinCellView(bin: bin)
                            .onTapGesture {
                                vm.showEditBin(bin: bin)
                            }
                    }
                    .listRowSeparator(.hidden, edges: .all)
                    .listRowBackground(Color("primary_bg"))
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            } else {
                Spacer()
                Text("Add your first bin")
                Spacer()
                Spacer()
                Spacer()
            }

        }
        .onAppear {
            withAnimation {
                vm.getBinsList()
            }
            
        }
    }
    
}

//struct BinListView_Previews: PreviewProvider {
//    static var previews: some View {
//        BinsListView(path: .constant(NavigationPath()))
//    }
//}