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
        let viewController = CharactersListViewController(viewModel: viewModel)
        rootViewController.pushViewController(viewController, animated: true)
    }
    
    func goToDetailCharacterView() {
        let repository = RMCharactersRepositoryImpl()
        let viewModel = CharacterViewModel(repository: repository)
        let viewController = CharactersListViewController(viewModel: viewModel)
        rootViewController.pushViewController(viewController, animated: true)
    }
    

}
