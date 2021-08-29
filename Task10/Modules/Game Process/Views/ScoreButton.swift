//
//  ScoreButton.swift
//  Task10
//
//  Created by Gleb Tregubov on 29.08.2021.
//

import UIKit

enum scoreButtonSize {
    case standard
    case big
    
}

class ScoreButton: UIButton {
    
    let scorePoint: Int

    
    private func setupAppearance() {
        setTitle("+1", for: .normal)
        setTitleColor(UIColor.white, for: .normal)
        setTitleColor(UIColor(rgb: 0x54786F), for: .highlighted)
        titleLabel?.textAlignment = .center
        titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 25.0)
        backgroundColor = UIColor(rgb: 0x84B8AD)
        layer.cornerRadius = 55.0 / 2
        
        titleLabel?.layer.shadowColor = UIColor(rgb: 0x54786F).cgColor
        titleLabel?.layer.shadowOpacity = 1.0
        titleLabel?.layer.shadowRadius = 0.0
        titleLabel?.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        titleLabel?.layer.masksToBounds = false
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(scorePoint: Int, size: scoreButtonSize) {
        self.init(scorePoint: scorePoint)
        
        switch size {
        case .big:
            titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 40.0)
            layer.cornerRadius = 90.0 / 2
        case .standard:
            titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 25.0)
            layer.cornerRadius = 55.0 / 2
        }
        
    }


    init(scorePoint: Int) {
        self.scorePoint = scorePoint
        super.init(frame: .zero)
        setupAppearance()
        setTitle( scorePoint > 0
                    ? "+\(scorePoint)"
                    : "\(scorePoint)"
                  , for: .normal
        )
        
    }
    
//    override init(frame: CGRect) {
////        self.scorePoint = 1
//        super.init(frame: frame)
//        setupAppearance()
//
//    }
    
    required init?(coder: NSCoder) {
        self.scorePoint = 1
        super.init(coder: coder)
        setupAppearance()
    }

}
