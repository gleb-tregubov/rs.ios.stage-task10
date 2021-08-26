//
//  NewGameViewController.swift
//  Task10
//
//  Created by Gleb Tregubov on 25.08.2021.
//

import UIKit

class NewGameViewController: UIViewController {
    
    let players = ["Kate", "John", "Betty"]
    
    //TODO: - make table view
    let tableView: UITableView = {
        let view = UITableView()
        
        view.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
        
        view.backgroundColor     = UIColor(rgb: 0x3B3B3B)
        view.layer.cornerRadius  = 15.0
        view.sectionHeaderHeight = 40.0
        view.sectionFooterHeight = 60.0
        view.rowHeight           = 54.0
        
        view.isEditing           = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        setupTableView()
//        tableView.frame = view.bounds
    }
    
    private func setupAppearance() {
        view.backgroundColor = UIColor(rgb: 0x232323)
        
        setupNavigationBar()
        setupTableView()
        
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
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        let tableViewHeight: CGFloat = (CGFloat(players.count) * tableView.rowHeight) + tableView.sectionHeaderHeight + tableView.sectionFooterHeight
        print(tableViewHeight)
        
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalToConstant: 335.0),
            tableView.heightAnchor.constraint(equalToConstant: tableViewHeight),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25.0)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension NewGameViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
        
        cell.textLabel?.text = players[indexPath.row]
        cell.textLabel?.font = UIFont.nunito(size: 20.0)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = UIColor(rgb: 0x3B3B3B)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Players"
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Add Player"
    }
    
    
}
