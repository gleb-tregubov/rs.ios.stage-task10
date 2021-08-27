//
//  PlayerNameTextField.swift
//  Task10
//
//  Created by Gleb Tregubov on 27.08.2021.
//

import UIKit

class PlayerNameTextField: UITextField {
    
    private func setupAppearance() {
        font = UIFont(name: "Nunito-ExtraBold", size: 20.0)
        textColor = UIColor(rgb: 0x84B8AD)
        attributedPlaceholder = NSAttributedString(
            string: "Player Name",
            attributes: [NSAttributedString.Key.foregroundColor : UIColor(rgb: 0x9B9BA1)]
        )
        textAlignment = .left
        placeholder = "Player Name"
        backgroundColor = UIColor(rgb: 0x3B3B3B)
        
        setContentHuggingPriority(.defaultLow, for: .horizontal)
//        setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        translatesAutoresizingMaskIntoConstraints = false
        becomeFirstResponder()
    }
    
    convenience init() {
        self.init(frame: .zero)
        setupAppearance()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 24.0, dy: 18.0)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 24.0, dy: 18.0)
    }
}
