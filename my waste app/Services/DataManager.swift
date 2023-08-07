//
//  DataManager.swift
//  my waste app
//
//  Created by Mark Golubev on 26/07/2023.
//

import Foundation
import Firebase

struct FirebaseKeys {
    static let bins = "bins"
    static let notificationSettings = "notificationSettings"
    static let users = "users"
}

class DataManager {
    static func fetchBinsAndWeekdays(for userId: String, completion: @escaping ([Bin]) -> Void) {
        let db = Firestore.firestore()
        
        db.collection(FirebaseKeys.bins)
            .whereField("userId", isEqualTo: userId)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error fetching bins: \(error)")
                    completion([])
                    return
                }
                
                var bins: [Bin] = []
                
                guard let snap = querySnapshot else {
                    return }
                
                guard !snap.documents.isEmpty else {
                    completion(bins)
                    return }
                
                for document in snap.documents {
                    let binDTO = document.data()
                    guard let id = binDTO["id"] as? String,
                          let weekdays = binDTO["weekdays"] as? [String],
                          let colorRawValue = binDTO["color"] as? String,
                          let typeRawValue = binDTO["type"] as? String,
                          let color = BinColor(rawValue: colorRawValue),
                          let type = BinType(rawValue: typeRawValue) else {
                        // Skip this bin if any required fields are missing or invalid
                        continue
                    }
                    
                    let bin = Bin(id: id, color: color, type: type, days: weekdays)
                    bins.append(bin)
                    completion(bins)
                }
            }
        
    }
    
    static func addBin(bin: Bin, for userId: String, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        let ref = db
            .collection(FirebaseKeys.bins)
            .document()
        let documentID = ref.documentID
        
        let data = [
            "id": documentID,
            "color": bin.color.rawValue,
            "type": bin.type.rawValue,
            "userId": userId,
            "weekdays": bin.days
        ] as [String : Any]
        
        ref.setData(data, merge: true) { error in
            if let error = error {
                print(error)
                completion(error)
            }
            print("Shop added (v4)")
        }
    }
    
    static func deleteBin(binId: String, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        let binRef = db.collection(FirebaseKeys.bins).document(binId)
        
        binRef.delete { error in
            if let error = error {
                print("Error deleting bin: \(error)")
                completion(error)
                return
            }
            
            print("Bin deleted successfully")
            completion(nil)
        }
    }
    
    static func updateBin(binId: String, newColor: BinColor?, newType: BinType?, newDays: [String]?, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        let binRef = db.collection("bins").document(binId)
        
        var updateData: [String: Any] = [:]
        
        if let newColor = newColor {
            updateData["color"] = newColor.rawValue
        }
        
        if let newType = newType {
            updateData["type"] = newType.rawValue
        }
        
        if let newDays = newDays {
            updateData["weekdays"] = newDays
        }
        
        binRef.updateData(updateData) { error in
            if let error = error {
                completion(error)
                return
            }
            completion(nil)
        }
    }
    
    static func getNotificationSettings(forUserId userId: String, completion: @escaping (NotificationSettings?, Error?) -> Void) {
        let db = Firestore.firestore()
        
        let docRef = db.collection(FirebaseKeys.notificationSettings).document(userId)
        
        docRef.getDocument { (document, error) in
            if let error = error {
                print("Error getting notification settings: \(error)")
                completion(nil, error)
            } else {
                if let document = document, document.exists {
                    // Document exists and is not empty
                    if let data = document.data(),
                       let reminderTime = data["reminderTime"] as? String {
                        let notificationSettings = NotificationSettings(reminderTime: reminderTime)
                        completion(notificationSettings, nil)
                    } else {
                        // Required field "reminderTime" is missing or invalid
                        print("Invalid document data")
                        completion(nil, nil)
                    }
                } else {
                    // Document doesn't exist or is empty
                    print("Notification settings not found")
                    completion(nil, nil)
                }
            }
        }
    }
    
    static func setNotificationSettings(forUserId userId: String, withReminderTime reminderTime: String?, isActive: Bool, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection(FirebaseKeys.notificationSettings).document(userId)
        
        var data: [String: Any] = [
            "isActive": isActive
        ]
        if let reminderTime = reminderTime {
            data["reminderTime"] = reminderTime
        }
        
        docRef.setData(data, merge: true) { error in
            if let error = error {
                print("Error setting notification settings: \(error)")
                completion(error)
            } else {
                print("Notification settings set successfully")
                completion(nil)
            }
        }
    }
    
    static func setUser(forUserId userId: String, withFcmToken fcmToken: String?, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection(FirebaseKeys.users).document(userId)
        
        var data: [String: Any] = [
            "id": userId
        ]
        if let fcmToken = fcmToken {
            data["fcmToken"] = fcmToken
        }
        
        docRef.setData(data, merge: true) { error in
            if let error = error {
                print("Error setting notification settings: \(error)")
                completion(error)
            } else {
                print("Notification settings set successfully")
                completion(nil)
            }
        }
        
    }
    
}
