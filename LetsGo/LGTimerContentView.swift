//
//  LGTimerContentView.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/8/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
import MZTimerLabel

class LGTimerContentView: UIView {
    
    var player: AVAudioPlayer?

    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont (name: "Betm-Regular3", size: 60)
        label.textColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var timer: MZTimerLabel = {
        let timer = MZTimerLabel(label: self.timeLabel)
        timer?.timerType = MZTimerLabelTypeTimer
        timer?.resetTimerAfterFinish = false
        return timer!
    }()
    
    lazy var timerControls: LGTimerControls = {
        let timerControl = LGTimerControls()
        timerControl.translatesAutoresizingMaskIntoConstraints = false
        return timerControl
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(timeLabel)
        self.addSubview(timerControls)
        self.bringSubview(toFront: timeLabel)
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "tone", withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo:  self.centerYAnchor),
            timeLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            timeLabel.heightAnchor.constraint(equalToConstant: 70),
            
            timerControls.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            timerControls.centerXAnchor.constraint(equalTo: timeLabel.centerXAnchor),
            timerControls.widthAnchor.constraint(equalTo: self.widthAnchor),
            timerControls.heightAnchor.constraint(equalToConstant: 40)
            ])
        super.updateConstraints()
    }
    
}
