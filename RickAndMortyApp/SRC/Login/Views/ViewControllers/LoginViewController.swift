//
//  InitialViewController.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-12.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let viewModel: AuthViewModel
    
    private let emailField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Correo"
        textfield.borderStyle = .roundedRect
        textfield.keyboardType = .emailAddress
        textfield.autocapitalizationType = .none
        return textfield
    }()
    
    private let passwordField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Contraseña"
        textfield.isSecureTextEntry = true
        textfield.borderStyle = .roundedRect
        return textfield
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Iniciar sesión", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return button
    }()
    
    private let goToRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Registrarse", for: .normal)
        button.tintColor = .systemGray
        return button
    }()
    
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) no implementado")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        let stack = UIStackView(arrangedSubviews: [emailField, passwordField, loginButton, goToRegisterButton])
        stack.axis = .vertical
        stack.spacing = 15
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        goToRegisterButton.addTarget(self, action: #selector(didTapGoToRegister), for: .touchUpInside)
    }
    
    private func bindViewModel() {
        viewModel.loginSuccess = { user in
            print("Login exitoso para: \(user.name)")
            self.viewModel.didTapLoginButton()
        }
        viewModel.loginError = { errorMsg in
            self.showAlert(title: "Error", message: errorMsg)
        }
    }
    
    @objc private func didTapLogin() {
        viewModel.login(email: emailField.text ?? "", password: passwordField.text ?? "")
    }
    
    @objc private func didTapGoToRegister() {
        viewModel.didTapRegisterButton()
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}


