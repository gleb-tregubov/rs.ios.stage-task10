//
//  TimerLabel.swift
//  Task10
//
//  Created by Gleb Tregubov on 29.08.2021.
//

import UIKit

class TimerLabel: UILabel {

    var timerState: TimerState {
        willSet {
            switch newValue {
            case .play:
                textColor = UIColor.white
            case .pause:
                textColor = UIColor(rgb: 0x3B3B3B)
            }
        }
    }
    
    private func setupAppearance() {
        font = UIFont(name: "Nunito-ExtraBold", size: 28.0)
        textColor = UIColor(rgb: 0x3B3B3B)
        translatesAutoresizingMaskIntoConstraints = false
        text = "00:00"
    }
    
    init(state: TimerState) {
        
        self.timerState = state
        
        super.init(frame: .zero)
        
        switch state {
        case .play:
            textColor = UIColor.white
        case .pause:
            textColor = UIColor(rgb: 0x3B3B3B)
        }
        
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
