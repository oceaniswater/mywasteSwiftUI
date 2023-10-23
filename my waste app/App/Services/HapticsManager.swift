//
//  HapticsManager.swift
//  my waste app
//
//  Created by Mark Golubev on 23/10/2023.
//

import Foundation

import UIKit
import CoreHaptics

final class HapticsManager {
    
    static let shared = HapticsManager()
    private init() { }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        let impact = UIImpactFeedbackGenerator(style: .medium)
        impact.impactOccurred()
    }
}

