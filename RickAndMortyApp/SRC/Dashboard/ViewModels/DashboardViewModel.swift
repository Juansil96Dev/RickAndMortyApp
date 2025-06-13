//
//  DashboardViewModel.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-13.
//

class DashboardViewModel {
    var onNavigateToCharacterView: (() -> Void)?

    func didTapButton() {
        onNavigateToCharacterView?()
    }
}
