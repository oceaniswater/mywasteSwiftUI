//
//  SettingsAssembley.swift
//  my waste app
//
//  Created by Mark Golubev on 08/08/2023.
//

import Foundation

final class SettingsAssembley {
    @MainActor func build() -> SettingsView {
        let router = Router.shared
        let viewModel = SettingsViewModel(router: router)
        return SettingsView(vm: viewModel)
    }
}
