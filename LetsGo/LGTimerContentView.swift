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
import CountdownLabel

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
    
    lazy var countDownTimerLabel: LGCountDownTimer = {
        let countDownTimer = LGCountDownTimer()
        countDownTimer.translatesAutoresizingMaskIntoConstraints = false
        countDownTimer.timeLabel.countdownDelegate = self
        return countDownTimer
    }()
    lazy var timerControls: LGTimerControls = {
        let timerControl = LGTimerControls()
        timerControl.pauseButton.addTarget(self, action: #selector(toggleTimer), for: .touchUpInside)
        timerControl.playButton.addTarget(self, action: #selector(toggleTimer), for: .touchUpInside)
        timerControl.stopButton.addTarget(self, action: #selector(stopTimer), for: .touchUpInside)
        timerControl.translatesAutoresizingMaskIntoConstraints = false
        return timerControl
    }()
    
    override var tintColor: UIColor! {
        didSet {
            timeLabel.textColor = tintColor
            timerControls.tintColor = tintColor
            setNeedsDisplay()
        }
    }
    func toggleTimer() {
     

        if(!isRunning) {
            isRunning = true
            self.tintColor = #colorLiteral(red: 0.9765378833, green: 0.8906318545, blue: 0.4612582326, alpha: 1)
            countDownTimerLabel.isHidden = false
            timeLabel.isHidden = true
            countDownTimerLabel.timeLabel.setCountDownTime(minutes: 10)
            countDownTimerLabel.timeLabel.start()
        }else{
            timer.pause()
            self.tintColor = #colorLiteral(red: 0.5015509129, green: 0.5780293345, blue: 0.8545677066, alpha: 1)
            isRunning = false
        }
           playSound()
        configureRunningControls()
    }
    
    func stopTimer() {
        playSound()
       timer.pause()
        timer.reset()
          self.tintColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
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
        self.addSubview(countDownTimerLabel)
        self.bringSubview(toFront: countDownTimerLabel)
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
            
            countDownTimerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            countDownTimerLabel.centerYAnchor.constraint(equalTo:  self.centerYAnchor),
//            countDownTimerLabel.widthAnchor.constraint(equalTo: timeLabel.widthAnchor),
//            countDownTimerLabel.heightAnchor.constraint(equalTo: timeLabel.heightAnchor),
            
            timerControls.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            timerControls.centerXAnchor.constraint(equalTo: timeLabel.centerXAnchor),
            timerControls.widthAnchor.constraint(equalTo: timeLabel.widthAnchor),
            timerControls.heightAnchor.constraint(equalToConstant: 40)
            ])
        super.updateConstraints()
    }
    
}

extension LGTimerContentView: CountdownLabelDelegate {
     func countingAt(timeCounted: TimeInterval, timeRemaining: TimeInterval) {
        switch timeRemaining {
        case 3:
            let synthesizer = AVSpeechSynthesizer()
            let utterance = AVSpeechUtterance(string: "3")
            utterance.rate = 0.7
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            synthesizer.speak(utterance)
        case 2:
            let synthesizer = AVSpeechSynthesizer()
            let utterance = AVSpeechUtterance(string: "2")
            utterance.rate = 0.7
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            synthesizer.speak(utterance)
        case 1:
            let synthesizer = AVSpeechSynthesizer()
            let utterance = AVSpeechUtterance(string: "1")
            utterance.rate = 0.7
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            synthesizer.speak(utterance)
        default:
            break
        }
    }
    func countdownFinished() {
        timer.start()
        self.tintColor = #colorLiteral(red: 0, green: 0.7402182221, blue: 0.7307808995, alpha: 1)
     
        countDownTimerLabel.isHidden = true
        timeLabel.isHidden = false
        
    }
}
