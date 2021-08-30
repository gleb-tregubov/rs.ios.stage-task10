//
//  ResultsTableViewCell.swift
//  Task10
//
//  Created by Gleb Tregubov on 30.08.2021.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "ResultsCell"
    
    let playerNameLabel: UILabel = {
        let view = UILabel()
        
        view.font = UIFont(name: "Nunito-ExtraBold", size: 28.0)
//        view.textColor = UIColor(rgb: <#T##Int#>)
        
        return view
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
