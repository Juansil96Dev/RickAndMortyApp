//
//  Extensions.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-13.
//

import UIKit

extension UIViewController {
    func useDefaultBackButton(title: String = "Atrás") {
        let backItem = UIBarButtonItem()
        backItem.title = title
        navigationItem.backBarButtonItem = backItem
    }
}
