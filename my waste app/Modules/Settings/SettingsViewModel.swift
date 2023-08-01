//
//  SettingsViewModel.swift
//  my waste app
//
//  Created by Mark Golubev on 31/07/2023.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}
