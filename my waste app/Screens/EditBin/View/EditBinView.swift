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
                        }
                        
                        Section {
                            NavigationLink(vm.selectDays.isEmpty ? "Set collection days" : vm.noteLabel) {
                                WeekdayList(selectedRows: $vm.selectDays, days: $vm.days)
                            }
                        }
                        
                        Section {
                            Toggle("Notify me", isOn: $vm.notifyMe)
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
                            
                            Task {
                                await vm.updateNotifications(bin: bin)
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
                        }
                            
                    }
                }
            }
            .onAppear(perform: {
                vm.setup(nm)
                Task {
                    await nm.getAuthStatus()
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
            .alert("You should set at least one collection day.", isPresented: $vm.hasError) {
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
