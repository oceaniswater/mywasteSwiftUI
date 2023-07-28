//
//  EditBinView.swift
//  my waste app
//
//  Created by Mark Golubev on 25/07/2023.
//

import SwiftUI

struct EditBinView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State var bin: Bin
    @StateObject var vm = EditBinViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("primary_bg")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    ImageBin(colorSelected: $bin.color)
                    Form {
                        Section {
                            ColorPicker(colorSelected: $bin.color)
                                .frame(height: 30)
                            TypePicker(typeSelected: $bin.type)
                                .frame(height: 30)
                        }
                        Section {
                            WeekdayList(selectedRows: $vm.selectedRows, days: $vm.days)
                                .frame(height: 30)
                                .onAppear {
                                    vm.makeSelectedRowSet(weekdays: bin.days)
                                }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    Button {
//                        vm.addBin()
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
                    .padding()
                    Button {
                        vm.deleteBin(at: bin.id)
                        dismiss()
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.red)
                                .frame(width: 355, height: 55)
                            .cornerRadius(10.0)
                            Text("Delete bin")
                                .foregroundColor(.white)
                        }
                            
                    }

                }
            }
        }
    }
}

//struct EditBinView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditBinView(bin: .constant(Bin(color: .black, type: .glass, days: [WeekDay(name: "Monday")])))
//    }
//}

struct ImageBinEdit: View {
    @Binding var colorSelected: BinColor
    var body: some View {
        Image(colorSelected.rawValue)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxHeight: 150)
            .padding()
    }
}

struct ColorPickerEdit: View {
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

struct TypePickerEdit: View {
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

struct WeekdayListEdit: View {
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

