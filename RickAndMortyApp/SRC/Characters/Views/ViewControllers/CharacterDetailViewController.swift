//
//  CharacterDetailViewController.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-13.
//

import UIKit

class CharacterDetailViewController : UIViewController {
    
    
    private let characterCard : CharacterDetailCardView! = {
        let view = CharacterDetailCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var character: CharacterEntity!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(character: CharacterEntity) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Character Detail"
        useDefaultBackButton()
        setupView()
        configureView()
    }
    
   
    private func setupView() {
        view.backgroundColor = UIColor(red: 0.941, green: 0.949, blue: 0.945, alpha: 1)
        view.addSubview(characterCard)
        
        NSLayoutConstraint.activate([
            characterCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterCard.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 16),
            characterCard.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -16),
        ])
    }
    
    private func configureView() {
        characterCard.configure(character: character,cardColor: .white, shadowColor: .black)
    }
}
