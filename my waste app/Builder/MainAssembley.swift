//
//  RootAssembley.swift
//  my waste app
//
//  Created by Mark Golubev on 08/08/2023.
//

import Foundation

final class MainAssembley {
    func build() -> MainView {
        let router = Router.shared
        let viewModel = MainViewModel(router: router)
        return MainView(vm: viewModel)
    }
}
