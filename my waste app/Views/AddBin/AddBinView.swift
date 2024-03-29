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
    @Environment(NotificationManager.self) private var nm
    
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
                        TypePicker(typeSelected: $newBin.type)
                        
                        NavigationLink(newBin.selectDays.isEmpty ? "Collection days" : newBin.noteLabel) {
                            WeekdayList(selectedRows: $newBin.selectDays, days: $vm.days)
                        }
                        .foregroundStyle(newBin.selectDays.isEmpty ? Color(.textOne) : .gray)
                        
                        Toggle("Enable notifications", isOn: $newBin.notifyMe)
                            .disabled(!nm.hasPermisions)
                            .onTapGesture {
                                if nm.hasPermisions{
                                    newBin.notifyMe.toggle()
                                }
                            }
                        
                        if nm.hasPermisions && newBin.notifyMe {
                            DatePicker("Time of notifications", selection: $newBin.date, displayedComponents: .hourAndMinute)
                                .clipShape(RoundedRectangle(cornerRadius: 10.00))
                            NotifyDayToggleView(atTheSameDay: $newBin.atTheSameDay, atTheDayBefore: $newBin.atTheDayBefore)
                        }
                        if !nm.hasPermisions && !newBin.notifyMe {
                            Button("Why is it disabled?") {
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
                            .font(.system(.title3, design: .rounded))
                    }
                    
                }
                .padding()
                
            }
        }
        .alert(message: "You should choose at least one collection day.", isPresented: $vm.hasError)
        .alert(title: "Why is it disabled?", message: "You should allow Notifications in your app Settings.", dismissButton: AlertButton(title: "Settings", color: Color("primary_elements"), action: {
            Task {
                if let url = URL(string: UIApplication.openNotificationSettingsURLString) {
                    await UIApplication.shared.open(url)
                }
            }
        }), isPresented: $showAlertView)
        .onAppear(perform: {
            self.vm.setup(nm)
            Task {
                await nm.getAuthStatus()
                newBin.notifyMe = nm.hasPermisions
            }
        })
    }
}


struct AddBinView_Previews: PreviewProvider {
    static var previews: some View {
        AddBinAssembley().build()
            .environment(NotificationManager())
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
