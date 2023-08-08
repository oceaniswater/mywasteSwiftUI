//
//  EditBinAssembley.swift
//  my waste app
//
//  Created by Mark Golubev on 08/08/2023.
//

import Foundation

final class EditBinAssembley {
    func build(for bin: Bin) -> EditBinView {
        let router = Router.shared
        let viewModel = EditBinViewModel(router: router)
        return EditBinView(bin: bin, vm: viewModel)
    }
}
