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
    var IntervalcircleSlider: CircularSlider!
    var timeLabel: UILabel!
    var userIntent: INStartWorkoutIntent!
    var clockLabel: UILabel!
    var clockTimer = Timer()
    let modes = ["timer", "stopwatch", "tabata"]
    var selectedIndex = 0
    var titleView: UILabel!
    var isInterval: Bool!
    var onInterval = 0.0
    var offInterval = 0.0
    var ontimer: MZTimerLabel!
    var offtimer: MZTimerLabel!
    var roundsCircleSlider: CircularSlider!
    var onCircleSlider: CircularSlider!
    var offCircleSlider: CircularSlider!
    
    @IBAction func startIntervalPressed(_ sender: Any) {
        let selectedMode = modes[selectedIndex]
        if (selectedMode == "tabata"){
            ontimer.start()
            return
        }
        startInterval()
    }
    
    @IBAction func resetIntervalPressed(_ sender: Any) {
        stopTimer()
    }
    
    @IBAction func pauseIntervalPressed(_ sender: Any) {
        timer.pause()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(switchMode))

        titleView = UILabel()
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
        makeUserInterface()
       
        if ((userIntent) != nil){
            
            let minute = userIntent.goalValue!/60
            intervals = Int(minute)
            configuretimer()
            startInterval()
        }else{
            
            configuretimer()
        }
        configureUserInterfaceforMode(usermode: selectedMode)
        
        intervalsLabel.text = "Intervals = \(intervals)"
        
    }
    
    func configuretimer() {
        ontimer = MZTimerLabel(label: timeLabel, andTimerType: MZTimerLabelTypeTimer)
        //        timer?.setCountDownTime(60)
        ontimer?.resetTimerAfterFinish = true
        ontimer?.delegate = self
        offtimer = MZTimerLabel(label: timeLabel, andTimerType: MZTimerLabelTypeTimer)
        //        timer?.setCountDownTime(60)
        offtimer?.resetTimerAfterFinish = true
        offtimer?.delegate = self
        
        if ((userIntent) != nil){
            switch String(describing: userIntent.workoutName).lowercased() {
            case "interval":
                let minute = userIntent.goalValue!/60
                intervals = Int(minute)
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
                timer = MZTimerLabel(label: timeLabel, andTimerType: MZTimerLabelTypeTimer)
                timer?.setCountDownTime(60)
                timer?.resetTimerAfterFinish = true
                timer?.delegate = self
            }
        }else{
            intervals = 1
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
                    configureUserInterfaceforMode(usermode: selectedMode)
            return
        }
        selectedIndex += 1
        let selectedMode = modes[selectedIndex]
        titleView.text = String(selectedMode)
        let width = titleView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).width
        titleView.frame = CGRect(origin:titleView.frame.origin, size:CGSize(width: width, height: 40))
        configureUserInterfaceforMode(usermode: selectedMode)
    }
    
    func startInterval(){
        


        
        let systemSoundID: SystemSoundID = 1304
        AudioServicesPlaySystemSound (systemSoundID)
        timer?.start()
        intervals -= 1
    }
    
    func stopTimer(){
        let selectedMode = modes[selectedIndex]
        if (selectedMode == "tabata"){
            ontimer.pause()
            ontimer.reset()
            offtimer.pause()
            offtimer.reset()
        }
        timer.pause()
        timer.reset()
    }
    func configureUserInterfaceforMode(usermode: String) {
        stopTimer()
        
        switch usermode {
        case "stopwatch":
            print("Stop Watch Selected")
            timer = MZTimerLabel(label: timeLabel, andTimerType: MZTimerLabelTypeStopWatch)
            timer?.delegate = self
            isInterval = false
            IntervalcircleSlider.title = "Time cap"
            IntervalcircleSlider.divisa = "Min"
            intervalsLabel.isHidden = true
            IntervalcircleSlider.isHidden = false
            if (self.view.subviews.contains(roundsCircleSlider)){
                roundsCircleSlider.removeFromSuperview()
            }
            if (self.view.subviews.contains(onCircleSlider)){
                onCircleSlider.removeFromSuperview()
            }
            if (self.view.subviews.contains(offCircleSlider)){
                offCircleSlider.removeFromSuperview()
            }
            
        case "timer":
            print("Timer Selected")
            let totalTime = intervals * 60
            timer = MZTimerLabel(label: timeLabel, andTimerType: MZTimerLabelTypeTimer)
            timer?.delegate = self
            timer?.setCountDownTime(TimeInterval(totalTime))
            isInterval = false
            IntervalcircleSlider.title = "Time cap"
            IntervalcircleSlider.divisa = "Min"
            intervalsLabel.isHidden = true
            IntervalcircleSlider.isHidden = false
            if (self.view.subviews.contains(roundsCircleSlider)){
                roundsCircleSlider.removeFromSuperview()
            }
            if (self.view.subviews.contains(onCircleSlider)){
                onCircleSlider.removeFromSuperview()
            }
            if (self.view.subviews.contains(offCircleSlider)){
                offCircleSlider.removeFromSuperview()
            }
        case "tabata":
            print("tabata Selected")
            IntervalcircleSlider.isHidden = true
            intervalsLabel.isHidden = false

            self.view.addSubview(onCircleSlider)
            self.view.addSubview(offCircleSlider)
            self.view.addSubview(roundsCircleSlider)
            
        default:
            print("default Selected")
            timer = MZTimerLabel(label: timeLabel, andTimerType: MZTimerLabelTypeStopWatch)
            timer?.delegate = self
            isInterval = false
        }
    }
    func makeUserInterface(){
        IntervalcircleSlider = CircularSlider(frame:CGRect(x: (self.view.frame.size.width/2)-125, y: 140, width: 250, height: 250))
        IntervalcircleSlider.delegate = self
        IntervalcircleSlider.maximumValue = 120
        IntervalcircleSlider.minimumValue = 1
        IntervalcircleSlider.value = 1
        IntervalcircleSlider.knobRadius = 20
        IntervalcircleSlider.radiansOffset = 0.01
        IntervalcircleSlider.backgroundColor = .clear
        IntervalcircleSlider.pgHighlightedColor = UIColor(red:0.83, green:0.00, blue:0.00, alpha:1.00)
        IntervalcircleSlider.pgNormalColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.00)
        IntervalcircleSlider.title = "Time"
        IntervalcircleSlider.divisa = "Min"
        
        timeLabel = UILabel(frame: CGRect(x: 0, y: (self.view.frame.size.height/2)+120, width: self.view.frame.size.width, height: 60))
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont (name: "Avenir-Book", size: 50)
        timeLabel.textColor = UIColor(red:0.83, green:0.00, blue:0.00, alpha:1.00)
        
        intervalsLabel = UILabel(frame: CGRect(x: 0, y: (self.view.frame.size.height/2)+90, width: self.view.frame.size.width, height: 40))
        intervalsLabel.textAlignment = .center
        intervalsLabel.font = UIFont (name: "Avenir-Book", size: 21)
        intervalsLabel.textColor = UIColor(red:0.83, green:0.00, blue:0.00, alpha:1.00)

        self.navigationController?.progressTintColor = UIColor(red:0.83, green:0.00, blue:0.00, alpha:1.00)
        
        clockLabel = UILabel(frame: CGRect(x: 0, y: 60, width: self.view.frame.size.width, height: 40))
        clockLabel.textAlignment = .center
        clockLabel.font = UIFont (name: "Avenir-Book", size: 21)
        clockLabel.textColor = UIColor(red:0.83, green:0.00, blue:0.00, alpha:1.00)
        
        
        roundsCircleSlider = CircularSlider(frame:CGRect(x: (self.view.frame.size.width/2)-94, y: 100, width: 180, height: 180))
        roundsCircleSlider.delegate = self
        roundsCircleSlider.maximumValue = 60
        roundsCircleSlider.minimumValue = 1
        roundsCircleSlider.value = 1
        roundsCircleSlider.knobRadius = 20
        roundsCircleSlider.radiansOffset = 0.01
        roundsCircleSlider.backgroundColor = .clear
        roundsCircleSlider.pgHighlightedColor = UIColor(red:0.83, green:0.00, blue:0.00, alpha:1.00)
        roundsCircleSlider.pgNormalColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.00)
        roundsCircleSlider.title = "Rounds"
        roundsCircleSlider.divisa = ""
        
        onCircleSlider = CircularSlider(frame:CGRect(x: 20, y: 280, width: 180, height: 180))
        onCircleSlider.delegate = self
        onCircleSlider.maximumValue = 5
        onCircleSlider.minimumValue = 0.1
        onCircleSlider.value = 0.1
        
        onCircleSlider.knobRadius = 20
        onCircleSlider.radiansOffset = 0.01
        onCircleSlider.backgroundColor = .clear
        onCircleSlider.pgHighlightedColor = UIColor(red:0.83, green:0.00, blue:0.00, alpha:1.00)
        onCircleSlider.pgNormalColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.00)
        onCircleSlider.title = "ON"
        onCircleSlider.divisa = "Min"
        ontimer = MZTimerLabel(label: timeLabel, andTimerType: MZTimerLabelTypeTimer)
        ontimer?.delegate = self
        ontimer.tag = 1
        //            timer?.setCountDownTime(TimeInterval(totalTime))
        
        offCircleSlider = CircularSlider(frame:CGRect(x: (self.view.frame.size.width)-200, y: 280, width: 180, height: 180))
        offCircleSlider.delegate = self
        offCircleSlider.maximumValue = 5
        offCircleSlider.minimumValue = 0.1
        offCircleSlider.value = 0.1
        offCircleSlider.knobRadius = 20
        offCircleSlider.radiansOffset = 0.01
        offCircleSlider.backgroundColor = .clear
        offCircleSlider.pgHighlightedColor = UIColor(red:0.83, green:0.00, blue:0.00, alpha:1.00)
        offCircleSlider.pgNormalColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.00)
        offCircleSlider.title = "OFF"
        offCircleSlider.divisa = "Min"
        offtimer = MZTimerLabel(label: timeLabel, andTimerType: MZTimerLabelTypeTimer)
        offtimer?.delegate = self
        offtimer.tag = 2
        //            offtimer?.setCountDownTime(TimeInterval(totalTime))
        
        
        self.view.addSubview(timeLabel)
        self.view.addSubview(intervalsLabel)
        self.view.addSubview(self.IntervalcircleSlider)
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
    
    func startONTimer(){
        let systemSoundID: SystemSoundID = 1304
        AudioServicesPlaySystemSound (systemSoundID)
        ontimer?.start()
        timeLabel.textColor = UIColor(red:0.83, green:0.00, blue:0.00, alpha:1.00)
        
//        intervals -= 1
    }
    func startOFFTimer(){
        let systemSoundID: SystemSoundID = 1304
        AudioServicesPlaySystemSound (systemSoundID)
        offtimer?.start()
        timeLabel.textColor = UIColor(red:0.00, green:0.92, blue:0.78, alpha:1.00)
       
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
            if (timerLabel.tag == 1){
                ontimer.pause()
                ontimer.reset()
            startOFFTimer()
            return
            }
            if (timerLabel.tag == 2){
                offtimer.pause()
                offtimer.reset()
            startONTimer()
            intervals -= 1
                return
            }
            startInterval()
        }
    }
}
func round(_ value: Double, toNearest: Double) -> Double {
    return round(value / toNearest) * toNearest
}

extension ViewController: CircularSliderDelegate {
    func circularSlider(_ circularSlider: CircularSlider, valueForValue value: Float) -> Float {
        if (circularSlider.title == "ON"){
            onInterval = round(Double(value), toNearest:0.1)
            let onTime = onInterval * 60
            ontimer?.setCountDownTime(TimeInterval(onTime))
            return Float(onInterval)
        }
        
        if (circularSlider.title == "OFF"){
            offInterval = round(Double(value), toNearest:0.1)
            let offTime = offInterval * 60
            offtimer?.setCountDownTime(TimeInterval(offTime))
            return Float(offInterval)
        }
        
        if ((userIntent) != nil){
            let minute = userIntent.goalValue!/60
            intervals = Int(minute)
            intervalsLabel.text = "Intervals = \(intervals)"
            return Float(intervals)
        }else{
            let selectedMode = modes[selectedIndex]
            intervals = Int(floorf(value))
            intervalsLabel.text = "Intervals = \(intervals)"
            if (selectedMode == "timer"){
            let totalTime = intervals * 60
            timer?.setCountDownTime(TimeInterval(totalTime))
            }

            return floorf(value)
        }
        
    }
}
