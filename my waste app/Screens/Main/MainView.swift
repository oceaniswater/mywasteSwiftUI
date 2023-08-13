//
//  ContentView.swift
//  my waste app
//
//  Created by Mark Golubev on 24/07/2023.
//

import SwiftUI

struct MainView: View {

    @State var showSettingsScreen: Bool = false
    @State var showNotificationView: Bool = false
    
    @StateObject var vm: MainViewModel
    
    var body: some View {
            ZStack {
                Color("primary_bg")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    SettingsBarView()
                    if !vm.notificationEnabled {
                        if vm.isNotificationBageShown {
                            NotificationBageView(isNotificationBageShown: $vm.isNotificationBageShown)
                        }
                    }
                    YourBinsHeaderView()
                    BinsListView()
                }
            }
            .environmentObject(vm)
            .onAppear {
                let l = UserDefaults.standard.bool(forKey: "notFirstTime")
                if UserDefaults.standard.bool(forKey: "notFirstTime") != true {
                    withAnimation {
                        showNotificationView = true
                    }
                }
            }
            .fullScreenCover(isPresented: $showNotificationView) {
                NotificationView(showNotificationView: $showNotificationView)
                
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainAssembley().build()
    }
}

struct SettingsBarView: View {
    @EnvironmentObject var vm: MainViewModel

    var body: some View {
        HStack() {
            Spacer()
            Button {
                vm.showSettings()
            } label: {
                Image(systemName: "gear")
                    .font(.title2)
                    .tint(Color("primary_elements"))
                    .padding()
                    .cornerRadius(10.0)
            }
            
        }
        .padding(.horizontal)
    }
}

struct YourBinsHeaderView: View {
    @EnvironmentObject var vm: MainViewModel
    
    var body: some View {
        HStack {
            Text("Your Bins")
                .font(.title2)
                .foregroundColor(.white)
            Spacer()
            Button {
                vm.showAddBinView()
            } label: {
                Image(systemName: "plus")
                    .tint(Color("primary_elements"))
                    .padding()
                    .cornerRadius(10.0)
                    .font(.title2)
            }
        }
        .padding(.horizontal)
    }
}

struct NotificationBageView: View {
    @Binding var isNotificationBageShown: Bool
    
    var body: some View {
        HStack(alignment: .top, content: {
            Image(systemName: "bell.badge.fill")
                .font(.title2)
                .foregroundColor(.white)
                .padding(.all, 4)
                .background(Color("primary_elements"))
                .cornerRadius(10.0)
            Spacer()
            VStack(alignment: .leading, content: {
                Text("Enable push notification")
                    .font(.headline)
                    .foregroundColor(.white)
                Text("The application will notify you  about the waste date")
                    .foregroundColor(.gray)
            })
            Button {
                withAnimation {
                    isNotificationBageShown = !isNotificationBageShown
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .tint(Color(.black))
            }
            
        })
        .padding(.all, 20)
        .background(Color("primary_cell"))
        .cornerRadius(10.0)
        .padding(.horizontal)
    }
}


