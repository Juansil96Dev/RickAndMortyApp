//
//  LoginCoordinator.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-12.
//

import UIKit

class LoginCoordinator: Coordinator {
   
    var rootViewController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let viewModel = LoginViewModel()
        viewModel.onNavigateToDetail = { [weak self] in
            self?.goToDashboard()
        }
        let loginViewController = InitialViewController(viewModel: viewModel)
        rootViewController.pushViewController(loginViewController, animated: false)
    }
    
    func goToDashboard() {
        let viewController = DashboardViewController()
        rootViewController.pushViewController(viewController, animated: true)
    }
}
