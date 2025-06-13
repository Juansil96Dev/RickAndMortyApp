//
//  DashboardViewModel.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-13.
//

import Foundation

class DashboardViewModel {
    
    var userLogued: UserEntity?
    var onNavigateToCharacterView: (() -> Void)?
    var onNavigateToLoginView: (() -> Void)?
    
    private let menuItems = ["Lista de Personajes","Lista de Episodios","Lista de Localidades"]
    private let menuIcons = ["rick","episodes","world"]
    
    init(userLogued: UserEntity) {
        self.userLogued = userLogued
    }
    
    func getUserLogued() -> String? {
        guard userLogued != nil else {
            return nil
        }
        return greetingMessage()
    }
    
    private func greetingMessage() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        let greeting: String
        switch hour {
        case 6..<12: greeting = "Buenos días"
        case 12..<19: greeting = "Buenas tardes"
        default: greeting = "Buenas noches"
        }
        return "\(greeting), \(userLogued?.name.capitalized ?? "")"
    }
    
    func getMenuItems(index: Int) -> String{
        return menuItems[index]
    }
     func getMenuIcons(index: Int) -> String {
        return menuIcons[index]
    }
    
    func numberOfMenuItems() -> Int {
        return menuItems.count
    }
    
    func didTapCloseSession() {
        onNavigateToLoginView?()
    }

    func didTapCharacterListOption() {
        onNavigateToCharacterView?()
    }
}
