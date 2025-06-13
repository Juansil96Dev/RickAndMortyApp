//
//  DashboardViewController.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-13.
//

import UIKit

class DashboardViewController: UIViewController {
    let button : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Got to Rick and Morty", for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    let viewModel: DashboardViewModel
    
    init(viewModel: DashboardViewModel) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Dashboard"
        self.layoutUI()
    }
    
    func layoutUI() {
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    @objc func handleLogin() {
        viewModel.didTapButton()
    }
}
