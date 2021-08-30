//
//  ReultsViewController.swift
//  Task10
//
//  Created by Gleb Tregubov on 30.08.2021.
//

import UIKit

class ResultsViewController: UIViewController {
    
    weak var gameProcessViewController: GameProcessViewController!
    
//    var players = ["Kate", "John", "Betty", "Dave"]
    var players: [Player]!
//    var scores = [20, 15, 0, 10]
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.bounces = true
        view.alwaysBounceVertical = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let resultsTableView: UITableView = {
        let view = UITableView()
        
        view.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
        view.rowHeight = 50.0
        view.backgroundColor = .clear
        view.tintColor = .white
        view.isScrollEnabled = false
        view.isEditing = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var tableViewHeightConstraint: NSLayoutConstraint!
    var tableViewBottomConstraint: NSLayoutConstraint!
    
//    var tableViewHeight: CGFloat {
//        (CGFloat(players.count + 1) * resultsTableView.rowHeight)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        players = gameProcessViewController.players

        setupAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        players = gameProcessViewController.players
        
        resultsTableView.reloadData()
    }
    
    private func setupAppearance() {
        view.backgroundColor = UIColor(rgb: 0x232323)
        
        setupNavigationBar()
        setupScrollVew()
        setupResultsTableView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Results"
        navigationItem.largeTitleDisplayMode = .always
        
        let newGameLeftBarButton = UIBarButtonItem(title: "NewGame", style: .plain, target: self, action: #selector(newGameTapped))
        
        newGameLeftBarButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Nunito-ExtraBold", size: 17.0) as Any], for: .normal)
        
        newGameLeftBarButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Nunito-ExtraBold", size: 17.0) as Any], for: .highlighted)
        
        navigationItem.leftBarButtonItem = newGameLeftBarButton
        
        
        
        let resumeRightBarButton = UIBarButtonItem(title: "Resume", style: .plain, target: self, action: #selector(resumeTapped))
        
        resumeRightBarButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Nunito-ExtraBold", size: 17.0) as Any], for: .normal)
        
        resumeRightBarButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Nunito-ExtraBold", size: 17.0) as Any], for: .highlighted)
        
        navigationItem.rightBarButtonItem = resumeRightBarButton
    }
    
    @objc private func newGameTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func resumeTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupScrollVew() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupResultsTableView() {
        scrollView.addSubview(resultsTableView)
        
        let tableViewHeight: CGFloat = (CGFloat(players.count + 1) * resultsTableView.rowHeight)
        
        tableViewHeightConstraint = NSLayoutConstraint(item: resultsTableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: tableViewHeight)
        
        NSLayoutConstraint.activate([
            resultsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            resultsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            resultsTableView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10.0),
            tableViewHeightConstraint,
//            resultsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10.0)
        ])
        
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        
    }

}

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "CellId")

        let rankPlace = "#\(indexPath.row + 1) "
        let rankPlaceAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.white ]
        let attributedRankPlaceString = NSAttributedString(string: rankPlace, attributes: rankPlaceAttribute)

        let playerName = players[indexPath.row].name
        let playerNameAttribute = [ NSAttributedString.Key.foregroundColor: UIColor(rgb: 0xEBAE68) ]
        let attributedPlayerNameString = NSAttributedString(string: playerName, attributes: playerNameAttribute)

//        let score = scores[indexPath.row]
//        let scoreAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.white ]
//        let attributedScoreString = NSAttributedString(string: "\(score)", attributes: scoreAttribute)

        let attributedCompositionString = NSMutableAttributedString(string: "")
        attributedCompositionString.append(attributedRankPlaceString)
        attributedCompositionString.append(attributedPlayerNameString)

        cell.backgroundColor = UIColor.clear
        cell.textLabel?.attributedText = attributedCompositionString

        cell.detailTextLabel?.text = "\(players[indexPath.row].score)"
        cell.detailTextLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 28.0)
        cell.detailTextLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 28.0)
        
        return cell
    }
    
    
}
