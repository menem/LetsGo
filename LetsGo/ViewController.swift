//
//  ViewController.swift
//  LetsGo
//
//  Created by Menem Ragab on 7/26/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit
import MZTimerLabel
import KYNavigationProgress
import HGCircularSlider
import AVFoundation
class ViewController: UIViewController {

    var intervals = 0
    var timer: MZTimerLabel!
    var intervalsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        intervals = 10
        let timerLabel = UILabel(frame: CGRect(x: 0, y: (self.view.frame.size.height/2)+40, width: self.view.frame.size.width, height: 40))
        timerLabel.textAlignment = .center
        timerLabel.font = UIFont (name: "Avenir-Book", size: 30)
        timerLabel.textColor = UIColor(red:0.83, green:0.00, blue:0.00, alpha:1.00)
        
        intervalsLabel = UILabel(frame: CGRect(x: 0, y: (self.view.frame.size.height/2), width: self.view.frame.size.width, height: 40))
        intervalsLabel.textAlignment = .center
        intervalsLabel.font = UIFont (name: "Avenir-Book", size: 30)
        intervalsLabel.textColor = UIColor(red:0.83, green:0.00, blue:0.00, alpha:1.00)
        intervalsLabel.text = "Intervals = \(intervals)"
        
        
        timer = MZTimerLabel(label: timerLabel, andTimerType: MZTimerLabelTypeTimer)
        timer?.setCountDownTime(60)
        timer?.resetTimerAfterFinish = true
        
        self.view.addSubview(timerLabel)
        self.view.addSubview(intervalsLabel)
        
        self.navigationController?.progressTintColor = UIColor(red:0.83, green:0.00, blue:0.00, alpha:1.00)
        timer?.delegate = self
        
        startInterval()
        

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startInterval(){
        // to play sound
        let systemSoundID: SystemSoundID = 1304
        AudioServicesPlaySystemSound (systemSoundID)
        timer.start()
        intervals -= 1
    }

}
extension ViewController: MZTimerLabelDelegate {
    func timerLabel(_ timerLabel: MZTimerLabel!, countingTo time: TimeInterval, timertype timerType: MZTimerLabelType){
        let progress = time/timerLabel.getCountDownTime()
        self.navigationController?.progress = Float(progress)
        timerLabel.text = "Intervals = \(intervals)"
    }
    
    func timerLabel(_ timerLabel: MZTimerLabel!, finshedCountDownTimerWithTime countTime: TimeInterval){
        if (intervals > 0){
        startInterval()
        }
    }
}
