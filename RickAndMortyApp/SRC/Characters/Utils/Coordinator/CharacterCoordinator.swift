//
//  CharacterCoordinator.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-13.
//
import UIKit
class CharacterCoordinator : Coordinator {
   
    var rootViewController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let repository = RMCharactersRepositoryImpl()
        let viewModel = CharacterViewModel(repository: repository)
        viewModel.showDetails = { [weak self] character in
            self?.goToDetailCharacterView(character: character)
        }
        let viewController = CharactersListViewController(viewModel: viewModel)
        rootViewController.pushViewController(viewController, animated: true)
    }
    
    func goToDetailCharacterView(character: CharacterEntity) {
        let viewController = CharacterDetailViewController(character: character)
        rootViewController.pushViewController(viewController, animated: true)
    }
    

}
