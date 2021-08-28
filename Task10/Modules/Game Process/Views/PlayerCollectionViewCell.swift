//
//  PlayerCollectionViewCell.swift
//  Task10
//
//  Created by Gleb Tregubov on 28.08.2021.
//

import UIKit

class PlayerCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "PlayerCollectionViewCellId"
    
    let playerNameLabel: UILabel = {
        let view = UILabel()
        
        view.font = UIFont(name: "Nunito-ExtraBold", size: 28.0)
        view.textColor = UIColor(rgb: 0xEBAE68)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let playerScoreLabel: UILabel = {
        let view = UILabel()
        
        view.font = UIFont(name: "Nunito-Bold", size: 100.0)
        view.textColor = UIColor(rgb: 0xFFFDFD)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
    }
    
    private func setupAppearance() {
        contentView.backgroundColor = UIColor(rgb: 0x3B3B3B)
        contentView.layer.cornerRadius = 15.0
        
        setupPlayerNameLabel()
        setupPlayerScoreLabel()
    }
    
    private func setupPlayerNameLabel() {
        contentView.addSubview(playerNameLabel)
        
        NSLayoutConstraint.activate([
            playerNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24.0),
            playerNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
        ])
    }
    
    private func setupPlayerScoreLabel() {
        contentView.addSubview(playerScoreLabel)
        
        NSLayoutConstraint.activate([
            playerScoreLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            playerScoreLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
}
