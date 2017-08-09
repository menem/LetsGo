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
//import EFCircularSlider
import HealthKit

class HomeViewController: UIViewController {
    func pushActivities() {
        let routinesViewController = ActivitiesViewController()
        self.navigationController?.pushViewController(routinesViewController, animated: true)
    }
    
    @IBOutlet var heightLabel: UILabel!
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
//    var testSlider: EFCircularSlider!
    var panelTitleLabel: UILabel!
//    var player: AVAudioPlayer?
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
        timeLabel.textColor = #colorLiteral(red: 0.9373082519, green: 0.9373301864, blue: 0.9373183846, alpha: 1)
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
//            perform(#selector(playSound), with: nil, afterDelay: 8)
//            perform(#selector(playSound), with: nil, afterDelay: 9)
            
            
            timeLabel.textColor = #colorLiteral(red: 0.9765378833, green: 0.8906318545, blue: 0.4612582326, alpha: 1)
            perform(#selector(startInterval), with: nil, afterDelay: 10)
        }
    }
    func getHealthKitPermission() {
        
        // Seek authorization in HealthKitManager.swift.
        healthManager.authorizeHealthKit { (authorized,  error) -> Void in
            if authorized {
                
                // Get and set the user's height.
                self.setHeight()
            } else {
                if error != nil {
//                    print(error)
                }
                print("Permission denied.")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getHealthKitPermission()
        
       
        
        istimerCounting = false
        panelTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        panelTitleLabel.textColor = #colorLiteral(red: 0.9373082519, green: 0.9373301864, blue: 0.9373183846, alpha: 1)
        panelTitleLabel.font = UIFont(name: "AvenirNext-UltraLight", size: 25)
        panelTitleLabel.textAlignment = .center
        panelTitleLabel.text = "Pull this up"
        
        
        panelBottomView = UIView(frame: CGRect(x: 0, y: self.view.frame.height/2, width: self.view.frame.width, height: 40))
        panelBottomView.backgroundColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        panelBottomView.layer.cornerRadius = 15.0
        self.view.addSubview(panelBottomView)
        panelBottomView.addSubview(panelTitleLabel)
        
        bottomController = CTBottomSlideController(parent: self.view, bottomView: panelBottomView,
                                                   tabController: nil,
                                                   navController: self.navigationController, visibleHeight: 40)
        bottomController?.setAnchorPoint(anchor: 0.5)
        bottomController?.delegate = self
        
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
        titleView.font = UIFont(name: "Avenir-Heavy", size: 25)
        let width = titleView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).width
        titleView.frame = CGRect(origin:CGPoint.zero, size:CGSize(width: width, height: 40))
        titleView.isUserInteractionEnabled = true
        titleView.textColor = #colorLiteral(red: 0.9373082519, green: 0.9373301864, blue: 0.9373183846, alpha: 1)
        titleView.addGestureRecognizer(tapGesture)
        
//        let leftBarButton = UIBarButtonItem(image: UIImage(named: "icn_left"), style: .plain, target: self, action: #selector(switchModeBack))
//        self.navigationItem.leftBarButtonItem = leftBarButton
        
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "icn_Nav_Activities"), style: .plain, target: self, action: #selector(pushActivities))
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
        self.view.bringSubview(toFront: panelBottomView)
        
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
        // Create the HKSample for Height.
        let heightSample = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)
        
        // Call HealthKitManager's getSample() method to get the user's height.
        self.healthManager.getHeight(sampleType: heightSample!, completion: { (userHeight, error) -> Void in
            
            if( error != nil ) {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            var heightString = ""
            
            self.height = userHeight as? HKQuantitySample
            
            // The height is formatted to the user's locale.
            if let meters = self.height?.quantity.doubleValue(for: HKUnit.meter()) {
                let formatHeight = LengthFormatter()
                formatHeight.isForPersonHeightUse = true
                heightString = formatHeight.string(fromMeters: meters)
            }
            
            // Set the label to reflect the user's height.
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
//        playSound()
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
            IntervalcircleSlider.title = "Time cap"
            IntervalcircleSlider.divisa = "Min"
            intervalsLabel.isHidden = true
            IntervalcircleSlider.isHidden = false
             bottomController?.setAnchorPoint(anchor: 0.5)
            let panelHeight = (self.view.frame.size.height/2)-80
            clockLabel.frame = CGRect(x: 0, y: panelHeight, width: self.view.frame.size.width, height: 40)
            bottomController?.setAnchorPoint(anchor: 0.5)
            if (panelBottomView.subviews.contains(roundsCircleSlider)){
                roundsCircleSlider.removeFromSuperview()
            }
            if (panelBottomView.subviews.contains(onCircleSlider)){
                onCircleSlider.removeFromSuperview()
            }
            if (panelBottomView.subviews.contains(offCircleSlider)){
                offCircleSlider.removeFromSuperview()
            }
            
        case "timer":
            print("Timer Selected")
            let totalTime = intervals * 60
            timer = MZTimerLabel(label: timeLabel, andTimerType: MZTimerLabelTypeTimer)
            timer?.delegate = self
            timer?.setCountDownTime(TimeInterval(totalTime))
            isInterval = false
            IntervalcircleSlider.title = "Count Down"
            IntervalcircleSlider.divisa = "Min"
            intervalsLabel.isHidden = true
            IntervalcircleSlider.isHidden = false
            let panelHeight = (self.view.frame.size.height/2)-80
            clockLabel.frame = CGRect(x: 0, y: panelHeight, width: self.view.frame.size.width, height: 40)
             bottomController?.setAnchorPoint(anchor: 0.5)
            if (panelBottomView.subviews.contains(roundsCircleSlider)){
                roundsCircleSlider.removeFromSuperview()
            }
            if (panelBottomView.subviews.contains(onCircleSlider)){
                onCircleSlider.removeFromSuperview()
            }
            if (panelBottomView.subviews.contains(offCircleSlider)){
                offCircleSlider.removeFromSuperview()
            }
        case "tabata":
            print("tabata Selected")
            IntervalcircleSlider.isHidden = true
            intervalsLabel.isHidden = false
            let panelHeight = (self.view.frame.size.height)-45
            clockLabel.frame = CGRect(x: 0, y: panelHeight, width: self.view.frame.size.width, height: 40)
             bottomController?.setAnchorPoint(anchor: 1.0)
            panelBottomView.addSubview(onCircleSlider)
            panelBottomView.addSubview(offCircleSlider)
            panelBottomView.addSubview(roundsCircleSlider)
            
        default:
            print("default Selected")
            timer = MZTimerLabel(label: timeLabel, andTimerType: MZTimerLabelTypeStopWatch)
            timer?.delegate = self
            isInterval = false
        }
    }
    func makeUserInterface(){
        IntervalcircleSlider = CircularSlider(frame:CGRect(x: (self.view.frame.size.width/2)-100, y: 50, width: 200, height: 200))
        IntervalcircleSlider.delegate = self
        IntervalcircleSlider.maximumValue = 120
        IntervalcircleSlider.minimumValue = 1
        IntervalcircleSlider.value = 1
        IntervalcircleSlider.knobRadius = 20
        IntervalcircleSlider.bgColor = #colorLiteral(red: 0.9373082519, green: 0.9373301864, blue: 0.9373183846, alpha: 1)
        IntervalcircleSlider.radiansOffset = 0.01
        IntervalcircleSlider.backgroundColor = .clear
        IntervalcircleSlider.pgHighlightedColor = #colorLiteral(red: 0.9765378833, green: 0.8906318545, blue: 0.4612582326, alpha: 1)
        IntervalcircleSlider.highlighted = true
        IntervalcircleSlider.pgNormalColor = #colorLiteral(red: 0.9373082519, green: 0.9373301864, blue: 0.9373183846, alpha: 1)
        IntervalcircleSlider.title = "Time"
        IntervalcircleSlider.divisa = "Min"
        IntervalcircleSlider.tintColor = #colorLiteral(red: 0.9765378833, green: 0.8906318545, blue: 0.4612582326, alpha: 1)
        IntervalcircleSlider.lineWidth = 10
       
        timeLabel = UILabel(frame: CGRect(x:0, y: (self.view.frame.size.height/2)-60, width: self.view.frame.size.width, height: 120))
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont (name: "Avenir-Heavy", size: 80)
        timeLabel.textColor = #colorLiteral(red: 0.9373082519, green: 0.9373301864, blue: 0.9373183846, alpha: 1)
        
        intervalsLabel = UILabel(frame: CGRect(x: 0, y: 40, width: self.view.frame.size.width, height: 80))
        intervalsLabel.textAlignment = .center
        intervalsLabel.font = UIFont (name: "Avenir-Heavy", size: 60)
        intervalsLabel.textColor = #colorLiteral(red: 0.9373082519, green: 0.9373301864, blue: 0.9373183846, alpha: 1)

        self.navigationController?.progressTintColor = #colorLiteral(red: 0, green: 0.7402182221, blue: 0.7307808995, alpha: 1)
        let panelHeight = (self.view.frame.size.height/2)-80
        clockLabel = UILabel(frame: CGRect(x: 0, y: panelHeight, width: self.view.frame.size.width, height: 40))
        clockLabel.textAlignment = .center
        clockLabel.font = UIFont (name: "Avenir-Book", size: 21)
        clockLabel.textColor = #colorLiteral(red: 0.9373082519, green: 0.9373301864, blue: 0.9373183846, alpha: 1)
        

        
        roundsCircleSlider = CircularSlider(frame:CGRect(x: (self.view.frame.size.width/2)-94, y: 50, width: 180, height: 180))
        roundsCircleSlider.delegate = self
        roundsCircleSlider.maximumValue = 60
        roundsCircleSlider.minimumValue = 1
        roundsCircleSlider.value = 1
        roundsCircleSlider.knobRadius = 20
        roundsCircleSlider.radiansOffset = 0.01
        roundsCircleSlider.lineWidth = 10
        roundsCircleSlider.backgroundColor = .clear
        roundsCircleSlider.pgHighlightedColor = #colorLiteral(red: 0.9765378833, green: 0.8906318545, blue: 0.4612582326, alpha: 1)
        roundsCircleSlider.pgNormalColor = #colorLiteral(red: 0.9373082519, green: 0.9373301864, blue: 0.9373183846, alpha: 1)
        roundsCircleSlider.bgColor = #colorLiteral(red: 0.9373082519, green: 0.9373301864, blue: 0.9373183846, alpha: 1)
        roundsCircleSlider.tintColor = #colorLiteral(red: 0.9765378833, green: 0.8906318545, blue: 0.4612582326, alpha: 1)
        roundsCircleSlider.highlighted = true
        roundsCircleSlider.title = "Rounds"
        roundsCircleSlider.divisa = ""
        
        onCircleSlider = CircularSlider(frame:CGRect(x: (self.view.frame.size.width/2)-94, y: 240, width: 180, height: 180))
        onCircleSlider.delegate = self
        onCircleSlider.maximumValue = 5
        onCircleSlider.minimumValue = 0.1
        onCircleSlider.value = 0.1
        onCircleSlider.knobRadius = 20
        onCircleSlider.radiansOffset = 0.01
        onCircleSlider.lineWidth = 10
        onCircleSlider.backgroundColor = .clear
        onCircleSlider.pgHighlightedColor = #colorLiteral(red: 0, green: 0.7402182221, blue: 0.7307808995, alpha: 1)
        onCircleSlider.pgNormalColor = #colorLiteral(red: 0.9373082519, green: 0.9373301864, blue: 0.9373183846, alpha: 1)
        onCircleSlider.bgColor = #colorLiteral(red: 0.9373082519, green: 0.9373301864, blue: 0.9373183846, alpha: 1)
        onCircleSlider.tintColor = #colorLiteral(red: 0, green: 0.7402182221, blue: 0.7307808995, alpha: 1)
        onCircleSlider.highlighted = true
        onCircleSlider.title = "ON"
        onCircleSlider.divisa = "Min"
        
        ontimer = MZTimerLabel(label: timeLabel, andTimerType: MZTimerLabelTypeTimer)
        ontimer?.delegate = self
        ontimer.tag = 1
        //            timer?.setCountDownTime(TimeInterval(totalTime))
        
        offCircleSlider = CircularSlider(frame:CGRect(x: (self.view.frame.size.width/2)-94, y: 430, width: 180, height: 180))
        offCircleSlider.delegate = self
        offCircleSlider.maximumValue = 5
        offCircleSlider.minimumValue = 0
        offCircleSlider.value = 0.1
        offCircleSlider.knobRadius = 20
        offCircleSlider.lineWidth = 10
        offCircleSlider.backgroundColor = .clear
        offCircleSlider.pgHighlightedColor = #colorLiteral(red: 0.5015509129, green: 0.5780293345, blue: 0.8545677066, alpha: 1)
        offCircleSlider.pgNormalColor = #colorLiteral(red: 0.9373082519, green: 0.9373301864, blue: 0.9373183846, alpha: 1)
        offCircleSlider.bgColor = #colorLiteral(red: 0.9373082519, green: 0.9373301864, blue: 0.9373183846, alpha: 1)
        offCircleSlider.tintColor = #colorLiteral(red: 0.5015509129, green: 0.5780293345, blue: 0.8545677066, alpha: 1)
        offCircleSlider.highlighted = true
        offCircleSlider.title = "OFF"
        offCircleSlider.divisa = "Min"
        
        offtimer = MZTimerLabel(label: timeLabel, andTimerType: MZTimerLabelTypeTimer)
        offtimer?.delegate = self
        offtimer.tag = 2
        
        self.view.addSubview(timeLabel)
        self.view.addSubview(intervalsLabel)
        panelBottomView.addSubview(self.IntervalcircleSlider)
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
//    func playSound() {
//        guard let url = Bundle.main.url(forResource: "tone", withExtension: "wav") else { return }
//        
//        do {
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
//            try AVAudioSession.sharedInstance().setActive(true)
//            
//            player = try AVAudioPlayer(contentsOf: url)
//            guard let player = player else { return }
//            
//            player.play()
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
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
//            startInterval()
//            return
        }
        endTimer()
        
    }
}
func round(_ value: Double, toNearest: Double) -> Double {
    return round(value / toNearest) * toNearest
}

extension HomeViewController: CircularSliderDelegate {
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
            intervalsLabel.text = "Rounds: \(intervals)"
            return Float(intervals)
        }else{
            let selectedMode = modes[selectedIndex]
            intervals = Int(floorf(value))
            intervalsLabel.text = "Rounds: \(intervals)"
            if (selectedMode == "timer"){
            let totalTime = intervals * 60
            timer?.setCountDownTime(TimeInterval(totalTime))
            }

            return floorf(value)
        }
        
    }
}

extension HomeViewController: CTBottomSlideDelegate,UIGestureRecognizerDelegate {
    func didPanelCollapse(){
        panelTitleLabel.text = "Pull this up"
    }
    func didPanelExpand(){
        panelTitleLabel.text = "Pull this Down"
    }
    func didPanelAnchor(){
        panelTitleLabel.text = "Pull this Down"
    }
    func didPanelMove(panelOffset: CGFloat){
    
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if (gestureRecognizer is UIPanGestureRecognizer || gestureRecognizer is UIRotationGestureRecognizer) {
            return true
        } else {
            return true
        }
    }
}
