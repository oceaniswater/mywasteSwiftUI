//
//  ContentView.swift
//  my waste app
//
//  Created by Mark Golubev on 24/07/2023.
//

import SwiftUI
import StoreKit

struct MainView: View {
    
    @State var showNotificationView: Bool = false
    
    @StateObject var vm: MainViewModel
    @EnvironmentObject var nm: NotificationManager
    
    var body: some View {
        ZStack {
            Color("primary_bg")
                .edgesIgnoringSafeArea(.all)
            VStack {
                if !nm.hasPermisions {
                    if vm.isNotificationBageShown {
                        NotificationBageView(isNotificationBageShown: $vm.isNotificationBageShown)
                            .frame(maxWidth: 500)
                    }
                }
                YourBinsHeaderView()
                    .frame(maxWidth: 500)
                BinsListView()
                    .frame(maxWidth: 500)

            }
            .environmentObject(vm)
            .onAppear {
                if UserDefaults.standard.bool(forKey: "notFirstTime") != true {
                    withAnimation {
                        showNotificationView = true
                    }
                }
                
                Task {
                    await nm.getAuthStatus()
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
            .environmentObject(NotificationManager())
    }
}

struct SettingsBarView: View {
    @EnvironmentObject var vm: MainViewModel
    @Binding var showSubscriptions: Bool
    
    var body: some View {
        HStack() {
            Spacer()
            Button {
                showSubscriptions.toggle()
            } label: {
                Image(systemName: "crown.fill")
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
                .font(.system(.title2, design: .rounded))
                .foregroundStyle(Color.white)
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
        .frame(maxWidth: 500)
        .padding(.horizontal)
    }
}

struct NotificationBageView: View {
    @Binding var isNotificationBageShown: Bool
    
    var body: some View {
        Button {
            Task {
                if let url = URL(string: UIApplication.openNotificationSettingsURLString) {
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
                    Text("The app will let you know when it’s time to take out the bins.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                }
                Spacer()
            }
            .padding(.all, 20)
            .background(Color("primary_cell"))
            .cornerRadius(10.0)


        }
        .padding(.all)
    }
}
