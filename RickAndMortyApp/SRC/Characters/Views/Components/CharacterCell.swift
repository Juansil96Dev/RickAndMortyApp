//
//  CharacterCell.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-13.
//

import UIKit
import SDWebImage

class CharacterCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CharacterCell"

    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
   
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.backgroundColor = .clear
        return view
    }()
        
    private let headlineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    private let nameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "Name"
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var blurEffectView: UIVisualEffectView?
    
    var onTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(containerView)
        
        containerView.addSubview(imageView)
        containerView.addSubview(headlineView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            headlineView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headlineView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            headlineView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
        
        let blurEffect = UIBlurEffect(style: .light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView?.frame = bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView?.translatesAutoresizingMaskIntoConstraints = false
        
        if let blurEffectView = blurEffectView {
            headlineView.addSubview(blurEffectView)
        }
        
        headlineView.backgroundColor = UIColor.black.withAlphaComponent(0.25) //
        headlineView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: headlineView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: headlineView.trailingAnchor, constant: -16),
            nameLabel.centerYAnchor.constraint(equalTo: headlineView.centerYAnchor),
        ])
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.imageView.isUserInteractionEnabled = true
        self.imageView.addGestureRecognizer(gesture)
    }

    func configure(
        with entity: CharacterEntity,
        onTap: (() -> Void)?) {
            
        if  entity.name.count > 16 {
            headlineView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        } else {
            headlineView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        }
        
        self.onTap = onTap
        nameLabel.text = entity.name
        imageView.sd_setImage(with: URL(string: entity.imageURL), placeholderImage: UIImage(systemName: "person.slash"))
    }
    
    @objc private func handleTap() {
        self.onTap?()
    }
    
    
}
