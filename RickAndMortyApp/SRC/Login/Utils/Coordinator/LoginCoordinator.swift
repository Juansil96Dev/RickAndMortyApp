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
        let coreRepository = CoreDataAuthRepositoryImpl()
        let viewModel = AuthViewModel(repository: coreRepository)
        viewModel.onNavigateToDashBoard = { [weak self] user in
            self?.goToDashboard(user: user)
        }
        
        viewModel.onNavigateToRegisterUser = { [weak self] in
            self?.goToRegisterUser(viewModel: viewModel)
        }
        let loginViewController = LoginViewController(viewModel: viewModel)
        rootViewController.pushViewController(loginViewController, animated: false)
    }
    
    private func goToRegisterUser(viewModel : AuthViewModel) {
        let registerVC = RegisterViewController(viewModel: viewModel)
        rootViewController.pushViewController(registerVC, animated: true)
    }
    
    private func goToDashboard(user:UserEntity) {
        let dashboardCoordinator = DashboardCoordinator(rootViewController: rootViewController, userLogged: user)
        childCoordinators.append(dashboardCoordinator)
        dashboardCoordinator.start()
    }
    
    
}
