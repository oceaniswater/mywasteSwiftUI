//
//  EditBinView.swift
//  my waste app
//
//  Created by Mark Golubev on 25/07/2023.
//

import SwiftUI

struct EditBinView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Bindable var bin: Bin
    @StateObject var vm: EditBinViewModel
    
    var body: some View {

            ZStack {
                Color("primary_bg")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    ImageBin(colorSelected: $bin.color, typeSelected: $bin.type)
                    Form {
                        Section {
                            ColorPicker(colorSelected: $bin.color)
                                .frame(height: 30)
                            TypePicker(typeSelected: $bin.type)
                                .frame(height: 30)
                        }
                        Section {
                            DatePicker("Time", selection: $bin.date, displayedComponents: .hourAndMinute)
                            Toggle("At day of collecton", isOn: $bin.atTheSameDay)
                        }
                        NavigationLink("Collection days") {
                                WeekdayList(selectedRows: $bin.selectDays, days: $vm.days)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    Button {
                        try? modelContext.save()
                        vm.updateNotifications(bin: bin)
                        dismiss()
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 355, height: 55)
                                .cornerRadius(10.0)
                            Text("Save")
                                .foregroundColor(.white)
                        }
                            
                    }
                }
//                .onChange(of: bin.selectDays) { oldValue, newValue in
//                    // change notifications!
//                    if !newValue.isEmpty {
//                        vm.updateNotifications(bin: bin)
//                    }
//                    
//                }
//                
//                .onChange(of: bin.date) { oldValue, newValue in
//                    // change notifications!
//                    vm.updateNotifications(bin: bin)
//                }
            }

    }
}

struct EditBinView_Previews: PreviewProvider {
    static var previews: some View {
        EditBinAssembley().build(for: Bin(date: .now, type: .cardboard, color: .blue, selectDays: [.Fri]))
    }
}

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

