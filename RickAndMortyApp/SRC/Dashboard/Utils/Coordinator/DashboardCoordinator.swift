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
    var userLogged: UserEntity
    
    init(rootViewController: UINavigationController,userLogged: UserEntity) {
        self.rootViewController = rootViewController
        self.userLogged = userLogged
    }
    
    func start() {
        let viewModel = DashboardViewModel(userLogued: userLogged)
        viewModel.onNavigateToCharacterView = { [weak self] in
            self?.goToCharactersListView()
        }
        viewModel.onNavigateToLoginView = { [weak self] in
            self?.goToLoginView()
        }
        let loginViewController = DashboardViewController(viewModel: viewModel)
        rootViewController.pushViewController(loginViewController, animated: false)
    }
    
    func goToCharactersListView() {
        let characterCoordinator = CharacterCoordinator(rootViewController: rootViewController)
        childCoordinators.append(characterCoordinator)
        characterCoordinator.start()
    }
    
    func goToLoginView() {
        rootViewController.popToRootViewController(animated: true)
    }

}
