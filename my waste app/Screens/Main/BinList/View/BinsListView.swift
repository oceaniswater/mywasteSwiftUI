//
//  BinsListView.swift
//  my waste app
//
//  Created by Mark Golubev on 25/07/2023.
//

import SwiftUI
import SwiftData

struct BinsListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var bins: [Bin]
    @StateObject var vm = BinsListViewModel()
    @State var selectedBin: Bin?
    
    var body: some View {
        Group {
            if !bins.isEmpty {
                List {
                    ForEach(bins) { bin in
                        BinCellView(bin: bin)
                            .onTapGesture {
                                selectedBin = bin
                            }
                        
                    }
                    .onDelete(perform: deleteItems)
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
        .sheet(item: $selectedBin, content: {bin in
                EditBinAssembley().build(for: bin)
        })
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let bin = bins[index]
                // delete notification
                
                // delete bin
                modelContext.delete(bins[index])
            }
        }
    }
}

struct BinListView_Previews: PreviewProvider {
    static var previews: some View {
        BinsListView()
    }
}
