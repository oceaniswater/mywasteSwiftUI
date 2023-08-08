//
//  my_waste_appApp.swift
//  my waste app
//
//  Created by Mark Golubev on 24/07/2023.
//

import SwiftUI
import FirebaseCore
import UserNotifications
import FirebaseMessaging

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        application.registerForRemoteNotifications()
        
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
//    For getting deep link from push notification
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
//        if let deepLink = response.notification.request.content.userInfo["link"] as? String {
//
//        }
//    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.sound, .badge, .banner, .list]
    }
}

extension AppDelegate: MessagingDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        guard let userId = UserDefaults.standard.string(forKey: "userId") else { return }
        DataManager.setUser(forUserId: userId, withFcmToken: deviceToken.description) { error in
            //
        }
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        #if DEBUG
        print("FCM Token: \(fcmToken)")
        #endif
    }
}

@main
struct my_waste_appApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    let binsListViewModel = BinsListViewModel()
    @ObservedObject var router = Router.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                RootAssembly().build()
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
        }
    }
}
