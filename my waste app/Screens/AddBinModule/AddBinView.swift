//
//  AddBinView.swift
//  my waste app
//
//  Created by Mark Golubev on 24/07/2023.
//

import SwiftUI

struct AddBinView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm: AddBinViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("primary_bg")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    ImageBin(colorSelected: $vm.colorSelected, typeSelected: $vm.typeSelected)
                    Form {
                        Section {
                            ColorPicker(colorSelected: $vm.colorSelected)
                                .frame(height: 30)
                            TypePicker(typeSelected: $vm.typeSelected)
                                .frame(height: 30)
                        }
                        Section {
                            DatePicker("Time", selection: $vm.selectedDate, displayedComponents: .hourAndMinute)

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
        AddBinAssembley().build()
    }
}

struct ImageBin: View {
    @Binding var colorSelected: BinColor
    @Binding var typeSelected: BinType
    
    var body: some View {
        ZStack {
            Image(colorSelected.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
            .frame(maxHeight: 150)
            Image(typeSelected.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 55)
        }
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
    @Binding var selectedRows: Set<Day>
    @Binding var days: Day.AllCases
    
    var body: some View {
        List(Day.allCases, id: \.rawValue, selection: $selectedRows) {day in
            WeekdayRow(day: day, selectedItems: $selectedRows)
        }
        .listStyle(.automatic)
        .scrollContentBackground(.hidden)
    }
}
