//
//  RootView.swift
//  my waste app
//
//  Created by Mark Golubev on 31/07/2023.
//

import SwiftUI

struct RootView: View {
    @State var showLoginView: Bool = false
    @State var showNotificationView: Bool = false
//    let binsListVeiwModel = BinsListViewModel()
    
    var body: some View {
        ZStack {
            Color("primary_bg")
            
            if !showLoginView && !showNotificationView {
                NavigationStack {
                    ContentView()
//                        .environmentObject(binsListVeiwModel)
                }
            }
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showLoginView = authUser == nil
        }
        .fullScreenCover(isPresented: $showLoginView) {
            NavigationView {
                LoginView(showLoginScreen: $showLoginView, showNotificationView: $showNotificationView)
            }
        }
        .fullScreenCover(isPresented: $showNotificationView) {
            NavigationView {
                NotificationScreenView(showNotificationView: $showNotificationView)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(BinsListViewModel())
    }
}
