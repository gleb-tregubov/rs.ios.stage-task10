//
//  GameProcessViewController.swift
//  Task10
//
//  Created by Gleb Tregubov on 28.08.2021.
//

import UIKit

class GameProcessViewController: UIViewController {
    
    var players: [Player]!
    
    weak var newGameViewController: NewGameViewControllerProtocol!
    var resultsViewConroller = ResultsViewController()
    
    lazy var playersCollectionView: UICollectionView = {
        
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
    
    let scoreButtonsStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.spacing = 15.0
        view.alignment = .fill
        view.distribution = .equalSpacing
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let controlsGameProcessStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.spacing = 62.0
        view.alignment = .center
        view.distribution = .equalSpacing
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let timerStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.spacing = 20.0
        view.alignment = .center
        view.distribution = .equalSpacing
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let timerLabel = TimerLabel(state: .play)
    
    let pageControlStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.spacing = 5.0
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let uturnBackwardButton: UIButton = {
        let view = UIButton()
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 20.0, weight: .semibold, scale: .medium)
        
        view.setImage(UIImage(systemName: "arrow.uturn.backward", withConfiguration: configuration), for: .normal)
        view.tintColor = UIColor(rgb: 0xDEDEDE)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(uturnBackwardButtonHandler(_:)), for: .touchUpInside)
        
        return view
    }()
    
    let bottomControlsStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .equalSpacing
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
//    let pageControlUndoStackView: UIStackView = {
//        let view = UIStackView()
//
//        view.axis = .horizontal
//        view.spacing
//
//        return view
//    }()
    
//    let pageControl: UIPageControl = {
//        let view = UIPageControl()
//
//        view.pageIndicatorTintColor = .gray
//        view.currentPageIndicatorTintColor = .white
//        view.translatesAutoresizingMaskIntoConstraints = false
//
//        return view
//    }()
//
    var currentPage = 0 {
        didSet {
            if pageControlStackView.arrangedSubviews.count > 0 {
                pageControlStackView.arrangedSubviews.forEach { view in
                    let label = view as! UILabel
                    label.textColor = UIColor(rgb: 0x3B3B3B)
                }
                (pageControlStackView.arrangedSubviews[currentPage] as! UILabel).textColor = UIColor(rgb: 0xDEDEDE)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        players = newGameViewController.players
        
        setupAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
//        players = newGameViewController.players
        
        pageControlStackView.setNeedsDisplay()
        
        playersCollectionView.reloadData()
    }
    
    private func setupAppearance() {
        view.backgroundColor = UIColor(rgb: 0x232323)
        
        setupNavigationBar()
        setupPlayersCollectionView()
        setupScoreButtonsStackView()
        setupControlsGameProcessStackView()
        setupTimerStackView()
        setupPageControlStackView()
        setupBottomControlsStackView()
        setupUturnBackwardButton()
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
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func resultsTapped() {
        
        resultsViewConroller.gameProcessViewController = self
        navigationController?.pushViewController(resultsViewConroller, animated: true)
    }
    
    private func setupPlayersCollectionView() {
        view.addSubview(playersCollectionView)
        
        NSLayoutConstraint.activate([
            playersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playersCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playersCollectionView.heightAnchor.constraint(equalToConstant: 300.0)
        ])
    }
    
    private func setupScoreButtonsStackView() {
        view.addSubview(scoreButtonsStackView)
        
        let scoreButtons = [
            ScoreButton(scorePoint: -10),
            ScoreButton(scorePoint: -5),
            ScoreButton(scorePoint: -1),
            ScoreButton(scorePoint: +5),
            ScoreButton(scorePoint: +10),
        ]
        
        scoreButtons.forEach { button in
            button.heightAnchor.constraint(equalToConstant: 55.0).isActive = true
            button.widthAnchor.constraint(equalToConstant: 55.0).isActive = true
            button.addTarget(self, action: #selector(scoreButtonHandler(_:)), for: .touchUpInside)
            
            scoreButtonsStackView.addArrangedSubview(button)
        }
        
        
//        NSLayoutConstraint.activate([
//            scoreButtonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            scoreButtonsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -74.0)
//        ])
    }
    
    private func setupControlsGameProcessStackView() {
        view.addSubview(controlsGameProcessStackView)
        
        let mainScoreButton = ScoreButton(scorePoint: +1, size: .big)
        mainScoreButton.addTarget(self, action: #selector(scoreButtonHandler(_:)), for: .touchUpInside)
        mainScoreButton.heightAnchor.constraint(equalToConstant: 90.0).isActive = true
        mainScoreButton.widthAnchor.constraint(equalToConstant: 90.0).isActive = true
        
        let arrowRightButton = ArrowButton(direction: .right, state: .normal)
        arrowRightButton.addTarget(self, action: #selector(arrowButtonHandler(_:)), for: .touchUpInside)
        
        let arrowLeftButton = ArrowButton(direction: .left, state: .border)
        arrowLeftButton.addTarget(self, action: #selector(arrowButtonHandler(_:)), for: .touchUpInside)
        
        controlsGameProcessStackView.addArrangedSubview(arrowLeftButton)
        controlsGameProcessStackView.addArrangedSubview(mainScoreButton)
        controlsGameProcessStackView.addArrangedSubview(arrowRightButton)
        
//        NSLayoutConstraint.activate([
//            controlsGameProcessStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            controlsGameProcessStackView.bottomAnchor.constraint(equalTo: scoreButtonsStackView.topAnchor, constant: -22.0)
//        ])
        
    }
    
    @objc private func scoreButtonHandler(_ sender: Any) {
        let scoreButton = sender as! ScoreButton
        
        let currentPage = getCurrentPage()
        let corePoint = scoreButton.scorePoint
        
        players[currentPage].score += corePoint
        playersCollectionView.reloadItems(at: [IndexPath(row: currentPage, section: 0)])
        
//        playersCollectionView.scrollToItem(at: IndexPath(row: currentPage + 1, section: 0), at: .bottom, animated: true)
        
        
//        print(scoreButton.scorePoint)
    }
    
    @objc private func arrowButtonHandler(_ sender: Any) {
        let arrowButton = sender as! ArrowButton
        
        let currentPage = getCurrentPage()
        
        switch arrowButton.arrowDirection {
        case .right:
            if currentPage == players.count - 1 {
                (controlsGameProcessStackView.arrangedSubviews[0] as! ArrowButton).arrowState = .border
            } else {
                (controlsGameProcessStackView.arrangedSubviews[0] as! ArrowButton).arrowState = .normal
            }
            playersCollectionView.scrollToItem(at: IndexPath(row: currentPage + 1, section: 0), at: .bottom, animated: true)
            if currentPage == players.count - 2 {
                arrowButton.arrowState = .border
            } else {
                arrowButton.arrowState = .normal
            }
        case .left:
            if currentPage == 0 {
                (controlsGameProcessStackView.arrangedSubviews[2] as! ArrowButton).arrowState = .border
            } else {
                (controlsGameProcessStackView.arrangedSubviews[2] as! ArrowButton).arrowState = .normal
            }
            if currentPage == 0 {
                playersCollectionView.scrollToItem(at: IndexPath(row: players.count - 1, section: 0), at: .bottom, animated: true)
            } else {
                playersCollectionView.scrollToItem(at: IndexPath(row: currentPage - 1, section: 0), at: .bottom, animated: true)

            }
            if currentPage == 1 {
                arrowButton.arrowState = .border
            } else {
                arrowButton.arrowState = .normal
            }
        }
        
//        playersCollectionView.scrollToItem(at: IndexPath(row: currentPage + 1, section: 0), at: .bottom, animated: true)
        
        print("direction: \(arrowButton.arrowDirection), state: \(arrowButton.arrowState)")
        
    }
    
    private func setupTimerStackView() {
        view.addSubview(timerStackView)
        
        let timerButton = TimerButton(state: .play)
        timerButton.addTarget(self, action: #selector(timerButtonHandler(_:)), for: .touchUpInside)
        
        timerStackView.addArrangedSubview(timerLabel)
        timerStackView.addArrangedSubview(timerButton)
        
        NSLayoutConstraint.activate([
            timerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerStackView.bottomAnchor.constraint(equalTo: playersCollectionView.topAnchor, constant: -42.0)
        ])
    }
    
    @objc private func timerButtonHandler(_ sender:Any) {
        let timerButton = sender as! TimerButton
        
        switch timerButton.timerState {
        case .play:
            timerButton.timerState = .pause
            timerLabel.timerState = .play
        case .pause:
            timerButton.timerState = .play
            timerLabel.timerState = .pause
        }
        
    }
    
    private func setupPageControlStackView() {
        view.addSubview(pageControlStackView)
        
//        let players = ["Kate", "John", "Bety"]
        
        players.forEach { player in
            let playerControlLabel = UILabel()
            playerControlLabel.text = player.name.prefix(1).uppercased()
            playerControlLabel.font = UIFont(name: "Nunito-ExtraBold", size: 20.0)
            playerControlLabel.textColor = UIColor(rgb: 0x3B3B3B)
            playerControlLabel.translatesAutoresizingMaskIntoConstraints = false
            
            pageControlStackView.addArrangedSubview(playerControlLabel)
        }
        
        
//        NSLayoutConstraint.activate([
//            pageControlStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            pageControlStackView.topAnchor.constraint(equalTo: scoreButtonsStackView.bottomAnchor, constant: 20.0)
//        ])
    }
    
    private func setupUturnBackwardButton() {
        view.addSubview(uturnBackwardButton)
        
        NSLayoutConstraint.activate([
            uturnBackwardButton.centerYAnchor.constraint(equalTo: pageControlStackView.centerYAnchor),
            uturnBackwardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40.0)
        ])
    }
    
    @objc private func uturnBackwardButtonHandler(_ sender: Any) {
        print("uturn backward button tapped")
    }
    
    private func setupBottomControlsStackView() {
        view.addSubview(bottomControlsStackView)
        
        bottomControlsStackView.addArrangedSubview(controlsGameProcessStackView)
        bottomControlsStackView.addArrangedSubview(scoreButtonsStackView)
        bottomControlsStackView.addArrangedSubview(pageControlStackView)
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.topAnchor.constraint(equalTo: playersCollectionView.bottomAnchor, constant: 28.0),
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30.0),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
//    private func setupPageControl() {
//        view.addSubview(pageControl)
//
//        NSLayoutConstraint.activate([
//            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            pageControl.topAnchor.constraint(equalTo: scoreButtonsStackView.bottomAnchor, constant: -20.0),
//            pageControl.heightAnchor.constraint(equalToConstant: 20.0)
//        ])
//    }
    
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
        return players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayerCollectionViewCell.reuseIdentifier, for: indexPath) as! PlayerCollectionViewCell
        
        cell.playerNameLabel.text = players[indexPath.row].name.uppercased()
        cell.playerScoreLabel.text = "\(players[indexPath.row].score)"
        
        
        return cell
    }
    
    
}

extension GameProcessViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
        
        if true {
            if currentPage == players.count - 1 {
                (controlsGameProcessStackView.arrangedSubviews[2] as! ArrowButton).arrowState = .border
            } else {
                (controlsGameProcessStackView.arrangedSubviews[2] as! ArrowButton).arrowState = .normal
            }
        
            if currentPage == 0 {
                (controlsGameProcessStackView.arrangedSubviews[0] as! ArrowButton).arrowState = .border
            } else {
                (controlsGameProcessStackView.arrangedSubviews[0] as! ArrowButton).arrowState = .normal
            }
        }
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        currentPage = getCurrentPage()
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
        
    }
    
}

private extension GameProcessViewController {
    
    func getCurrentPage() -> Int {
        let visibleRect = CGRect(origin: playersCollectionView.contentOffset, size: playersCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = playersCollectionView.indexPathForItem(at: visiblePoint) {
            return visibleIndexPath.row
        }
        
        return currentPage
    }
    
}
