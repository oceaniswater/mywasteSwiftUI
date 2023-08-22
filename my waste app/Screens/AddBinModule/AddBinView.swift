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
    @EnvironmentObject var store: SubscriptionStore
    @EnvironmentObject var nm: NotificationManager
    
    @Query private var bins: [Bin]
    @StateObject var vm: AddBinViewModel
    @State private var newBin = Bin(date: .now, type: .cardboard, color: .blue, selectDays: [])
    @State var showSubscriptions = false
    @State var showThanks = false
    
    var body: some View {
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
                        if !store.isUserHasSubscription() && bins.count == 2 {
                            showSubscriptions.toggle()
                        } else {
                            if newBin.selectDays.isEmpty {
                                vm.hasError = true
                            } else {
                                modelContext.insert(newBin)
                                Task {
                                    await vm.addNotification(newBin)
                                }
                                dismiss()
                            }
                            
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
            }
            .alert("You should chose at least one day of collection", isPresented: $vm.hasError) {
                Button("OK", role: .cancel) { }
            }
            .onAppear(perform: {
                self.vm.setup(nm)
            })
            .overlay(alignment: .bottom) {
                
                if showThanks {
                    ThanksView(didTapClose: {
                        showThanks.toggle()
                    })
                }
             
            }
            .overlay {
                        
                        if showSubscriptions {
                            Color.black.opacity(0.7)
                                .ignoresSafeArea()
                                .transition(.opacity)
                                .onTapGesture {
                                    showSubscriptions.toggle()
                                    
                                }
                            SubscriptionsView(title: "Unlock all app functions!", description: "Unlock all app functions. With subscriptions you will be able add unlimited amout of bins") {
                                showSubscriptions.toggle()
                            }
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                                .onDisappear(perform: {
                                    Task {
                                        await store.updateCurrentEntitlements()
                                    }
                                })
                        }
                    }
                    .animation(.spring(), value: showSubscriptions)
                    .animation(.spring(), value: showThanks)
                    .onChange(of: store.action) { action in
                                    
                        if action == .successful {
                            
                            showSubscriptions = false
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                
                                    showThanks.toggle()

                            }
                            
                            store.reset()
                        }
                        
                    }
                    .alert(isPresented: $store.hasError, error: store.error) { }
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
        ZStack {
            Color("primary_bg")
                .edgesIgnoringSafeArea(.all)
            List(Day.allCases, id: \.rawValue, selection: $selectedRows) {day in
                WeekdayRow(day: day, selectedItems: $selectedRows)
            }
            .listStyle(.automatic)
            .scrollContentBackground(.hidden)
        }
    }
}
