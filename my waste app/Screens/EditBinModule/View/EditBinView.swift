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
    @EnvironmentObject var nm: NotificationManager
    
    @Bindable var bin: Bin
    @StateObject var vm: EditBinViewModel
    
    var body: some View {

            ZStack {
                Color("primary_bg")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    ImageBin(colorSelected: $vm.color, typeSelected: $vm.type)
                    Form {
                        Section {
                            ColorPicker(colorSelected: $vm.color)
                                .frame(height: 30)
                            TypePicker(typeSelected: $vm.type)
                                .frame(height: 30)
                        }
                        Section {
                            DatePicker("Time", selection: $vm.date, displayedComponents: .hourAndMinute)
                            Toggle("At day of collecton", isOn: $vm.atTheSameDay)
                        }
                        NavigationLink("Collection days") {
                            WeekdayList(selectedRows: $vm.selectDays, days: $vm.days)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    Button {
                        if vm.selectDays.isEmpty {
                            vm.hasError = true
                        } else {
                            bin.color = vm.color
                            bin.type = vm.type
                            bin.date = vm.date
                            bin.atTheSameDay = vm.atTheSameDay
                            bin.selectDays = vm.selectDays
                            
                            Task {
                                await vm.updateNotifications(bin: bin)
                            }
                            dismiss()
                        }
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
            .onAppear(perform: {
                vm.setup(nm)
            })
            .alert("You should chose at least one day of collection", isPresented: $vm.hasError) {
                Button("OK", role: .cancel) { }
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

