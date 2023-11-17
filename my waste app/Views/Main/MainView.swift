//
//  ContentView.swift
//  my waste app
//
//  Created by Mark Golubev on 24/07/2023.
//

import SwiftUI
import StoreKit
import SwiftData

struct MainView: View {
    
    @State var showNotificationView: Bool = false
    @State var showNotificationBage: Bool = false
    @State var showReviewAlert: Bool = false
    
    @StateObject var vm: MainViewModel
    @Environment(NotificationManager.self) private var nm
    @Environment(RequestsReviewManager.self) private var requestsReviewManager
    
    @Query private var bins: [Bin]
    
    var body: some View {
        ZStack {
            Color("primary_bg")
                .edgesIgnoringSafeArea(.all)
            VStack {
                nm.hasPermisions
                    ? nil
                    : NotificationBageView(didTapClose: {
                    })
                    .frame(maxWidth: 500)
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
                
                requestsReviewManager.increase()
                
                if requestsReviewManager.canAskForReview(binsCount: bins.count) {
                    // try getting current scene
                    guard let currentScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                          return
                    }
                         
                    // show review dialog
                    SKStoreReviewController.requestReview(in: currentScene)
                }
                
                Task {
                    await nm.getAuthStatus()
                    withAnimation {
                        if !nm.hasPermisions {
                            showNotificationBage = true
                        } else {
                            showNotificationBage = false
                        }
                    }
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
            .environment(NotificationManager())
            .environment(RequestsReviewManager())
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
            .offset(x: 15)
        }
        .frame(maxWidth: 500)
        .padding(.horizontal)
    }
}


