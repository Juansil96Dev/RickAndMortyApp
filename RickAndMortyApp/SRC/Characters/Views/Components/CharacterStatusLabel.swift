//
//  CharacterStatusLabel.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-13.
//
import UIKit

class CharacterStatusLabel: UILabel {
    
    func configure(with status: CharacterStatus) {
        let icon = UIImage(named: status.symbol)?.withTintColor(status.color, renderingMode: .alwaysOriginal)
        
        let attachment = NSTextAttachment()
        attachment.image = icon
        attachment.bounds = CGRect(x: 10, y: -5, width: 24, height: 24)
        
        let attributedText = NSMutableAttributedString(string: " • Status: \(status.rawValue)", attributes: [.font: UIFont.boldSystemFont(ofSize: 20)])
        
        attributedText.append(NSAttributedString(attachment: attachment))
        
        self.attributedText = attributedText
    }
}
