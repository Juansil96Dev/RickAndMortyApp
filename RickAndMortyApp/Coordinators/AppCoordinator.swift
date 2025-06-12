//
//  AppCoordinator.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-12.
//

import UIKit

class AppCoordinator : Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    lazy var rootViewController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        
        
        let loginCoordinator = LoginCoordinator(rootViewController: rootViewController)
        childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
    }
    
}
