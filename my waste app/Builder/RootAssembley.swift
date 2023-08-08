//
//  RootAssembley.swift
//  my waste app
//
//  Created by Mark Golubev on 08/08/2023.
//

import Foundation

final class RootAssembly {
    func build() -> RootView {
        let router = Router.shared
        let viewModel = RootViewModel(router: router)
        return RootView(viewModel: viewModel)
    }
}
