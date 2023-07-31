//
//  my_waste_appApp.swift
//  my waste app
//
//  Created by Mark Golubev on 24/07/2023.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct my_waste_appApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    let binsListViewModel = BinsListViewModel()
    
    var body: some Scene {
        WindowGroup {
//                if let _ = UserDefaults.standard.string(forKey: "userId") {
//                    ContentView()
//                        .environmentObject(binsListViewModel)
//                } else {
//                    LoginView()
//                }
            RootView()
        }
    }
}
