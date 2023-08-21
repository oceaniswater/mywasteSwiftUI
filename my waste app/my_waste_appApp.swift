//
//  my_waste_appApp.swift
//  my waste app
//
//  Created by Mark Golubev on 24/07/2023.
//

import SwiftUI
import UserNotifications
import NotificationCenter

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self
                
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.sound, .badge, .banner, .list]
    }
}

@main
struct my_waste_appApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var store = SubscriptionStore()
    @ObservedObject var router = Router.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                MainAssembley().build()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .addBin:
                            AddBinAssembley().build()
                        case .settings:
                            SettingsAssembley().build()
                        case .editBin(let bin):
                            EditBinAssembley().build(for: bin)
                        }
                        
                    }
            }
            .environmentObject(store)
        }
        .modelContainer(for: Bin.self)

    }
}
