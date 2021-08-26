//
//  NewGameViewController.swift
//  Task10
//
//  Created by Gleb Tregubov on 25.08.2021.
//

import UIKit

class NewGameViewController: UIViewController {
    
    //TODO: - make table view
    let tableView: UITableView = {
        let view = UITableView()
        
        return view
    }()
    
    //TODO: - make custom Start Game Button
    let startButton: UIButton = {
        let view = UIButton()
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAppearance()
    }
    
    private func setupAppearance() {
        view.backgroundColor = UIColor(rgb: 0x232323);
        
        setupNavigationBar()
        
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Game Counter"
        
        let cancelLeftBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
        cancelLeftBarButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.nunito(size: 17.0) as Any], for: .normal)
        
        navigationItem.leftBarButtonItem = cancelLeftBarButton
    }
    
    @objc func cancelTapped() {
        print("Cancel Tapped")
    }

}
