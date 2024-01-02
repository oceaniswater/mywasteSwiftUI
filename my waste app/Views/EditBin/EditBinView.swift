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
    @Environment(NotificationManager.self) private var nm
    
    @Bindable var bin: Bin
    @StateObject var vm: EditBinViewModel
    @State var showAlertView = false
    
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

                            NavigationLink(vm.selectDays.isEmpty ? "Collection days" : vm.noteLabel) {
                                WeekdayList(selectedRows: $vm.selectDays, days: $vm.days)
                            }
                            .foregroundStyle(vm.selectDays.isEmpty ? Color(.textOne) : .gray)
                        
                            Toggle("Enable notifications", isOn: $vm.notifyMe)
                                .disabled(!nm.hasPermisions)
                                .onTapGesture {
                                    if nm.hasPermisions{
                                        vm.notifyMe.toggle()
                                    }
                                }
                            
                            if nm.hasPermisions && vm.notifyMe {
                                DatePicker("Time of notification", selection: $vm.date, displayedComponents: .hourAndMinute)
                                NotifyDayToggleView(atTheSameDay: $vm.atTheSameDay, atTheDayBefore: $vm.atTheDayBefore)
                            }
                            if !nm.hasPermisions {
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
                        if vm.selectDays.isEmpty {
                            vm.hasError = true
                        } else {
                            bin.color = vm.color
                            bin.type = vm.type
                            bin.date = vm.date
                            bin.atTheSameDay = vm.atTheSameDay
                            bin.atTheDayBefore = vm.atTheDayBefore
                            bin.selectDays = vm.selectDays
                            bin.notifyMe = vm.notifyMe
                            
                            if bin.notifyMe {
                                Task {
                                    await vm.updateNotifications(bin: bin)
                                }
                            } else {
                                Task {
                                    await vm.deleteNotifications(for: bin)
                                }
                            }

                            dismiss()
                        }
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(maxWidth: 500)
                                .frame(height: 55)
                                .cornerRadius(10.0)
                            Text("Save")
                                .foregroundColor(.white)
                                .font(.system(.title3, design: .rounded))
                        }
                            
                    }
                    .padding()
                }
            }
            .onAppear(perform: {
                vm.setup(nm)
                Task {
                    await nm.getAuthStatus()
                }
            })
            .alert(message: "You should choose at least one collection day.", isPresented: $vm.hasError)
            .alert(title: "Why is it disabled?", message: "You should allow Notifications in your app Settings.", dismissButton: AlertButton(title: "Settings", color: Color("primary_elements"), action: {
                Task {
                    if let url = URL(string: UIApplication.openNotificationSettingsURLString) {
                        await UIApplication.shared.open(url)
                    }
                }
            }), isPresented: $showAlertView)
    }
}

struct EditBinView_Previews: PreviewProvider {
    static var previews: some View {
        EditBinAssembley().build(for: Bin(date: .now, type: .cardboard, color: .blue, selectDays: [.Fri]))
            .environment(NotificationManager())
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

