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
    @ObservedObject var viewModel: RootViewModel
    
    @ObservedObject var mainViewModel = MainViewModel()

    
    var body: some View {
        ZStack {
            Color("primary_bg")
            
            if !showLoginView && !showNotificationView {
                MainView()
                    .environmentObject(mainViewModel)
            }
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showLoginView = authUser == nil
        }
        .fullScreenCover(isPresented: $showLoginView) {
            LoginView(showLoginScreen: $showLoginView, showNotificationView: $showNotificationView)

        }
        .fullScreenCover(isPresented: $showNotificationView) {
            NotificationView(showNotificationView: $showNotificationView)

        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootAssembly().build()
            .environmentObject(BinsListViewModel())
    }
}
