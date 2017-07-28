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
import CircularSlider
import Intents

class ViewController: UIViewController {
    
    var intervals = 0
    var timer: MZTimerLabel!
    var intervalsLabel: UILabel!
    var circleSlider: CircularSlider!
    var timeLabel: UILabel!
    var userIntent: INStartWorkoutIntent!
    var clockLabel: UILabel!
    var clockTimer = Timer()
    let modes = ["Timer", "Stop Watch", "Tabata"]
    var selectedIndex = 0
    var titleView: UILabel!
    @IBAction func startIntervalPressed(_ sender: Any) {
        startInterval()
    }
    
    @IBAction func resetIntervalPressed(_ sender: Any) {
        timer.reset()
    }
    
    @IBAction func pauseIntervalPressed(_ sender: Any) {
        timer.pause()
    }
    
    @IBOutlet var isIntervals: UISwitch!
    
    @IBAction func switchCounterType(_ sender: Any) {
        if(isIntervals.isOn){
            timer?.setCountDownTime(60)
        }else{
            let totalTime = intervals * 60
            timer?.setCountDownTime(TimeInterval(totalTime))
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.title = "Timer"
        

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(switchMode))
//        tapGesture.delegate = self.view
//        self.navigationItem.titleView?.isUserInteractionEnabled = true
        
        titleView = UILabel()
//        titleView.text = "Hello World"
        let selectedMode = modes[selectedIndex]
        titleView.text = String(selectedMode)
        titleView.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        let width = titleView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).width
        titleView.frame = CGRect(origin:CGPoint.zero, size:CGSize(width: width, height: 40))
        titleView.isUserInteractionEnabled = true
        titleView.addGestureRecognizer(tapGesture)
        self.navigationItem.titleView = titleView
        

        
        
        INPreferences.requestSiriAuthorization { (status) in
            
        }
        INVocabulary.shared().setVocabularyStrings(["interval","emom","time cap", "wod", "timer", "tabata", "amrap", "stopwatch"], of: .workoutActivityName)
        intervals = 1

        
        if ((userIntent) != nil){
           
            let minute = userIntent.goalValue!/60
            intervals = Int(minute)
            configuretimer()
            startInterval()
        }else{

            configuretimer()
        }
        intervalsLabel.text = "Intervals = \(intervals)"
        
    }
    
    func configuretimer() {
        
        makeUserInterface()
              if ((userIntent) != nil){
        switch String(describing: userIntent.workoutName).lowercased() {
        case "interval":
            let minute = userIntent.goalValue!/60
            intervals = Int(minute)
//            intervalsLabel.text = "Intervals = \(intervals)"
            timer = MZTimerLabel(label: timeLabel, andTimerType: MZTimerLabelTypeTimer)
                    timer?.delegate = self
        case "time cap":
            timer = MZTimerLabel(label: timeLabel, andTimerType: MZTimerLabelTypeStopWatch)
            timer.setStopWatchTime(userIntent.goalValue!)
                    timer?.delegate = self
        case "amrap":
            timer = MZTimerLabel(label: timeLabel, andTimerType: MZTimerLabelTypeStopWatch)
            timer.setStopWatchTime(userIntent.goalValue!)
                    timer?.delegate = self
        case "stopwatch":
            timer = MZTimerLabel(label: timeLabel, andTimerType: MZTimerLabelTypeStopWatch)
                    timer?.delegate = self
        default:
            intervals = 1
            intervalsLabel.text = "Intervals = \(intervals)"
            timer = MZTimerLabel(label: timeLabel, andTimerType: MZTimerLabelTypeTimer)
            timer?.setCountDownTime(60)
            timer?.resetTimerAfterFinish = true
                    timer?.delegate = self
        }
              }else{
                intervals = 1
                intervalsLabel.text = "Intervals = \(intervals)"
                timer = MZTimerLabel(label: timeLabel, andTimerType: MZTimerLabelTypeTimer)
                timer?.setCountDownTime(60)
                timer?.resetTimerAfterFinish = true
                timer?.delegate = self
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func switchMode() {
        if (selectedIndex >= 2){
        selectedIndex = 0
        let selectedMode = modes[selectedIndex]
        titleView.text = String(selectedMode)
        return
        }
        selectedIndex += 1
        let selectedMode = modes[selectedIndex]
        titleView.text = String(selectedMode)
        let width = titleView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).width
        titleView.frame = CGRect(origin:titleView.frame.origin, size:CGSize(width: width, height: 40))
        
    }
    
    func startInterval(){
        let systemSoundID: SystemSoundID = 1304
        AudioServicesPlaySystemSound (systemSoundID)
        timer?.start()
        intervals -= 1
    }
    
    func makeUserInterface(){
        circleSlider = CircularSlider(frame:CGRect(x: (self.view.frame.size.width/2)-125, y: 140, width: 250, height: 250))
        circleSlider.delegate = self
        circleSlider.maximumValue = 120
        circleSlider.minimumValue = 1
        circleSlider.knobRadius = 20
        circleSlider.radiansOffset = 0.01
        circleSlider.backgroundColor = .clear
        circleSlider.pgHighlightedColor = UIColor(red:0.83, green:0.00, blue:0.00, alpha:1.00)
        circleSlider.pgNormalColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.00)
        circleSlider.title = "Time"
        circleSlider.divisa = "Min"
        
        timeLabel = UILabel(frame: CGRect(x: 0, y: (self.view.frame.size.height/2)+120, width: self.view.frame.size.width, height: 60))
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont (name: "Avenir-Book", size: 50)
        timeLabel.textColor = UIColor(red:0.83, green:0.00, blue:0.00, alpha:1.00)
        
        intervalsLabel = UILabel(frame: CGRect(x: 0, y: (self.view.frame.size.height/2)+90, width: self.view.frame.size.width, height: 40))
        intervalsLabel.textAlignment = .center
        intervalsLabel.font = UIFont (name: "Avenir-Book", size: 21)
        intervalsLabel.textColor = UIColor(red:0.83, green:0.00, blue:0.00, alpha:1.00)
//        intervalsLabel.text = "Intervals = \(intervals)"
        
        self.navigationController?.progressTintColor = UIColor(red:0.83, green:0.00, blue:0.00, alpha:1.00)
        
        clockLabel = UILabel(frame: CGRect(x: 0, y: 60, width: self.view.frame.size.width, height: 40))
        clockLabel.textAlignment = .center
        clockLabel.font = UIFont (name: "Avenir-Book", size: 21)
        clockLabel.textColor = UIColor(red:0.83, green:0.00, blue:0.00, alpha:1.00)
        
        
        self.view.addSubview(timeLabel)
        self.view.addSubview(intervalsLabel)
        self.view.addSubview(self.circleSlider)
        self.view.addSubview(clockLabel)
        
        clockTimer = Timer.scheduledTimer(timeInterval: 1.0,
                                          target: self,
                                          selector: #selector(tick),
                                          userInfo: nil,
                                          repeats: true)
        
    }
    
    @objc func tick() {
        clockLabel.text = DateFormatter.localizedString(from: NSDate() as Date,
                                                        dateStyle: .none,
                                                        timeStyle: .medium)
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

extension ViewController: CircularSliderDelegate {
    func circularSlider(_ circularSlider: CircularSlider, valueForValue value: Float) -> Float {
        
        if ((userIntent) != nil){
            let minute = userIntent.goalValue!/60
            intervals = Int(minute)
            intervalsLabel.text = "Intervals = \(intervals)"
            return Float(intervals)
        }else{
            intervals = Int(floorf(value))
            intervalsLabel.text = "Intervals = \(intervals)"
            return floorf(value)
        }
        
    }
    
    //    func circularSlider(circularSlider: CircularSlider, didBeginEditing textfield: UITextField){}
    //    func circularSlider(circularSlider: CircularSlider, didEndEditing textfield: UITextField){}
}
