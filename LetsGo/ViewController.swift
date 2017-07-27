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
import AVFoundation
import CircleSlider

class ViewController: UIViewController {

    var intervals = 0
    var timer: MZTimerLabel!
    var intervalsLabel: UILabel!
    var circleSlider: CircleSlider!
    var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.circleSlider = CircleSlider(frame:  CGRect(x: (self.view.frame.size.width/2)-125, y: 140, width: 250, height: 250), options: nil)
        self.circleSlider.changeOptions([.barWidth(45)])
        self.circleSlider.changeOptions([.maxValue(60)])
        self.circleSlider.changeOptions([.minValue(20)])
        self.circleSlider.changeOptions([.startAngle(45)])
        self.circleSlider.changeOptions([.thumbColor(UIColor(red: 141/255, green: 185/255, blue: 204/255, alpha: 1))])
        self.circleSlider.changeOptions([.trackingColor(UIColor(red: 78/255, green: 136/255, blue: 185/255, alpha: 1))])
        self.circleSlider.changeOptions([.barColor(UIColor(red: 198/255, green: 244/255, blue: 23/255, alpha: 0.2))])
        self.circleSlider.changeOptions([.sliderEnabled(true)])
        
        self.circleSlider?.addTarget(self, action: #selector(valueChange), for: .valueChanged)
        
        
        self.view.addSubview(self.circleSlider)
        
        
        
        
        intervals = 10
        timeLabel = UILabel(frame: CGRect(x: 0, y: (self.view.frame.size.height/2)+40, width: self.view.frame.size.width, height: 40))
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont (name: "Avenir-Book", size: 30)
        timeLabel.textColor = UIColor(red:0.83, green:0.00, blue:0.00, alpha:1.00)
        
        intervalsLabel = UILabel(frame: CGRect(x: 0, y: (self.view.frame.size.height/2), width: self.view.frame.size.width, height: 40))
        intervalsLabel.textAlignment = .center
        intervalsLabel.font = UIFont (name: "Avenir-Book", size: 30)
        intervalsLabel.textColor = UIColor(red:0.83, green:0.00, blue:0.00, alpha:1.00)
        intervalsLabel.text = "Intervals = \(intervals)"
        
        
        timer = MZTimerLabel(label: timeLabel, andTimerType: MZTimerLabelTypeTimer)
        timer?.setCountDownTime(60)
        timer?.resetTimerAfterFinish = true
        
        self.view.addSubview(timeLabel)
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
    
    func valueChange(){

    }

}
extension ViewController: MZTimerLabelDelegate {
    func timerLabel(_ timerLabel: MZTimerLabel!, countingTo time: TimeInterval, timertype timerType: MZTimerLabelType){
        let progress = time/timerLabel.getCountDownTime()
        self.navigationController?.progress = Float(progress)
        intervalsLabel.text = "Intervals = \(intervals)"
    }
    
    func timerLabel(_ timerLabel: MZTimerLabel!, finshedCountDownTimerWithTime countTime: TimeInterval){
        if (intervals > 0){
        startInterval()
        }
    }
}
