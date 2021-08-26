//
//  PlayersTabelHeaderFooterView.swift
//  Task10
//
//  Created by Gleb Tregubov on 26.08.2021.
//

import UIKit

class PlayersTabelHeaderFooterView: UITableViewHeaderFooterView {
    
    static let identifier = "HeaderId"
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        
        view.text      = "Players"
        view.font      = UIFont(name: "Nunito-SemiBold", size: 16.0)
        view.textColor = UIColor(rgb: 0xEBEBF5).withAlphaComponent(0.6)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    private func setupView() {
        contentView.backgroundColor = UIColor(rgb: 0x3B3B3B)
        
        setupTitleLabel()
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
//            titleLabel.widthAnchor.constraint(equalToConstant: 309.0),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
