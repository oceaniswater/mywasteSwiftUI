//
//  AddBinView.swift
//  my waste app
//
//  Created by Mark Golubev on 24/07/2023.
//

import SwiftUI
import SwiftData

struct AddBinView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @StateObject var vm: AddBinViewModel
    @State private var newBin = Bin(date: .now, type: .cardboard, color: .blue, selectDays: [])
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("primary_bg")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    ImageBin(colorSelected: $newBin.color, typeSelected: $newBin.type)
                    Form {
                        Section {
                            ColorPicker(colorSelected: $newBin.color)
                                .frame(height: 30)
                            TypePicker(typeSelected: $newBin.type)
                                .frame(height: 30)
                        }
                        Section {
                            DatePicker("Time reminder", selection: $newBin.date, displayedComponents: .hourAndMinute)
                            Toggle("At day of collecton", isOn: $newBin.atTheSameDay)
                        }

                        NavigationLink("Collection days") {
                                WeekdayList(selectedRows: $newBin.selectDays, days: $vm.days)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    Button {
                        modelContext.insert(newBin)
                        //                        vm.addNotification(newBin)
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
    }
}
