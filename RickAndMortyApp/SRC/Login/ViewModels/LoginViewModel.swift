//
//  LoginViewModel.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-12.
//



class LoginViewModel {
    var onNavigateToDetail: (() -> Void)?

    func didTapButton() {
        onNavigateToDetail?()
    }
}
