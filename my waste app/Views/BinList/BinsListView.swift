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
    @Environment(NotificationManager.self) private var nm
    
    @Query private var bins: [Bin]
    @StateObject var vm = BinsListViewModel()
    
    var body: some View {
        Group {
            if !bins.isEmpty {
                List {
                    ForEach(bins) { bin in
                        BinCellView(bin: bin)
                            .environmentObject(vm)
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
                Text("Click “+” to add your first bin")
                    .foregroundStyle(Color.gray)
                    .frame(height: 35.0)
                    .offset(y: 60.0)
                Spacer()
                Spacer()
                Spacer()
            }
            
        }
        .onAppear {
            vm.setup(nm)
        }
    }
}

struct BinListView_Previews: PreviewProvider {
    static var previews: some View {
        BinsListView()
            .environment(NotificationManager())
    }
}
