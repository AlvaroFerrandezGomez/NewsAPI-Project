//
//  HomeServiceLocator.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 1/2/22.
//

import Foundation

final class HomeServiceLocator {
    static func provideViewController() -> HomeView {
        let viewController = HomeView()
        viewController.viewModel = provideViewModel()

        return viewController
    }

    private static func provideViewModel() -> DefaultHomeViewModel {
        let fetchNewsUseCase = FetchNewsContainerInjections.provideFetchNewsUseCase()
        return DefaultHomeViewModel(fetchNewsUseCase: fetchNewsUseCase)
    }
}
