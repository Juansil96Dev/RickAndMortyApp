//
//  DashboardCoordinator.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-13.
//

import UIKit

class DashboardCoordinator: Coordinator {
   
    var rootViewController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let viewModel = DashboardViewModel()
        viewModel.onNavigateToCharacterView = { [weak self] in
            self?.goToCharactersListView()
        }
        let loginViewController = DashboardViewController(user: UserEntity(name: "juansil", email: "correo", password: "12345"))
        rootViewController.pushViewController(loginViewController, animated: false)
    }
    
    func goToCharactersListView() {
        let characterCoordinator = CharacterCoordinator(rootViewController: rootViewController)
        childCoordinators.append(characterCoordinator)
        characterCoordinator.start()
    }
    

}
