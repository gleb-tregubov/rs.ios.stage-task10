//
//  AddPlayerViewController.swift
//  Task10
//
//  Created by Gleb Tregubov on 27.08.2021.
//

import UIKit

protocol NewGameViewControllerProtocol : AnyObject {
    var players: [String] { get set }
    
    func addNewPlayer(name newPlayer: String)
}

class AddPlayerViewController: UIViewController {
    
    weak var newGameViewController: NewGameViewControllerProtocol!
    
    let playerNameTextField: PlayerNameTextField = {
        let view = PlayerNameTextField()
        
        view.addTarget(self, action: #selector(playerNameTextFieldChangeHandler), for: .editingChanged)
        
        return view
    }()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        playerNameTextField.text = ""
        navigationItem.rightBarButtonItem?.isEnabled = false
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
        backLeftBarButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Nunito-ExtraBold", size: 17.0) as Any], for: .highlighted)
        
        navigationItem.leftBarButtonItem = backLeftBarButton
        
        
        
        let addRightBarButton: UIBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addHandler))
        
        addRightBarButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Nunito-ExtraBold", size: 17.0) as Any], for: .normal)
        addRightBarButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Nunito-ExtraBold", size: 17.0) as Any], for: .disabled)
        addRightBarButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Nunito-ExtraBold", size: 17.0) as Any], for: .highlighted)
        addRightBarButton.isEnabled = false
        
        navigationItem.rightBarButtonItem = addRightBarButton
    }
    
    @objc func backHandler() {
        print("backButton Tapped")
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addHandler() {
        print("addButton Tapped")
        
        let newPlayerName = playerNameTextField.text!
        
        newGameViewController.addNewPlayer(name: newPlayerName)
        
        navigationController?.popViewController(animated: true)
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
        
        playerNameTextField.delegate = self
        hideWhenTappedAround()
        
        NSLayoutConstraint.activate([
            playerNameTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 25.0),
            playerNameTextField.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            playerNameTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
            
        ])
    }
    
    private func hideWhenTappedAround() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hide))
        view.addGestureRecognizer(gesture)
    }
    
    @objc private func hide() {
        view.endEditing(true)
    }

}


extension AddPlayerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let isEmpty = playerNameTextField.text?.isEmpty else { return true}
        
        if isEmpty {
            textField.resignFirstResponder()
        } else {
            addHandler()
            navigationController?.popViewController(animated: true)
        }
        
        return true
    }
    
    @objc private func playerNameTextFieldChangeHandler() {
        if let isEmpty = playerNameTextField.text?.isEmpty {
            navigationItem.rightBarButtonItem?.isEnabled = !isEmpty
        }
    }
    
    
}
