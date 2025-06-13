//
//  CharacterFlowViewModel.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-13.
//

import Foundation

class CharacterViewModel {
    
    private let repository: CharactersRepository
    private var currentPage = 1
    private var isLoading = false
    private var allCharacters: [CharacterEntity] = []
    
    var filteredCharacters: [CharacterEntity] = []
    var didUpdate: (() -> Void)?
    var didFail: ((APIError) -> Void)?
    var showDetails : ((CharacterEntity) -> Void)?
    
    init(repository: CharactersRepository) {
        self.repository = repository
    }
    
    func loadInitialCharacters() {
        currentPage = 1
        allCharacters.removeAll()
        fetchCharacters()
    }
    
    func loadMoreCharacters() {
        guard !isLoading else { return }
        currentPage += 1
        fetchCharacters()
    }
    
    private func fetchCharacters() {
        isLoading = true
        repository.getCharacters(page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let characters):
                    self.allCharacters += characters
                    self.filteredCharacters = self.allCharacters
                    self.didUpdate?()
                case .failure(let error):
                    self.didFail?(error)
                }
            }
        }
    }
    
    func filter(by query: String) {
        if query.isEmpty {
            filteredCharacters = allCharacters
        } else {
            filteredCharacters = allCharacters.filter {
                $0.name.lowercased().contains(query.lowercased())
            }
        }
        didUpdate?()
    }
    
    func showDetails(character: CharacterEntity) {
        self.showDetails?(character)
    }
}
