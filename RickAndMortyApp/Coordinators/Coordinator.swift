//
//  Untitled.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-12.
//

import UIKit

protocol Coordinator {
    var rootViewController: UINavigationController { get }
    var childCoordinators: [Coordinator] { get set }
    func start()
}
