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
import CTSlidingUpPanel

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
    var countDownTimer: MZTimerLabel!
    var panelBottomView: UIView!
    var bottomController:CTBottomSlideController?
    var istimerCounting: Bool!
  
    func endTimer() {
        timer.pause()
        timer.reset()
        istimerCounting = false
        timeLabel.textColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.00)
    }

    func toggleTimer() {
        if (istimerCounting){
            timer.pause()
            istimerCounting = false
            timeLabel.textColor = UIColor(red:0.95, green:0.16, blue:0.56, alpha:1.00)
        }else{
            countDownTimer = MZTimerLabel(label: timeLabel, andTimerType: MZTimerLabelTypeTimer)
            countDownTimer?.setCountDownTime(10)
            countDownTimer?.start()
            let systemSoundID: SystemSoundID = 1304
            AudioServicesPlaySystemSound (systemSoundID)
            timeLabel.textColor = UIColor(red:0.97, green:0.87, blue:0.39, alpha:1.00)
            perform(#selector(startInterval), with: nil, afterDelay: 10)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        istimerCounting = false
        let panelTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        panelTitleLabel.textColor = #colorLiteral(red: 0.9373082519, green: 0.9373301864, blue: 0.9373183846, alpha: 1)
        panelTitleLabel.font = UIFont(name: "AvenirNext-UltraLight", size: 25)
        panelTitleLabel.textAlignment = .center
        panelTitleLabel.text = "Pull this up"
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.21, green:0.22, blue:0.27, alpha:1.00)
        
        panelBottomView = UIView(frame: CGRect(x: 0, y: self.view.frame.height/2, width: self.view.frame.width, height: 40))
        panelBottomView.backgroundColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        panelBottomView.layer.cornerRadius = 15.0
        self.view.addSubview(panelBottomView)
        panelBottomView.addSubview(panelTitleLabel)
        
        bottomController = CTBottomSlideController(parent: self.view, bottomView: panelBottomView,
                                                   tabController: nil,
                                                   navController: self.navigationController, visibleHeight: 64)
        bottomController?.setAnchorPoint(anchor: 0.5)
        bottomController?.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(switchMode))
        
        let tapStartPauseGesture = UITapGestureRecognizer(target: self, action: #selector(toggleTimer))
        self.view.addGestureRecognizer(tapStartPauseGesture)
        
        let longStopGesture = UILongPressGestureRecognizer(target: self, action: #selector(endTimer))
        self.view.addGestureRecognizer(longStopGesture)
        
        let swipetoChangeMode = UISwipeGestureRecognizer(target: self, action: #selector(switchMode))
        self.view.addGestureRecognizer(swipetoChangeMode)
        
        
        titleView = UILabel()
        let selectedMode = modes[selectedIndex]
        titleView.text = String(selectedMode)
        titleView.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        let width = titleView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).width
        titleView.frame = CGRect(origin:CGPoint.zero, size:CGSize(width: width, height: 40))
        titleView.isUserInteractionEnabled = true
        titleView.textColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.00)
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
        self.view.bringSubview(toFront: panelBottomView)
        
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
        let selectedMode = modes[selectedIndex]
        if (selectedMode == "tabata"){
            
            startONTimer()
            return
        }
        timeLabel.textColor = UIColor(red:0.00, green:0.69, blue:0.67, alpha:1.00)
        let systemSoundID: SystemSoundID = 1304
        AudioServicesPlaySystemSound (systemSoundID)
        timer?.start()
        intervals -= 1
    }
    
    func stopTimer(){
        timeLabel.textColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.00)
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
        IntervalcircleSlider = CircularSlider(frame:CGRect(x: (self.view.frame.size.width/2)-100, y: 80, width: 200, height: 200))
        IntervalcircleSlider.delegate = self
        IntervalcircleSlider.maximumValue = 120
        IntervalcircleSlider.minimumValue = 1
        IntervalcircleSlider.value = 1
        IntervalcircleSlider.knobRadius = 20
        IntervalcircleSlider.radiansOffset = 0.01
        IntervalcircleSlider.backgroundColor = .clear
        IntervalcircleSlider.pgHighlightedColor = #colorLiteral(red: 0.8975453377, green: 0.4076307416, blue: 0.1039793417, alpha: 1)
        IntervalcircleSlider.pgNormalColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        IntervalcircleSlider.title = "Time"
        IntervalcircleSlider.divisa = "Min"
        IntervalcircleSlider.isHidden = true
        IntervalcircleSlider.tintColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        
        timeLabel = UILabel(frame: CGRect(x:0, y: (self.view.frame.size.height/2)-60, width: self.view.frame.size.width, height: 120))
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont (name: "Avenir-Heavy", size: 80)
        timeLabel.textColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.00)
        
        intervalsLabel = UILabel(frame: CGRect(x: 0, y: (self.view.frame.size.height/2)+90, width: self.view.frame.size.width, height: 40))
        intervalsLabel.textAlignment = .center
        intervalsLabel.font = UIFont (name: "Avenir-Book", size: 21)
        intervalsLabel.textColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.00)

        self.navigationController?.progressTintColor = UIColor(red:0.83, green:0.00, blue:0.00, alpha:1.00)
        let panelHeight = (self.view.frame.size.height/2)-80
        clockLabel = UILabel(frame: CGRect(x: 0, y: panelHeight, width: self.view.frame.size.width, height: 40))
        clockLabel.textAlignment = .center
        clockLabel.font = UIFont (name: "Avenir-Book", size: 21)
        clockLabel.textColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.00)
        
        
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
        offCircleSlider.minimumValue = 0
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
        panelBottomView.addSubview(intervalsLabel)
        panelBottomView.addSubview(self.IntervalcircleSlider)
//        panelBottomView.addSubview(circularPickerView)
        panelBottomView.addSubview(clockLabel)
        
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
        countDownTimer.pause()
        countDownTimer.reset()
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
        istimerCounting = true
        
    }
    
    func timerLabel(_ timerLabel: MZTimerLabel!, finshedCountDownTimerWithTime countTime: TimeInterval){
        
        istimerCounting = false
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

extension ViewController: CTBottomSlideDelegate {
    func didPanelCollapse(){
    
    }
    func didPanelExpand(){
    
    }
    func didPanelAnchor(){
    
    }
    func didPanelMove(panelOffset: CGFloat){
    
    }
}
