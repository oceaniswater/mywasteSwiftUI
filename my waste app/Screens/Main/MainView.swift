//
//  ContentView.swift
//  my waste app
//
//  Created by Mark Golubev on 24/07/2023.
//

import SwiftUI
import StoreKit

struct MainView: View {

    @State var showSettingsScreen: Bool = false
    @State var showNotificationView: Bool = false
    @State var showSubscriptions: Bool = false
    @State var showThanks: Bool = false
    
    @StateObject var vm: MainViewModel
    @EnvironmentObject var nm: NotificationManager
    @EnvironmentObject var store: SubscriptionStore
    
    var body: some View {
            ZStack {
                Color("primary_bg")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    SettingsBarView(showSubscriptions: $showSubscriptions)

                    if !nm.hasPermisions {
                        if vm.isNotificationBageShown {
                            NotificationBageView(isNotificationBageShown: $vm.isNotificationBageShown)
                        }
                    }
                    YourBinsHeaderView()
                    BinsListView()
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
                            SubscriptionsView(title: "Unlock all app functions!", description: "Unlock all app functions. All subscriptions goes with 1 week free trial. Try. Enjoy. Cancel any time in Apple Subscriptions.") {
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
        
            .fullScreenCover(isPresented: $showNotificationView) {
                NotificationView(showNotificationView: $showNotificationView)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainAssembley().build()
            .environmentObject(SubscriptionStore())
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
    @State var isAddBinPresented: Bool = false
    
    var body: some View {
        HStack {
            Text("Your Bins")
                .font(.system(.title2, design: .rounded))
                .foregroundStyle(Color.white)
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
                        .multilineTextAlignment(.leading)
                        
                }
                Spacer()
                Button {
                    withAnimation {
                        isNotificationBageShown = !isNotificationBageShown
                    }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.gray, .gray.opacity(0.2))
                }
                
            }
            .padding(.all, 20)
            .background(Color("primary_cell"))
            .cornerRadius(10.0)
            .padding(.horizontal)
        }


    }
}
