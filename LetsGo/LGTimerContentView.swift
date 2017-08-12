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
    var isRunning: Bool!
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont (name: "Betm-Regular3", size: 60)
        label.textColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        label.sizeToFit()
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
        timerControl.pauseButton.addTarget(self, action: #selector(toggleTimer), for: .touchUpInside)
        timerControl.playButton.addTarget(self, action: #selector(toggleTimer), for: .touchUpInside)
        timerControl.stopButton.addTarget(self, action: #selector(stopTimer), for: .touchUpInside)
        timerControl.translatesAutoresizingMaskIntoConstraints = false
        return timerControl
    }()
    
    func toggleTimer() {
        playSound()

        if(!isRunning) {
            timer.start()
            timeLabel.textColor = #colorLiteral(red: 0, green: 0.7402182221, blue: 0.7307808995, alpha: 1)
            timerControls.adjustTintColor(newColor: #colorLiteral(red: 0, green: 0.7402182221, blue: 0.7307808995, alpha: 1))
            isRunning = true
        }else{
            timer.pause()
            timeLabel.textColor = #colorLiteral(red: 0.5015509129, green: 0.5780293345, blue: 0.8545677066, alpha: 1)
            timerControls.adjustTintColor(newColor: #colorLiteral(red: 0.5015509129, green: 0.5780293345, blue: 0.8545677066, alpha: 1))
            isRunning = false
        }
        configureRunningControls()
    }
    
    func stopTimer() {
        playSound()
       timer.pause()
        timer.reset()
        timeLabel.textColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        timerControls.adjustTintColor(newColor: #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1))
        isRunning = false
        configureRunningControls()
    }
    
    func configureRunningControls() {
        if(isRunning) {
            timerControls.playButton.isHidden = true
            timerControls.pauseButton.isHidden = false
            timerControls.stopButton.isHidden = false
        }else{
            timerControls.playButton.isHidden = false
            timerControls.pauseButton.isHidden = true
            timerControls.stopButton.isHidden = true
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        isRunning = false
        configureRunningControls()
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
        
            timerControls.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            timerControls.centerXAnchor.constraint(equalTo: timeLabel.centerXAnchor),
            timerControls.widthAnchor.constraint(equalTo: timeLabel.widthAnchor),
            timerControls.heightAnchor.constraint(equalToConstant: 40)
            ])
        super.updateConstraints()
    }
    
}
