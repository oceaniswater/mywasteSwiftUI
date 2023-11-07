//
//  RequestsReviewManager.swift
//  my waste app
//
//  Created by Mark Golubev on 07/11/2023.
//

import SwiftUI

@Observable
final class RequestsReviewManager {
    
    @ObservationIgnored private let userDefaults = UserDefaults.standard
    @ObservationIgnored private let openAppCountKey = "uk.co.markgolubev.my-waste-app.openAppCountKey"
    @ObservationIgnored private let lastReviewedVersionKey = "uk.co.markgolubev.my-waste-app.lastReviewedVersionkey"
    @ObservationIgnored private let limit = 6
    
    private(set) var count: Int
    
    init() {
        self.count = userDefaults.integer(forKey: openAppCountKey)
    }
    
    func canAskForReview(binsCount: Int) -> Bool {
        let mostRecentReviewed = userDefaults.string(forKey: lastReviewedVersionKey)
        
        guard let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
                else { fatalError("Expected to find a bundle version in the info dictionary.") }
        
        let hasReachedLimit = userDefaults.integer(forKey: openAppCountKey).isMultiple(of: limit)
        
        let isNewVersion = currentVersion as? String != mostRecentReviewed
        
        let hasBins = binsCount > 0
        
        guard hasReachedLimit && hasBins && isNewVersion else {
            return false
        }
        
        userDefaults.set(currentVersion, forKey: lastReviewedVersionKey)
        return true
    }
    func increase() {
        count
        += 1
        userDefaults.set (count, forKey: openAppCountKey)
    }
    
}
