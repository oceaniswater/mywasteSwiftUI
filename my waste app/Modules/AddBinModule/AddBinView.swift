//
//  AddBinView.swift
//  my waste app
//
//  Created by Mark Golubev on 24/07/2023.
//

import SwiftUI

struct AddBinView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm = AddBinViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("primary_bg")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    ImageBin(colorSelected: $vm.colorSelected)
                    Form {
                        Section {
                            ColorPicker(colorSelected: $vm.colorSelected)
                                .frame(height: 30)
                            TypePicker(typeSelected: $vm.typeSelected)
                                .frame(height: 30)
                        }
                        Section {
                            WeekdayList(selectedRows: $vm.selectedRows, days: $vm.days)
                                .frame(height: 30)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    Button {
                        vm.addBin()
                        dismiss()
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 355, height: 55)
                            .cornerRadius(10.0)
                            Text("Add bin")
                                .foregroundColor(.white)
                        }
                            
                    }

                }
            }
        }
    }
}

struct AddBinView_Previews: PreviewProvider {
    static var previews: some View {
        AddBinView()
    }
}

struct ImageBin: View {
    @Binding var colorSelected: BinColor
    var body: some View {
        Image(colorSelected.rawValue)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxHeight: 150)
            .padding()
    }
}

struct ColorPicker: View {
    @Binding var colorSelected: BinColor
    var body: some View {
        List {
            Picker("Color", selection: $colorSelected) {
                ForEach(BinColor.allCases) { bin in
                    Text(bin.rawValue)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .frame(height: 80)
    }
}

struct TypePicker: View {
    @Binding var typeSelected: BinType
    var body: some View {
        List {
            Picker("Type", selection: $typeSelected) {
                ForEach(BinType.allCases) { bin in
                    Text(bin.rawValue)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .frame(height: 80)
    }
}

struct WeekdayList: View {
    @Binding var selectedRows: Set<String>
    @Binding var days: [WeekDay]
    
    var body: some View {
        List(selection: $selectedRows) {
            ForEach(days) { day in
                WeekdayRow(weekday: day, selectedItems: $selectedRows)
                    
            }
        }
        .listStyle(.automatic)
        .scrollContentBackground(.hidden)
    }
}
