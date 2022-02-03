//
//  DetailServiceLocator.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 1/2/22.
//

import Foundation

final class DetailServiceLocator {
    static func provideViewController(newSelected: NewPresentationModel) -> DetailView {
        let viewController = DetailView()
        viewController.viewModel = provideViewModel(newSelected: newSelected)

        return viewController
    }

    private static func provideViewModel(newSelected: NewPresentationModel) -> DefaultDetailViewModel {
        return DefaultDetailViewModel(newSelected: newSelected)
    }
}
