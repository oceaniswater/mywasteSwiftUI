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
//    @EnvironmentObject var store: SubscriptionStore
    @EnvironmentObject var nm: NotificationManager
    
//    @Query private var bins: [Bin]
    @StateObject var vm: AddBinViewModel
    @State private var newBin = Bin(date: .now, type: .cardboard, color: .blue, selectDays: [])
//    @State var showSubscriptions = false
//    @State var showThanks = false
    
    var body: some View {
        ZStack {
            Color("primary_bg")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing:20) {
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
                        DatePicker("Time of notification", selection: $newBin.date, displayedComponents: .hourAndMinute)
                            .clipShape(RoundedRectangle(cornerRadius: 10.00))
                        NotifyDayToggleView(atTheSameDay: $newBin.atTheSameDay, atTheDayBefore: $newBin.atTheDayBefore)
                    }
                }
                .scrollContentBackground(.hidden)
                
                
                
                Button {
//                    if !store.isUserHasSubscription() && bins.count == 2 {
//                        showSubscriptions.toggle()
//                    } else {
                        if newBin.selectDays.isEmpty {
                            vm.hasError = true
                        } else {
                            modelContext.insert(newBin)
                            Task {
                                await vm.addNotification(newBin)
                            }
                            dismiss()
                        }
                        
//                    }
                    
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
        .alert("You should set at least one collection day.", isPresented: $vm.hasError) {
            Button("OK", role: .cancel) { }
        }
        .onAppear(perform: {
            self.vm.setup(nm)
        })
//        .overlay(alignment: .bottom) {
//            
//            if showThanks {
//                ThanksView(didTapClose: {
//                    showThanks.toggle()
//                })
//            }
//            
//        }
//        .overlay {
//            
//            if showSubscriptions {
//                Color.black.opacity(0.7)
//                    .ignoresSafeArea()
//                    .transition(.opacity)
//                    .onTapGesture {
//                        showSubscriptions.toggle()
//                        
//                    }
//                SubscriptionsView(title: "Need an extra bin?", description: "Getting a subscription will let you add any amount of bins and stay in full control of your waste.") {
//                    showSubscriptions.toggle()
//                }
//                .transition(.move(edge: .bottom).combined(with: .opacity))
//                .onDisappear(perform: {
//                    Task {
//                        await store.updateCurrentEntitlements()
//                    }
//                })
//            }
//        }
//        .animation(.spring(), value: showSubscriptions)
//        .animation(.spring(), value: showThanks)
//        .onChange(of: store.action) { action in
//            
//            if action == .successful {
//                
//                showSubscriptions = false
//                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                    
//                    showThanks.toggle()
//                    
//                }
//                
//                store.reset()
//            }
//            
//        }
//        .alert(isPresented: $store.hasError, error: store.error) { }
    }
}


struct AddBinView_Previews: PreviewProvider {
    static var previews: some View {
        AddBinAssembley().build()
            .environmentObject(NotificationManager())
//            .environmentObject(SubscriptionStore())
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
            .listStyle(.automatic)
            .scrollContentBackground(.hidden)
        }
    }
}
