//
//  StartGameButton.swift
//  Task10
//
//  Created by Gleb Tregubov on 26.08.2021.
//

import UIKit

class StartGameButton: UIButton {
    
    private func setupAppearance() {
        setTitle("Start game", for: .normal)
        setTitleColor(UIColor.white, for: .normal)
        setTitleColor(UIColor(rgb: 0x54786F), for: .highlighted) // Временно
        titleLabel?.textAlignment = .center
        titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 24.0)
        backgroundColor = UIColor(rgb: 0x84B8AD)
        layer.cornerRadius = 30.0
        
        
        layer.shadowColor = UIColor(rgb: 0x54786F).cgColor
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.0
        layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        layer.masksToBounds = false
        
        titleLabel?.layer.shadowColor = UIColor(rgb: 0x54786F).cgColor
        titleLabel?.layer.shadowOpacity = 1.0
        titleLabel?.layer.shadowRadius = 0.0
        titleLabel?.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        titleLabel?.layer.masksToBounds = false
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
    }
    
    

}
