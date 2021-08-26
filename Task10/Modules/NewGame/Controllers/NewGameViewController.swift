//
//  NewGameViewController.swift
//  Task10
//
//  Created by Gleb Tregubov on 25.08.2021.
//

import UIKit

class NewGameViewController: UIViewController {
    
//    var players = ["Kate", "John", "Betty", "Dave"]
    var players = ["Kate", "John", "Betty", "Dave", "Betty", "Kate", "John", "Betty", "Dave", "Betty", "Kate", "John", "Betty"]
    
    //TODO: - Посмотреть демо по Table View
    //TODO: - custom header and footer views
    //TODO: - custom table view cell
    
    //TODO: - make table view
    let playersTableView: UITableView = {
        let view = UITableView()
        
        view.register(UITableViewCell.self, forCellReuseIdentifier: "PlayerCellId")
        view.register(UITableViewCell.self, forCellReuseIdentifier: "AddPlayerCellId")
        
        view.backgroundColor     = UIColor(rgb: 0x3B3B3B)
        view.layer.cornerRadius  = 15.0
        view.sectionHeaderHeight = 40.0
        view.rowHeight           = 54.0
        view.tintColor           = UIColor.white
        
        view.isScrollEnabled     = false
        view.isEditing           = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        
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
//        Fonts.printFonts()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    private func setupAppearance() {
        view.backgroundColor = UIColor(rgb: 0x232323)
        
        setupScrollView()
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
        scrollView.addSubview(playersTableView)
        
        let tableViewHeight: CGFloat = (CGFloat(players.count + 1) * playersTableView.rowHeight) + playersTableView.sectionHeaderHeight
        
        NSLayoutConstraint.activate([
            playersTableView.widthAnchor.constraint(equalToConstant: 335.0),
            playersTableView.heightAnchor.constraint(equalToConstant: tableViewHeight),
            playersTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playersTableView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 25.0),
            playersTableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -100.0)
//            playersTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25.0)
        ])
        
        playersTableView.delegate = self
        playersTableView.dataSource = self
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension NewGameViewController : UITableViewDataSource, UITableViewDelegate {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count + 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == players.count {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddPlayerCellId", for: indexPath)
            
            cell.textLabel?.text = "Add player"
            cell.textLabel?.font = UIFont(name: "Nunito-SemiBold", size: 16.0)
            cell.textLabel?.textColor = UIColor(rgb: 0x84B8AD)
            cell.backgroundColor = UIColor(rgb: 0x3B3B3B)
            cell.overrideUserInterfaceStyle = .dark
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCellId", for: indexPath)
                    
            cell.textLabel?.text = players[indexPath.row]
            cell.textLabel?.font = UIFont.nunito(size: 20.0)
            cell.textLabel?.textColor = .white
            cell.backgroundColor = UIColor(rgb: 0x3B3B3B)
            cell.overrideUserInterfaceStyle = .dark
            
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Players"
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != players.count
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return indexPath.row != players.count ? .delete : .insert
    }
    
    // MARK: - mooving rows
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if proposedDestinationIndexPath.row == players.count{
            return IndexPath(row: players.count - 1, section: 0)
        } else {
            return proposedDestinationIndexPath
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        players.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
}
