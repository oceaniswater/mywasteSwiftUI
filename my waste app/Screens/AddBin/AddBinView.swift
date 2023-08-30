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
    @EnvironmentObject var nm: NotificationManager
    
    @StateObject var vm: AddBinViewModel
    @State private var newBin = Bin(date: .now, type: .cardboard, color: .blue, selectDays: [])
    @State var showAlertView = false
    
    var body: some View {
        ZStack {
            Color("primary_bg")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing:0) {
                ImageBin(colorSelected: $newBin.color, typeSelected: $newBin.type)
                
                Form {
                    Section {
                        ColorPicker(colorSelected: $newBin.color)
                            .frame(height: 30)
                        TypePicker(typeSelected: $newBin.type)
                            .frame(height: 30)
                    }
                    
                    Section {
                        NavigationLink(newBin.selectDays.isEmpty ? "Set collection days" : newBin.noteLabel) {
                            WeekdayList(selectedRows: $newBin.selectDays, days: $vm.days)
                        }
                    }
                    
                    Section {
                        Toggle("Notify me", isOn: $newBin.notifyMe)
                            .disabled(!nm.hasPermisions)
                            .onTapGesture {
                                if nm.hasPermisions{
                                    newBin.notifyMe.toggle()
                                }
                            }
                        
                        if nm.hasPermisions && newBin.notifyMe {
                            DatePicker("Time of notification", selection: $newBin.date, displayedComponents: .hourAndMinute)
                                .clipShape(RoundedRectangle(cornerRadius: 10.00))
                            NotifyDayToggleView(atTheSameDay: $newBin.atTheSameDay, atTheDayBefore: $newBin.atTheDayBefore)
                        }
                        if !nm.hasPermisions && !newBin.notifyMe {
                            Button("Why it is disabled?") {
                                showAlertView = true
                            }
                            .foregroundStyle(Color("primary_elements"))
                            .frame(height: 35.0)
                            .font(.system(.body, design: .rounded))
                        }
                    }
                }
                .frame(maxWidth: 500)
                .scrollContentBackground(.hidden)
                
                
                Button {
                    if newBin.selectDays.isEmpty {
                        vm.hasError = true
                    } else {
                        modelContext.insert(newBin)
                        if nm.hasPermisions {
                            Task {
                                await vm.addNotification(newBin)
                            }
                        }
                        dismiss()
                    }
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(height: 55)
                            .frame(maxWidth: 500)
                            .cornerRadius(10.0)
                        Text("Save")
                            .foregroundColor(.white)
                    }
                    
                }
                .padding()
                
            }
        }
        .alert("You should set at least one collection day.", isPresented: $vm.hasError) {
            Button("OK", role: .cancel) { }
        }
        .onAppear(perform: {
            self.vm.setup(nm)
            Task {
                await nm.getAuthStatus()
                newBin.notifyMe = nm.hasPermisions
            }
            

        })
        .overlay(alignment: .bottom) {
            
            if showAlertView {
                Color.black.opacity(0.7)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture {
                        showAlertView.toggle()
                        Task {
                            await nm.getAuthStatus()
                        }
                        
                    }
                AlertView(didTapClose: {
                    showAlertView.toggle()
                    Task {
                        await nm.getAuthStatus()
                    }
                })
            }
            
        }
        .animation(.spring(), value: showAlertView)
    }
}


struct AddBinView_Previews: PreviewProvider {
    static var previews: some View {
        AddBinAssembley().build()
            .environmentObject(NotificationManager())
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
            Picker("Colour", selection: $colorSelected) {
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
        ZStack {
            Color("primary_bg")
                .edgesIgnoringSafeArea(.all)
            List(Day.allCases, id: \.rawValue, selection: $selectedRows) {day in
                WeekdayRow(day: day, selectedItems: $selectedRows)
            }
            .frame(maxWidth: 500)
            .listStyle(.automatic)
            .scrollContentBackground(.hidden)
        }
    }
}
