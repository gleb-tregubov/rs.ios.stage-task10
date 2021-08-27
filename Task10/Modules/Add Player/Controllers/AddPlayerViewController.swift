//
//  AddPlayerViewController.swift
//  Task10
//
//  Created by Gleb Tregubov on 27.08.2021.
//

import UIKit

class AddPlayerViewController: UIViewController {
    
    var newGameViewController: NewGameViewController!
    
    let playerNameTextField = PlayerNameTextField()
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.bounces = true
        view.alwaysBounceVertical = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAppearance()
    }
    
    private func setupAppearance() {
        view.backgroundColor = UIColor(rgb: 0x232323)
        
        setupNavigationBar()
        setupPlayerNameTextField()
        setupScrollView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Add Player"
        navigationItem.largeTitleDisplayMode = .always
        
        let backLeftBarButton: UIBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backHandler))
        
        backLeftBarButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Nunito-ExtraBold", size: 17.0) as Any], for: .normal)
        
        navigationItem.leftBarButtonItem = backLeftBarButton
        
        
        
        let addRightBarButton: UIBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addHandler))
        
        addRightBarButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Nunito-ExtraBold", size: 17.0) as Any], for: .normal)
        
        navigationItem.rightBarButtonItem = addRightBarButton
    }
    
    @objc func backHandler() {
        print("backButton Tapped")
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addHandler() {
        print("addButton Tapped")
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupPlayerNameTextField() {
        scrollView.addSubview(playerNameTextField)
        
        NSLayoutConstraint.activate([
            playerNameTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 25.0),
            playerNameTextField.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            playerNameTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
            
        ])
    }


}
