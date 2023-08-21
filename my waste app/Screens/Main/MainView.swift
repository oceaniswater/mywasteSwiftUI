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
    @StateObject var nm = NotificationManager()
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
            .overlay(alignment: .bottom) {
                
                if showThanks {
                    
//                    VStack(spacing: 8) {
//                        
//                        Text("Thank You 💕")
//                            .foregroundStyle(Color.white)
//                            .font(.system(.title2, design: .rounded).bold())
//                            .multilineTextAlignment(.center)
//                        
//                        Text("Now you have ability to use all power of this app. In the future we gonna add more fetures into it. And you will use it for free too.")
//                            .foregroundStyle(Color.gray)
//                            .font(.system(.body, design: .rounded))
//                            .multilineTextAlignment(.center)
//                            .padding(.bottom, 16)
//                        
//                        Button {
//                            showThanks.toggle()
//                        } label: {
//                            Text("Close")
//                                .font(.system(.title3, design: .rounded).bold())
//                                .tint(.white)
//                                .frame(height: 55)
//                                .frame(maxWidth: .infinity)
//                                .background(.blue, in: RoundedRectangle(cornerRadius: 10,
//                                                                        style: .continuous))
//
//                        }
//                    }
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
                            cardVw
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

private extension MainView {
    
    var cardVw: some View {
                
            VStack(spacing: 8) {
                
                HStack {
                    Spacer()
                    Button {
                        showSubscriptions.toggle()
                    } label: {
                        
                        Image(systemName: "xmark")
                            .symbolVariant(.circle.fill)
                            .font(.system(.largeTitle, design: .rounded).bold())
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.gray, .gray.opacity(0.2))
                    }
                }
                
                Text("Unlock all app functions!")
                    .foregroundStyle(.white)
                    .font(.system(.title2, design: .rounded).bold())
                    .multilineTextAlignment(.center)
                
                
                Text("Unlock all app functions. All subscriptions goes with 1 week free trial. Try. Enjoy. Cancel any time in Apple Subscriptions.")
                    .foregroundStyle(.gray)
                    .font(.system(.body, design: .rounded))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 16)
                
                ForEach(store.items) { item in
                    configureProductVw(item)
                }
                
                Text(!store.purchasedNonConsumables.isEmpty ? "You already has subscription" : "")
                    .foregroundStyle(.gray)
                    .font(.system(.body, design: .rounded))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 16)
                
                Button("Restore purchase") {
                    Task {
                        try? await store.restore()
                    }
                }
                .foregroundStyle(Color("primary_elements").opacity(0.6))
                .padding(.bottom, 16)
                
            }
            .padding(16)
            .background(Color("primary_bg"), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            .padding(8)
            .overlay(alignment: .top) {
                Image("logo")
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .frame(width: 60, height: 60)
                //                .padding(2)
                //                .background(Color.accentColor, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .offset(y: -25)
            }
        
    }
    
    func configureProductVw(_ item: Product) -> some View {
        
        HStack {
            
            VStack(alignment: .leading,
                   spacing: 3) {
                Text(item.displayName)
                    .font(.system(.title3, design: .rounded).bold())
                    .foregroundStyle(.white)
                Text(item.description)
                    .font(.system(.callout, design: .rounded).weight(.regular))
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            Button(item.displayPrice) {
                Task {
                    await store.purchase(item)
                }
            }
            .tint((Color("primary_elements")))
            .buttonStyle(.bordered)
            .font(.callout.bold())
        }
        .padding(16)
        .background(Color("primary_cell"),
                    in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        
    }
}
