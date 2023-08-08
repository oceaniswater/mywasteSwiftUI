//
//  SettingsView.swift
//  my waste app
//
//  Created by Mark Golubev on 31/07/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm: SettingsViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("primary_bg")
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    Text("Settings")
                        .font(.largeTitle)
                        .frame(alignment: .leading)
                        .foregroundColor(.white)
                        .padding()
                    Form {
                        Section {
                            Toggle("Notifications", isOn: $vm.isNotificationEnabled)
                                .disabled(vm.isNotificationEnabled)
                        }
                        Section {
                            DatePicker("Time", selection: $vm.selectedDate, displayedComponents: .hourAndMinute)
                        }
                        .onAppear {
                            Task {
                                vm.getDate()
                            }
                        }
                        
                        Button("Log out") {
                            Task {
                                do {
                                    try await vm.signOut()
                                    UserDefaults.standard.removeObject(forKey: "userId")
                                    vm.backToRoot()
                                } catch {
                                    
                                }
                            }
                        }
                        Button("Save") {
                            Task {
                                try vm.saveSettings()
                                dismiss()
                            }
                        }
                        .foregroundColor(.red)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsAssembley().build()
    }
}
