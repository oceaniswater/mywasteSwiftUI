//
//  AddBinAssembley.swift
//  my waste app
//
//  Created by Mark Golubev on 08/08/2023.
//

import Foundation

final class AddBinAssembley {
    func build() -> AddBinView {
        let router = Router.shared
        let viewModel = AddBinViewModel(router: router)
        return AddBinView(vm: viewModel)
    }
}
