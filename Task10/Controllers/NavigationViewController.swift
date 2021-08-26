//
//  NavigationViewController.swift
//  Task10
//
//  Created by Gleb Tregubov on 25.08.2021.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.backgroundColor          = UIColor(rgb: 0x232323)
        navigationBar.tintColor                = UIColor(rgb: 0x84B8AD)
        navigationBar.barTintColor             = UIColor(rgb: 0x3B3B3B)
        navigationBar.isTranslucent            = true
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Nunito-ExtraBold", size: 20.0)!
        ]
        
        navigationBar.prefersLargeTitles       = true
        
        navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Nunito-ExtraBold", size: 36.0)!
        ]
        
    }

}
