//
//  LGTimerContentView.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/8/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import Foundation

import UIKit
import MZTimerLabel
import CountdownLabel

class LGTimerContentView: UIView {
    
    
    var isRunning: Bool!
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont (name: "Betm-Regular3", size: 80)
        label.textColor = #colorLiteral(red: 0.921908319, green: 0.9026622176, blue: 0.9022395015, alpha: 1)
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
        timerControl.tintColor = #colorLiteral(red: 0.921908319, green: 0.9026622176, blue: 0.9022395015, alpha: 1)
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
        if timer.getCountDownTime() > 0 && timer.timerType != MZTimerLabelTypeStopWatch {
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
        LGSoundHelper.sharedInstance.playSoundfor(state: .start)
            configureRunningControls()
        }else{
        
            return
        }
    }
    
    func stopTimer() {
LGSoundHelper.sharedInstance.playSoundfor(state: .stop)
        timer.pause()
        timer.reset()
        self.tintColor = #colorLiteral(red: 0.921908319, green: 0.9026622176, blue: 0.9022395015, alpha: 1)
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
//        self.addSubview(backBlurView)
        
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo:  self.centerYAnchor),
            
            countDownTimerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            countDownTimerLabel.centerYAnchor.constraint(equalTo:  self.centerYAnchor),
            
            timerControls.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            timerControls.centerXAnchor.constraint(equalTo: timeLabel.centerXAnchor),
            timerControls.widthAnchor.constraint(equalTo: timeLabel.widthAnchor),
            timerControls.heightAnchor.constraint(equalToConstant: 40),
            
            ])
        super.updateConstraints()
    }
    
}

extension LGTimerContentView: CountdownLabelDelegate {
    func countingAt(timeCounted: TimeInterval, timeRemaining: TimeInterval) {
        timerControls.isHidden = true

        switch timeRemaining {
     case 3:
            LGSoundHelper.sharedInstance.speak(text: "3")

        case 2:
            LGSoundHelper.sharedInstance.speak(text: "2")
        case 1:
            LGSoundHelper.sharedInstance.speak(text: "1")
        default:
            break
        }
    }
    func countdownFinished() {
        timer.start()
        self.tintColor = #colorLiteral(red: 0, green: 0.7402182221, blue: 0.7307808995, alpha: 1)
         timerControls.isHidden = false
        countDownTimerLabel.isHidden = true
        timeLabel.isHidden = false
        
    }
}
