//
//  LoginViewModel.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-12.
//

import Foundation

class AuthViewModel {
    
    private let repository: AuthRepository
    
    var onNavigateToDashBoard: (() -> Void)?
    var onNavigateToRegisterUser: (() -> Void)?
    
    var loginSuccess: ((UserEntity) -> Void)?
    var loginError: ((String) -> Void)?
    
    var registerSuccess: (() -> Void)?
    var registerError: ((String) -> Void)?
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
    
    
    func login(email: String, password: String) {
        repository.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.loginSuccess?(user)
                case .failure(let error):
                    self?.loginError?(error.localizedDescription)
                }
            }
        }
    }
    
    func register(name: String, email: String, password: String, confirmPassword: String) {
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty else {
            registerError?("Por favor, complete todos los campos")
            return
        }
        
        guard password == confirmPassword else {
            registerError?("Las contraseñas no coinciden")
            return
        }
        
        let newUser = UserEntity(name: name, email: email, password: password)
        
        repository.register(user: newUser) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.registerSuccess?()
                case .failure(let error):
                    self?.registerError?(error.localizedDescription)
                }
            }
        }
    }
    
    
    func didTapLoginButton() {
        onNavigateToDashBoard?()
    }
    
    func didTapRegisterButton() {
        onNavigateToRegisterUser?()
    }
}
