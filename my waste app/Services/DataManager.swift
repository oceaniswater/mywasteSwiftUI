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
}
