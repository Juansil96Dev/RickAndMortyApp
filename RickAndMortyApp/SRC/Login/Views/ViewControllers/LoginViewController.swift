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
        button.layer.cornerRadius = 4
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return button
    }()
    
    private let goToRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Registrarse", for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor.white.cgColor
        button.tintColor = .white
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
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
        useDefaultBackButton()
        setupBackground()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.941, green: 0.949, blue: 0.945, alpha: 1)
    
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
    
    private func setupBackground() {
        let backgroundImageView = UIImageView(image: UIImage(named: "loginFont"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.loginSuccess = { user in
            self.viewModel.didTapLoginButton(user: user)
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


