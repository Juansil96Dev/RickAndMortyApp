//
// CharacterDetailCardView.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-13.
//

import SDWebImage
import UIKit

class CharacterDetailCardView : UIView {

    // MARK: - UI Component
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let descriptionStackView : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.spacing = 8
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    private let overlayContainer : UIView={
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var hasShadow = false
    private var currentShadowColor: UIColor = .black

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 8
        clipsToBounds = false
        
        addSubview(imageView)
        imageView.addSubview(overlayContainer)
        overlayContainer.addSubview(titleLabel)
        addSubview(descriptionStackView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 350),

            overlayContainer.topAnchor.constraint(equalTo: imageView.topAnchor),
            overlayContainer.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            overlayContainer.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            overlayContainer.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),

            titleLabel.leadingAnchor.constraint(equalTo: overlayContainer.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: overlayContainer.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: overlayContainer.bottomAnchor, constant: -12),

            descriptionStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            descriptionStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            descriptionStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    

    override func layoutSubviews() {
        
        super.layoutSubviews()
        if hasShadow {
            addBottomInnerShadow(to: overlayContainer, color: currentShadowColor)
        } else {
            overlayContainer.layer.sublayers?.removeAll(where: { $0.name == "BottomInnerShadow" })
        }
    }


    //Esta funcion agrega sombra desde abajo de la imagen
    private func addBottomInnerShadow(to view: UIView, color: UIColor) {
        imageView.layer.sublayers?.removeAll(where: { $0.name == "BottomInnerShadow" })
        
        let shadowHeight: CGFloat = 82
        let shadowLayer = CAGradientLayer()
        shadowLayer.name = "BottomInnerShadow"
        shadowLayer.frame = CGRect(
            x: 0,
            y: imageView.bounds.height - shadowHeight,
            width: imageView.bounds.width,
            height: shadowHeight
        )
        
        shadowLayer.colors = [
            color.withAlphaComponent(0.3).cgColor,
            UIColor.clear.cgColor
        ]
        shadowLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        shadowLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        
        view.layer.insertSublayer(shadowLayer, below: titleLabel.layer)
    }

    // MARK: - Public method
    func configure(
        character:CharacterEntity,
        titleColor: UIColor? = nil,
        cardColor: UIColor? = nil,
        showBottomShadow: Bool = true,
        shadowColor: UIColor = .blue) {
   
        if let titleColor = titleColor {
            titleLabel.textColor = titleColor
        }

        if let cardColor = cardColor {
            backgroundColor = cardColor
        }
        
        hasShadow = showBottomShadow
        currentShadowColor = shadowColor
            
        imageView.sd_setImage(with: URL(string: character.imageURL), placeholderImage: UIImage(systemName: "person.slash"))
            
        self.addCharacterDescription(character: character)
        
        setNeedsLayout()
     
    }
    
    private func addCharacterDescription(character: CharacterEntity) {
        
        self.titleLabel.text = character.name
        
        // Status
        let statusLabel = CharacterStatusLabel()
        statusLabel.configure(with: character.status)
        descriptionStackView.addArrangedSubview(statusLabel)

        // Gender
        let genderLabel = CharacterGenderLabel()
        genderLabel.configure(with: character.gender)
        descriptionStackView.addArrangedSubview(genderLabel)

        // Species
        descriptionStackView.addArrangedSubview(makeInfoLabel(title: " • Species", value: character.species))

        // Type
        if !character.type.isEmpty {
            descriptionStackView.addArrangedSubview(makeInfoLabel(title: " • Type", value: character.type))
        }

        // Origin
        descriptionStackView.addArrangedSubview(makeInfoLabel(title: " • Origin", value: character.origin))

        // Location
        descriptionStackView.addArrangedSubview(makeInfoLabel(title: " • Location", value: character.location))

        // Episode Count
        descriptionStackView.addArrangedSubview(makeInfoLabel(title: " • Episodes", value: "\(character.episodeCount)"))

    }
    
    private func makeInfoLabel(title: String, value: String) -> UILabel {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textColor = .label
        
        label.text = "\(title): \(value)"
        return label
    }
}
