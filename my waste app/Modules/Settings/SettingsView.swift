//
//  SettingsView.swift
//  my waste app
//
//  Created by Mark Golubev on 31/07/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var vm = SettingsViewModel()
    @Binding var showSettingsScreen: Bool
    @State var showRoot: Bool = false
    
    var body: some View {
        ZStack {
            Color("primary_bg")
                .ignoresSafeArea()
            VStack {
                Text("Settings")
                    .font(.largeTitle)
                    .frame(alignment: .leading)
                    .foregroundColor(.white)
                List {
                    Text("Notifications")
                    Text("Time")
                }
                Button("Log out") {
                    Task {
                        do {
                            try await vm.signOut()
                            UserDefaults.standard.removeObject(forKey: "userId")
                            self.showSettingsScreen = false
                        } catch {
                            
                        }
                    }
                }
                Spacer()
                Button("Back") {
                    withAnimation {
                        showSettingsScreen = false
                    }
                }
                .foregroundColor(.red)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSettingsScreen: .constant(true))
    }
}
