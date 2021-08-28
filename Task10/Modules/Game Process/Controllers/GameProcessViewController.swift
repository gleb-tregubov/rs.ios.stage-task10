//
//  GameProcessViewController.swift
//  Task10
//
//  Created by Gleb Tregubov on 28.08.2021.
//

import UIKit

class GameProcessViewController: UIViewController {
    
    var players: [String]!
    
    weak var newGameViewController: NewGameViewControllerProtocol!
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        view.isPagingEnabled = true
        view.backgroundColor = UIColor(rgb: 0x232323)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        
        view.register(PlayerCollectionViewCell.self, forCellWithReuseIdentifier: PlayerCollectionViewCell.reuseIdentifier)
        
        view.delegate = self
        view.dataSource = self
        
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAppearance()
    }
    
    private func setupAppearance() {
        view.backgroundColor = UIColor(rgb: 0x232323)
        
        setupNavigationBar()
        setupCollectionView()
    }

    private func setupNavigationBar() {
        navigationItem.title = "Game"
        navigationItem.largeTitleDisplayMode = .always
        
        let newGameLeftBarButton = UIBarButtonItem(title: "NewGame", style: .plain, target: self, action: #selector(newGameTapped))
        
        newGameLeftBarButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Nunito-ExtraBold", size: 17.0) as Any], for: .normal)
        
        newGameLeftBarButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Nunito-ExtraBold", size: 17.0) as Any], for: .highlighted)
        
        navigationItem.leftBarButtonItem = newGameLeftBarButton
        
        
        
        let resultsRightBarButton = UIBarButtonItem(title: "Results", style: .plain, target: self, action: #selector(resultsTapped))
        
        resultsRightBarButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Nunito-ExtraBold", size: 17.0) as Any], for: .normal)
        
        resultsRightBarButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Nunito-ExtraBold", size: 17.0) as Any], for: .highlighted)
        
        navigationItem.rightBarButtonItem = resultsRightBarButton
        
    }
    
    @objc func newGameTapped() {
        print("New Game Tapped")
    }
    
    @objc func resultsTapped() {
        print("Results Tapped")
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 300.0)
        ])
    }
    
}

extension GameProcessViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.frame.size.width - 255.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let cellPading = (collectionView.frame.size.width - 255.0) / 2
        
        return UIEdgeInsets(top: 0.0, left: cellPading, bottom: 0.0, right: cellPading)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = 255.0
        let height = 300.0
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
}


extension GameProcessViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayerCollectionViewCell.reuseIdentifier, for: indexPath) as! PlayerCollectionViewCell
        
        cell.playerNameLabel.text = "Name".uppercased()
        cell.playerScoreLabel.text = "99"
        
        
        return cell
    }
    
    
}

extension GameProcessViewController: UICollectionViewDelegate {
    
}
