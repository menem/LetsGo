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
import Intents
import HealthKit

class HomeViewController: UIViewController {
    func pushActivities() {
        let routinesViewController = TimerViewController()
        self.navigationController?.pushViewController(routinesViewController, animated: true)
    }
    
    @IBOutlet var heightLabel: UILabel!
    var intervals = 0
    var timer: MZTimerLabel!
    var intervalsLabel: UILabel!
    var timeLabel: UILabel!
    var userIntent: INStartWorkoutIntent!
    var clockLabel: UILabel!
    var clockTimer = Timer()
    let modes = ["timer", "stopwatch", "tabata"]
    var selectedIndex = 1
    var titleView: UILabel!
    var isInterval: Bool!
    var onInterval = 0.0
    var offInterval = 0.0
    var ontimer: MZTimerLabel!
    var offtimer: MZTimerLabel!
    var countDownTimer: MZTimerLabel!
    var istimerCounting: Bool!
    let healthManager:HealthKitManager = HealthKitManager()
    var height: HKQuantitySample?
    
    func endTimer() {
        timer.pause()
        timer.reset()
        ontimer.pause()
        ontimer.reset()
        offtimer.pause()
        offtimer.reset()
        countDownTimer.pause()
        countDownTimer.reset()
        istimerCounting = false
        timeLabel.textColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        self.navigationController?.progress = 0
        self.navigationController?.progressTintColor = .clear
    }

    func toggleTimer() {
        if (istimerCounting){
            timer.pause()
            countDownTimer.pause()
            ontimer.pause()
            offtimer.pause()
            istimerCounting = false
            timeLabel.textColor = #colorLiteral(red: 0.5015509129, green: 0.5780293345, blue: 0.8545677066, alpha: 1)
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            
        }else{
            countDownTimer?.start()
            istimerCounting = true
            timeLabel.textColor = #colorLiteral(red: 0.9765378833, green: 0.8906318545, blue: 0.4612582326, alpha: 1)
            perform(#selector(startInterval), with: nil, afterDelay: 10)
        }
    }
    func getHealthKitPermission() {
        healthManager.authorizeHealthKit { (authorized,  error) -> Void in
            if authorized {

                self.setHeight()
            } else {
                if error != nil {
                }
                print("Permission denied.")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getHealthKitPermission()
        
        istimerCounting = false
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(switchMode))
        
        let tapStartPauseGesture = UITapGestureRecognizer(target: self, action: #selector(toggleTimer))
        self.view.addGestureRecognizer(tapStartPauseGesture)
        
        let longStopGesture = UILongPressGestureRecognizer(target: self, action: #selector(endTimer))
        self.view.addGestureRecognizer(longStopGesture)
        
        let swipetoChangeMode = UISwipeGestureRecognizer(target: self, action: #selector(switchModeBack))
        swipetoChangeMode.direction = .left
        self.view.addGestureRecognizer(swipetoChangeMode)
        
        let swipeRightChangeMode = UISwipeGestureRecognizer(target: self, action: #selector(switchMode))
        swipetoChangeMode.direction = .right
        self.view.addGestureRecognizer(swipeRightChangeMode)
        
        
        titleView = UILabel()
        let selectedMode = modes[selectedIndex]
        titleView.text = String(selectedMode)
        titleView.font = UIFont(name: "Betm-Regular3", size: 25)
        let width = titleView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).width
        titleView.frame = CGRect(origin:CGPoint.zero, size:CGSize(width: width, height: 40))
        titleView.isUserInteractionEnabled = true
        titleView.textColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        titleView.addGestureRecognizer(tapGesture)
        
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "icn_activities"), style: .plain, target: self, action: #selector(pushActivities))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.navigationItem.titleView = titleView
        self.navigationController!.navigationBar.isTranslucent = false
        
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
        configureMode(selectedIndex: selectedIndex)
        intervalsLabel.text = "Rounds: \(intervals)"

         updateConstraints()
        
    }
    
    func configuretimer() {
        countDownTimer = MZTimerLabel(label: timeLabel, andTimerType: MZTimerLabelTypeTimer)
        countDownTimer?.setCountDownTime(10)
        ontimer?.delegate = self
        
        ontimer = MZTimerLabel(label: timeLabel, andTimerType: MZTimerLabelTypeTimer)
        ontimer?.resetTimerAfterFinish = true
        ontimer?.delegate = self
        
        offtimer = MZTimerLabel(label: timeLabel, andTimerType: MZTimerLabelTypeTimer)
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
    func setHeight() {
        let heightSample = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)
        self.healthManager.getHeight(sampleType: heightSample!, completion: { (userHeight, error) -> Void in
            
            if( error != nil ) {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            var heightString = ""
            self.height = userHeight as? HKQuantitySample
            if let meters = self.height?.quantity.doubleValue(for: HKUnit.meter()) {
                let formatHeight = LengthFormatter()
                formatHeight.isForPersonHeightUse = true
                heightString = formatHeight.string(fromMeters: meters)
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                self.heightLabel.text = heightString
            })
        })
        
    }
    
    func switchMode() {
        if (selectedIndex >= 2){
            selectedIndex = 0
            configureMode(selectedIndex: selectedIndex)
            return
        }
        selectedIndex += 1
        configureMode(selectedIndex: selectedIndex)
    }
    
    
    func switchModeBack() {
        if (selectedIndex < 1){
            selectedIndex = 2
            configureMode(selectedIndex: selectedIndex)
            return
        }
        selectedIndex -= 1
        configureMode(selectedIndex: selectedIndex)
    }
    
    func startInterval(){
        let selectedMode = modes[selectedIndex]
        if (selectedMode == "tabata"){
            startONTimer()
            return
        }
        timeLabel.textColor = #colorLiteral(red: 0, green: 0.7402182221, blue: 0.7307808995, alpha: 1)
         self.navigationController?.progressTintColor = #colorLiteral(red: 0, green: 0.7402182221, blue: 0.7307808995, alpha: 1)
        timer?.start()
    }

    func configureMode(selectedIndex: Int) {
        endTimer()
        
        let previousWidth = titleView.frame.size.width
        let selectedMode = modes[selectedIndex]
        titleView.text = String(selectedMode)
        let width = titleView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).width
        let widthdifference = width - previousWidth
        let titleOriginX = Int(titleView.frame.origin.x) - Int(widthdifference/2)
        titleView.frame = CGRect(x: titleOriginX, y: Int(titleView.frame.origin.y), width: Int(width)+1, height: 40)
        
        switch selectedMode {
        case "stopwatch":
            print("Stop Watch Selected")
            timer = MZTimerLabel(label: timeLabel, andTimerType: MZTimerLabelTypeStopWatch)
            timer?.delegate = self
            isInterval = false
            intervalsLabel.isHidden = true
        case "timer":
            print("Timer Selected")
            let totalTime = intervals * 60
            timer = MZTimerLabel(label: timeLabel, andTimerType: MZTimerLabelTypeTimer)
            timer?.delegate = self
            timer?.setCountDownTime(TimeInterval(totalTime))
            isInterval = false
            intervalsLabel.isHidden = true

        case "tabata":
            print("tabata Selected")
            intervalsLabel.isHidden = false
            let panelHeight = (self.view.frame.size.height)-45
            clockLabel.frame = CGRect(x: 0, y: panelHeight, width: self.view.frame.size.width, height: 40)
        default:
            print("default Selected")
            timer = MZTimerLabel(label: timeLabel, andTimerType: MZTimerLabelTypeStopWatch)
            timer?.delegate = self
            isInterval = false
        }
    }
    func makeUserInterface(){
       
        timeLabel = UILabel(frame: CGRect(x:0, y: (self.view.frame.size.height/2)-60, width: self.view.frame.size.width, height: 120))
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont (name: "Betm-Regular3", size: 60)
        timeLabel.textColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        
        intervalsLabel = UILabel(frame: CGRect(x: 0, y: 40, width: self.view.frame.size.width, height: 80))
        intervalsLabel.textAlignment = .center
        intervalsLabel.font = UIFont (name: "Betm-Regular3", size: 60)
        intervalsLabel.textColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)

        self.navigationController?.progressTintColor = #colorLiteral(red: 0, green: 0.7402182221, blue: 0.7307808995, alpha: 1)
        let panelHeight = (self.view.frame.size.height/2)-80
        clockLabel = UILabel(frame: CGRect(x: 0, y: panelHeight, width: self.view.frame.size.width, height: 40))
        clockLabel.textAlignment = .center
        clockLabel.font = UIFont (name: "Betm-Regular3", size: 21)
        clockLabel.textColor = #colorLiteral(red: 0.9373082519, green: 0.9373301864, blue: 0.9373183846, alpha: 1)

        ontimer = MZTimerLabel(label: timeLabel, andTimerType: MZTimerLabelTypeTimer)
        ontimer?.delegate = self
        ontimer.tag = 1
 
        offtimer = MZTimerLabel(label: timeLabel, andTimerType: MZTimerLabelTypeTimer)
        offtimer?.delegate = self
        offtimer.tag = 2
        
        self.view.addSubview(timeLabel)
        self.view.addSubview(intervalsLabel)
        
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
//        playSound()
        offtimer.pause()
        offtimer.reset()
        ontimer?.start()
        offtimer.isEnabled = false
        countDownTimer.pause()
        countDownTimer.reset()
        timeLabel.textColor = #colorLiteral(red: 0, green: 0.7402182221, blue: 0.7307808995, alpha: 1)
         self.navigationController?.progressTintColor = #colorLiteral(red: 0, green: 0.7402182221, blue: 0.7307808995, alpha: 1)
    }
    func startOFFTimer(){
//        playSound()
        ontimer.pause()
        ontimer.reset()
        ontimer.isEnabled = false
        offtimer?.start()
        timeLabel.textColor = #colorLiteral(red: 0.5015509129, green: 0.5780293345, blue: 0.8545677066, alpha: 1)
        self.navigationController?.progressTintColor = #colorLiteral(red: 0.5015509129, green: 0.5780293345, blue: 0.8545677066, alpha: 1)
       
    }
    
     func updateConstraints() {
        super.view.updateConstraints()
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
        
    }
    
}
extension HomeViewController: MZTimerLabelDelegate {
    func timerLabel(_ timerLabel: MZTimerLabel!, countingTo time: TimeInterval, timertype timerType: MZTimerLabelType){
        let progress = time/timerLabel.getCountDownTime()
        self.navigationController?.progress = Float(progress)
        intervalsLabel.text = "Rounds:\(intervals)"
        istimerCounting = true
        
    }
    
    func timerLabel(_ timerLabel: MZTimerLabel!, finshedCountDownTimerWithTime countTime: TimeInterval){
         healthManager.saveDistance(distanceRecorded: 0.1, date: NSDate())
        istimerCounting = false
        if (intervals >= 1){
            if (!offtimer.isEnabled){
            offtimer.isEnabled = true
                if(offtimer.getCountDownTime() <= 0){
                offtimer.isEnabled = false
                intervals -= 1
                    if (intervals == 0){
                        endTimer()
                        return
                    }
                    startONTimer()
                return
                }
                startOFFTimer()
                
            return
            }
            if (!ontimer.isEnabled){
                offtimer.isEnabled = true
                intervals -= 1
                if (intervals == 0){
                endTimer()
                    return
                }
            startONTimer()

                return
            }
        }
        endTimer()
        
    }
}
func round(_ value: Double, toNearest: Double) -> Double {
    return round(value / toNearest) * toNearest
}
