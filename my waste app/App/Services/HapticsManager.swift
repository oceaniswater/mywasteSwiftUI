//
//  HapticsManager.swift
//  my waste app
//
//  Created by Mark Golubev on 23/10/2023.
//

import Foundation
import UIKit

final class HapticsManager {
    
    static let shared = HapticsManager()
    private init() { }
    
    func impactFeedback(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let impact = UIImpactFeedbackGenerator(style: style)
        impact.impactOccurred()
    }
    
    func notificationFeedback(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
}

