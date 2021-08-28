//
//  PlayerTableViewCell.swift
//  Task10
//
//  Created by Gleb Tregubov on 27.08.2021.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "PlayerCellId"
    
    let playerNameTextField: UITextField = {
        let view = UITextField()
        
        view.font               = UIFont(name: "Nunito-ExtraBold", size: 20.0)
        view.textColor          = UIColor.white
        view.backgroundColor    = UIColor(rgb: 0x3B3B3B)
        view.textAlignment      = .left
        view.keyboardAppearance = .dark
        view.keyboardType       = .alphabet
        view.returnKeyType      = .done
        view.attributedPlaceholder = NSAttributedString(
            string: "Player Name",
            attributes: [NSAttributedString.Key.foregroundColor : UIColor(rgb: 0x9B9BA1)]
        )
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupAppearance()
    }
    
    private func setupAppearance() {
        setupPlayerNameTextField()
        
        backgroundColor = UIColor(rgb: 0x3B3B3B)
        overrideUserInterfaceStyle = .dark
        isEditing = true
    }
    
    private func setupPlayerNameTextField() {
        contentView.addSubview(playerNameTextField)
        
        NSLayoutConstraint.activate([
            playerNameTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            playerNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0),
            playerNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30.0)
        ])
    }

}
