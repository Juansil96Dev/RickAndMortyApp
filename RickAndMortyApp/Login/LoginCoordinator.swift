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
        let loginViewController = InitialViewController()
        rootViewController.pushViewController(loginViewController, animated: false) 
    }
}
