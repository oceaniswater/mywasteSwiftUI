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
    @StateObject var nm = NotificationManager()
    
    var body: some View {
            ZStack {
                Color("primary_bg")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    SettingsBarView()
                    if !nm.hasPermisions {
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
                
                Task {
                    await nm.getAuthStatus()
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
    @State var isAddBinPresented: Bool = false
    
    var body: some View {
        HStack {
            Text("Your Bins")
                .font(.title2)
                .foregroundColor(.white)
            Spacer()
            Button {
                vm.showAddBinView()
//                isAddBinPresented.toggle()
            } label: {
                Image(systemName: "plus")
                    .tint(Color("primary_elements"))
                    .padding()
                    .cornerRadius(10.0)
                    .font(.title2)
            }
        }
//        .sheet(isPresented: $isAddBinPresented, content: {
//            AddBinAssembley().build()
//        })
        .padding(.horizontal)
    }
}

struct NotificationBageView: View {
    @Binding var isNotificationBageShown: Bool
    
    var body: some View {
        Button {
            Task {
                if let url = URL(string: UIApplication.openNotificationSettingsURLString) {
                    // Ask the system to open that URL.
                    await UIApplication.shared.open(url)
                }
            }
            isNotificationBageShown = !isNotificationBageShown
        } label: {
            HStack(alignment: .top) {
                Image(systemName: "bell.badge.fill")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.all, 4)
                    .background(Color("primary_elements"))
                    .cornerRadius(10.0)
                Spacer()
                VStack(alignment: .leading, spacing: 4) {
                    Text("Enable push notifications")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("The app will notify you about the next day of collection")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        
                }
                Spacer()
                Button {
                    withAnimation {
                        isNotificationBageShown = !isNotificationBageShown
                    }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .tint(Color(.black))
                }
                
            }
            .padding(.all, 20)
            .background(Color("primary_cell"))
            .cornerRadius(10.0)
            .padding(.horizontal)
        }


    }
}


