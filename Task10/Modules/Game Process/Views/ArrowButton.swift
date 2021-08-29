//
//  ArrowButton.swift
//  Task10
//
//  Created by Gleb Tregubov on 29.08.2021.
//

import UIKit

enum arrowDirection {
    case right
    case left
}

enum arrowState {
    case border
    case normal
}


class ArrowButton: UIButton {
    
    static let arrowConfig = UIImage.SymbolConfiguration(pointSize: 34.0, weight: .semibold, scale: .large)
    
    var arrowDirection: arrowDirection
    
    var arrowState: arrowState = .normal {
        willSet{
            switch newValue {
            case .normal:
                
                switch arrowDirection {
                case .left:
                    setImage(UIImage(systemName: "arrow.left", withConfiguration: ArrowButton.arrowConfig), for:  .normal)
                case .right:
                    setImage(UIImage(systemName: "arrow.right", withConfiguration: ArrowButton.arrowConfig), for:  .normal)
                }
                
            case .border:
                
                switch arrowDirection {
                case .left:
                    setImage(UIImage(systemName: "arrow.left.to.line", withConfiguration: ArrowButton.arrowConfig), for:  .normal)
                case .right:
                    setImage(UIImage(systemName: "arrow.right.to.line", withConfiguration: ArrowButton.arrowConfig), for:  .normal)
                }
                
            }
        }
    }

    private func setupAppearance() {
        tintColor = UIColor(rgb: 0xEBAE68)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(direction: arrowDirection, state: arrowState) {
        self.arrowDirection = direction
        self.arrowState = state
        
        super.init(frame: .zero)
        
        setupAppearance()
        
        switch direction {
        case .right:
            
            switch state {
            case .normal:
                setImage(UIImage(systemName: "arrow.right", withConfiguration: ArrowButton.arrowConfig), for:  .normal)
            case .border:
                setImage(UIImage(systemName: "arrow.right.to.line", withConfiguration: ArrowButton.arrowConfig), for:  .normal)
            }
            
        case .left:
            
            switch state {
            case .normal:
                setImage(UIImage(systemName: "arrow.left", withConfiguration: ArrowButton.arrowConfig), for:  .normal)
            case .border:
                setImage(UIImage(systemName: "arrow.left.to.line", withConfiguration: ArrowButton.arrowConfig), for:  .normal)
            }
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
