//
//  TimerButton.swift
//  Task10
//
//  Created by Gleb Tregubov on 29.08.2021.
//

import UIKit

enum TimerState {
    case play
    case pause
}

class TimerButton: UIButton {
    
    static let timerButtonConfig = UIImage.SymbolConfiguration(pointSize: 20.0, weight: .black, scale: .medium)
    
    var timerState: TimerState {
        willSet {
            switch newValue {
            case .play:
                setImage(UIImage(systemName: "play", withConfiguration: TimerButton.timerButtonConfig), for: .normal)
            case .pause:
                setImage(UIImage(systemName: "pause", withConfiguration: TimerButton.timerButtonConfig), for: .normal)
            }
        }
    }

    private func setupAppearance() {
        tintColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(state: TimerState) {
        
        self.timerState = state
        
        super.init(frame: .zero)
        
        switch state {
        case .play:
            self.setImage(UIImage(systemName: "play", withConfiguration: TimerButton.timerButtonConfig), for: .normal)
        case .pause:
            self.setImage(UIImage(systemName: "pause", withConfiguration: TimerButton.timerButtonConfig), for: .normal)
        }
        
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
