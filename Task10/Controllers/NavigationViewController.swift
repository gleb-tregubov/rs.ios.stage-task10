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

        navigationBar.prefersLargeTitles = true
        navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Nunito-ExtraBold", size: 36.0)!
//            NSAttributedString.Key.font: UIFont(name: "Nunito", size: 36.0)!
        ]
        
//        navigationBar.
        navigationBar.tintColor = UIColor(rgb: 0x84B8AD)
    }

}
