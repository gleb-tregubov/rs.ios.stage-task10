//
//  NewGameViewController.swift
//  Task10
//
//  Created by Gleb Tregubov on 25.08.2021.
//

import UIKit

class NewGameViewController: UIViewController, NewGameViewControllerProtocol {
    
    var players = [Player]()
//    var players = ["Kate", "John", "Betty"]
//    var players = ["Kate", "John", "Betty", "Dave", "Betty", "Kate", "John", "Betty", "Dave", "Betty", "Kate", "John", "Betty"]
    
    //TODO: - Посмотреть демо по Table View
    //TODO: - custom header and footer views
    //TODO: - custom table view cell
    
    var addPlayerViewController = AddPlayerViewController()
    var gameProcessViewController = GameProcessViewController()
    
    // MARK: - Views
    let playersTableView: UITableView = {
        let view = UITableView()
        
        view.register(UITableViewCell.self, forCellReuseIdentifier: "PlayerC{ellId")
        view.register(UITableViewCell.self, forCellReuseIdentifier: "AddPlayerCellId")
        view.register(PlayerTableViewCell.self, forCellReuseIdentifier: PlayerTableViewCell.reuseIdentifier)
        
        view.register(PlayersTabelHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: PlayersTabelHeaderFooterView.identifier)
        
        view.backgroundColor     = UIColor(rgb: 0x3B3B3B)
        view.layer.cornerRadius  = 15.0
        view.sectionHeaderHeight = 40.0
        view.rowHeight           = 54.0
        view.tintColor           = UIColor.white
        
        view.isScrollEnabled     = false
        view.isEditing           = true
        
        view.allowsSelectionDuringEditing              = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var tableViewHeight: CGFloat {
        (CGFloat(players.count + 1) * playersTableView.rowHeight) + playersTableView.sectionHeaderHeight
    }
    
    var tableViewHeightConstraint: NSLayoutConstraint!
    var tableViewBottomConstraint: NSLayoutConstraint!
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.bounces = true
        view.alwaysBounceVertical = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let startButton: UIButton = {
        let view = StartGameButton()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    // MARK: - LifeCylce
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAppearance()
    }
    
    
    // MARK: - Views Configuration
    private func setupAppearance() {
        view.backgroundColor = UIColor(rgb: 0x232323)
        
        setupScrollView()
        setupNavigationBar()
        setupStartGameButton()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Game Counter"
        navigationItem.largeTitleDisplayMode = .always
        
        let cancelLeftBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
        cancelLeftBarButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Nunito-ExtraBold", size: 17.0) as Any], for: .normal)
        cancelLeftBarButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Nunito-ExtraBold", size: 17.0) as Any], for: .highlighted)
        
        
        navigationItem.leftBarButtonItem = cancelLeftBarButton
    }
    
    @objc func cancelTapped() {
        print("Cancel Tapped")
    }
    
    private func setupTableView() {
        scrollView.addSubview(playersTableView)
        
        tableViewHeightConstraint = NSLayoutConstraint(item: playersTableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: tableViewHeight)
        
        tableViewBottomConstraint = NSLayoutConstraint(item: playersTableView, attribute: .bottom, relatedBy: .equal, toItem: startButton, attribute: .top, multiplier: 1.0, constant: -460.0) // ??????????????
        
    
        NSLayoutConstraint.activate([
            playersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            playersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            tableViewHeightConstraint,
            playersTableView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 25.0),
            tableViewBottomConstraint
        ])
        
        // TODO: - Refactoring
        
        // NewGameViewController закрыть протоколом с нужными пропертями в виде модели
        // PlayersTableDelegate подписать под tableViewDataSource, и talbeViewDelegate
        // let playersTableDelegate = PlayersTableDelegate()
        // playersTableDelegate.parent = self (Проперти parent сделать weak варом)
        //хотя нет, делегата может не быть потэтому у self контроллера делегатное проперти - weak var
        // playersTableView.delegate = playersTableDelegate
        // playersTableView.delegate = playersTableDelegate
        
        
        playersTableView.delegate = self
        playersTableView.dataSource = self
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        
//        subscribeForKeyboardNotifications()
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupStartGameButton() {
        scrollView.addSubview(startButton)
        
        startButton.addTarget(self, action: #selector(startButtonHandler), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            startButton.heightAnchor.constraint(equalToConstant: 65.0),
            startButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -45.0),
            startButton.widthAnchor.constraint(equalToConstant: 335.0),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func startButtonHandler() {
        print(players)
        
        players = players.map({ player in
            Player(name: player.name, score: 0)
        })
        gameProcessViewController.players = players
        gameProcessViewController.newGameViewController = self
        navigationController?.pushViewController(gameProcessViewController, animated: true)
    }

}

extension NewGameViewController : UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == players.count {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddPlayerCellId", for: indexPath)
            
            cell.textLabel?.text = "Add player"
            cell.textLabel?.font = UIFont(name: "Nunito-SemiBold", size: 16.0)
            cell.textLabel?.textColor = UIColor(rgb: 0x84B8AD)
            cell.imageView?.image = UIImage(systemName: "plus.circle.fill")
            cell.imageView?.tintColor = UIColor(rgb: 0x84B8AD)
            cell.backgroundColor = UIColor(rgb: 0x3B3B3B)
            cell.overrideUserInterfaceStyle = .dark
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: PlayerTableViewCell.reuseIdentifier) as! PlayerTableViewCell
            
            cell.playerNameTextField.text = players[indexPath.row].name
            cell.playerNameTextField.delegate = self
//            hiddenWhenTappedAround()
            cell.playerNameTextField.addTarget(self, action: #selector(playerNameChanged(_ :)), for: .editingChanged)
            
            return cell
            
//            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCellId", for: indexPath)
//
//            cell.textLabel?.text = players[indexPath.row]
//            cell.textLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 20.0)
//            cell.textLabel?.textColor = .white
//            cell.backgroundColor = UIColor(rgb: 0x3B3B3B)
//            cell.overrideUserInterfaceStyle = .dark
//            cell.isEditing = true
//
//            return cell
            
        }
        
    }
    
    // MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: PlayersTabelHeaderFooterView.identifier)
        return header
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != players.count
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != players.count
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return indexPath.row != players.count ? .delete : .insert
    }
    
    // MARK: - Mooving Rows
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
    
    // MARK: - Deleting Rows
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            players.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // Update table view height and spacing constraints based on rows count and theirs size
            if players.count < 6 {
                let tableViewButtonSpace = tableViewBottomConstraint.constant - tableView.rowHeight
                
                tableView.removeConstraints([tableViewHeightConstraint, tableViewBottomConstraint])
                tableViewHeightConstraint.constant = tableViewHeight
                tableViewBottomConstraint.constant = tableViewButtonSpace
                
                tableViewHeightConstraint.isActive = true
                tableViewBottomConstraint.isActive = true
                
                playersTableView.layoutIfNeeded()
                startButton.layoutIfNeeded()
            } else {
                tableView.removeConstraint(tableViewHeightConstraint)
                tableViewHeightConstraint.constant = tableViewHeight
                tableViewHeightConstraint.isActive = true
                
                playersTableView.layoutIfNeeded()
                startButton.layoutIfNeeded()
            }
            
            tableView.endUpdates()
        }
    }
    
    // MARK: - Adding rows
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("add Player")
        
        if indexPath.row != players.count {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        
        addPlayerViewController.newGameViewController = self
        navigationController?.pushViewController(addPlayerViewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - Public Interface | NewGameViewController Protocol
extension NewGameViewController {
    func addNewPlayer(name playerName: String) {
        
        playersTableView.beginUpdates()
        
        let newPlayer = Player(name: playerName)
        
        players.append(newPlayer)
        playersTableView.insertRows(at: [IndexPath(row: players.count - 1, section: 0)], with: .fade) // НЕУВЕРЕН
        
        // Update table view height and spacing constraints based on rows count and theirs size
        if players.count < 7 {
            let tableViewButtonSpace = tableViewBottomConstraint.constant + playersTableView.rowHeight
            
            playersTableView.removeConstraints([tableViewHeightConstraint, tableViewBottomConstraint])
            tableViewHeightConstraint.constant = tableViewHeight
            tableViewBottomConstraint.constant = tableViewButtonSpace
            
            tableViewHeightConstraint.isActive = true
            tableViewBottomConstraint.isActive = true
            
            playersTableView.layoutIfNeeded()
            startButton.layoutIfNeeded()
            
            playersTableView.deselectRow(at: IndexPath(row: players.count - 1, section: 0), animated: true)
        } else {
            
            playersTableView.removeConstraint(tableViewHeightConstraint)
            tableViewHeightConstraint.constant = tableViewHeight
            tableViewHeightConstraint.isActive = true
            
            playersTableView.layoutIfNeeded()
            startButton.layoutIfNeeded()
            
        }
        
        playersTableView.endUpdates()
        
    }
}


// MARK: - Player Name Text Field | UITextField Delegate
extension NewGameViewController: UITextFieldDelegate {
    
    @objc func playerNameChanged(_ sender:Any) {

        let playerNameTextField = sender as! UITextField

        let cell = (playerNameTextField.superview)?.superview as! PlayerTableViewCell

        let indexPath = playersTableView.indexPath(for: cell)!

        let updatePlayerName = cell.playerNameTextField.text

        players[indexPath.row].name = updatePlayerName ?? ""

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    //MARK: - Keyboard Interactions
    
    private func subscribeForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRect = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRect.height
            scrollView.setContentOffset(CGPoint(x: 0, y: keyboardHeight - view.safeAreaInsets.bottom), animated: true)
            
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        scrollView.setContentOffset(CGPoint.zero, animated: true)
    }
    
}
