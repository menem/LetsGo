//
//  ActivityViewController.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/3/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit
import MZTimerLabel
import CNPPopupController
import AVFoundation

let TimerTableViewCellIdentifier = "TimerTableViewCellIdentifier"

class ActivityViewController: UITableViewController {
    
    var timers = [LGTimer]()
    var activity: LGActivity!
    var timeContentView: LGTimerContentView!
    var currentlyPlaying: Int!
    var currentInterval: Int!
    var timerName: String!
    var popupController: CNPPopupController!
    var timerNameTextField: LGTextField!
    var durationSelector: LGDurationSelection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = #colorLiteral(red: 0.921908319, green: 0.9026622176, blue: 0.9022395015, alpha: 1)
        self.tableView.separatorStyle = .none
        self.tableView.register(TitleBackgroundTableViewCell.self, forCellReuseIdentifier: BannerTableViewCellIdentifier)
        self.title = activity.title
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)]
        
loadTimers()
        
        let addButtonImage = UIImage(named:"icn_add")
        let addBarButtonItem  = UIBarButtonItem(image: addButtonImage, style: .plain, target: self, action: #selector(openSettings))
        self.navigationItem.rightBarButtonItem = addBarButtonItem
        

    }
    func loadTimers() {
        let timeManager = LGTimerManager()
        timers = timeManager.loadTimers(activity: activity)
        self.tableView.reloadData()
    }
    func openSettings(){
        timerNameTextField = LGTextField(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        timerNameTextField.autocapitalizationType = .none
        timerNameTextField.autocorrectionType = .no
        timerNameTextField.tintColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        timerNameTextField.textAlignment = .center
        timerNameTextField.textColor = #colorLiteral(red: 0.2333382666, green: 0.5698561072, blue: 0.8839787841, alpha: 1)
//        timerNameTextField.translatesAutoresizingMaskIntoConstraints = false
        timerNameTextField.placeholder = "Enter Timer Name"
        timerNameTextField.tintColor = #colorLiteral(red: 0.8494446278, green: 0.2558809817, blue: 0.002898618812, alpha: 1)
        
        durationSelector = LGDurationSelection(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
        durationSelector.minutesCircularSlider.maximumValue = 20
        durationSelector.minutesCircularSlider.minimumValue = 0
        
        
        let closeButton = LGDoneButton(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
        closeButton.doneButton.addTarget(self, action: #selector(dismissPopUp), for: .touchUpInside)
        
        popupController = CNPPopupController(contents: [timerNameTextField,durationSelector,closeButton])
        popupController.theme.popupStyle = .centered
        popupController.theme.cornerRadius = 14.0
        popupController.theme.backgroundColor = #colorLiteral(red: 0.921908319, green: 0.9026622176, blue: 0.9022395015, alpha: 1)
        popupController.theme.shouldDismissOnBackgroundTouch = true
        popupController.present(animated: true)
        popupController.delegate = self
    }
    
    func dismissPopUp() {
        saveTimersForActivity()
        loadTimers()
        self.popupController?.dismiss(animated: true)
    }
    
    func startActivity(){
        
        currentlyPlaying = 0
        timeContentView.timer.setCountDownTime((timers.first?.duration)!+10)
        currentInterval = timers.first?.intervals
        
        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: (timers.first?.title)!)
        utterance.rate = 0.7
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)

        let selectedIndexPath = IndexPath(row: 0, section: 1)
        self.tableView.cellForRow(at: selectedIndexPath)?.backgroundColor = #colorLiteral(red: 0.9844431281, green: 0.9844661355, blue: 0.9844536185, alpha: 1)
        timeContentView.playSound()
        timeContentView.timer.start()
    }
    func resumeActivity(){
        let timerDuration = timers[currentlyPlaying].duration
        currentInterval = timers[currentlyPlaying].intervals
        timeContentView.timer.setCountDownTime(timerDuration)
        
        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: timers[currentlyPlaying].title)
        utterance.rate = 0.7
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)
        
        let selectedIndexPath = IndexPath(row: currentlyPlaying, section: 1)
        let previousCellIndex = IndexPath(row: currentlyPlaying - 1, section: 1)
        self.tableView.cellForRow(at: previousCellIndex )?.backgroundColor = .clear
        self.tableView.cellForRow(at: selectedIndexPath)?.backgroundColor = #colorLiteral(red: 0.9844431281, green: 0.9844661355, blue: 0.9844536185, alpha: 1)
        
        timeContentView.playSound()
        timeContentView.timer.start()
    }
    func resumeTimer(index: Int){
        let timerDuration = timers[index].duration
        timeContentView.timer.setCountDownTime(timerDuration)
       
        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: timers[index].title)
        utterance.rate = 0.7
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)

        let selectedIndexPath = IndexPath(row: currentlyPlaying, section: 1)
        self.tableView.cellForRow(at: selectedIndexPath)?.backgroundColor = #colorLiteral(red: 0.9844431281, green: 0.9844661355, blue: 0.9844536185, alpha: 1)
        timeContentView.playSound()
        timeContentView.timer.start()
    }
    func calculateTotalTime() -> Double {
        var accumelatedTime = 0.0
        for timer in timers {
            
            accumelatedTime += timer.duration.multiplied(by:Double(timer.intervals))
        }
        return accumelatedTime
    }
    func saveTimersForActivity() {
        let manager = LGTimerManager()
        let intervals = 1//Int(timerIntervalTextField.text!)
      
        durationSelector.adjustMinutes()
        durationSelector.adjustSeconds()
        
        let minuteReading = Double(durationSelector.minutesLabel.text! ) ?? 0
        let minutesInSeconds = minuteReading * 60
//        let totalSeconds =
//        self.timeContentView.timer.setCountDownTime(totalSeconds)
        
        let duration = minutesInSeconds + Double(durationSelector.secondsLabel.text!)!
        let name = timerNameTextField.text ?? "Timer"
        manager.savetimers(title: name, duration: duration, intervals: intervals, activity: activity)
    }
// MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        } else {
            return self.timers.count
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 40
        } else {
            return 80
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if (section != 0) {
//            return 0
//        }
        
        return 0
    }
  override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 0
        } else {
            return 120
        }
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if (section != 0) {
            timeContentView = LGTimerContentView(frame: CGRect(x:0, y: -40, width: self.view.frame.size.width, height: 80))
            timeContentView.timer.setCountDownTime(calculateTotalTime())
            timeContentView.timer.delegate = self
            timeContentView.timerControls.playButton.addTarget(self, action:#selector(startActivity), for: .touchUpInside)
            timeContentView.backgroundColor = #colorLiteral(red: 0.921908319, green: 0.9026622176, blue: 0.9022395015, alpha: 1)
            return timeContentView
        }else{
        return nil
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: BannerTableViewCellIdentifier, for: indexPath) as! TitleBackgroundTableViewCell
            cell.backgroundImageView.image = UIImage(named: "icn_sponsor")
            return cell
        } else {
            self.tableView.register(TimerTableViewCell.self, forCellReuseIdentifier: TimerTableViewCellIdentifier)
            let cell = tableView.dequeueReusableCell(withIdentifier: TimerTableViewCellIdentifier, for: indexPath) as! TimerTableViewCell
            let timer = timers[indexPath.row]
            cell.titlelabel.text = timer.title
            cell.Durationlabel.text = String(timer.duration)
            cell.Intervalslabel.text = String(timer.intervals)
            return cell
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            startActivity()
        }
    }
}

extension ActivityViewController: MZTimerLabelDelegate {
    func timerLabel(_ timerLabel: MZTimerLabel!, countingTo time: TimeInterval, timertype timerType: MZTimerLabelType){

    }
    
    func timerLabel(_ timerLabel: MZTimerLabel!, finshedCountDownTimerWithTime countTime: TimeInterval){
         currentInterval! -= 1
        if (currentInterval > 0) {
            resumeTimer(index: currentlyPlaying)
            return
        }
        if (currentlyPlaying < timers.count){
            currentlyPlaying! += 1
            if currentlyPlaying == timers.count {
                self.timeContentView.stopTimer()
                return
            }
            resumeActivity()
            return
        }
        
    }
}

extension ActivityViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case timerNameTextField:
            timerNameTextField.setBottomBarToSelectedState()
            timerNameTextField.setPlaceHolderTextColorForBeingSelected()
        default:
            return
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case timerNameTextField:
            timerNameTextField.setBottomBarToDefaultState()
            timerNameTextField.changePlaceHolderTextColorToDefault()
            timerName = textField.text
        default:
            return
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (textField.text != nil && !(textField.text?.isEmpty)!) {
            
            switch timerNameTextField {
            case timerNameTextField:
                timerName = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            default:
                return false
            }
        }
        return true
    }
    
}


extension ActivityViewController : CNPPopupControllerDelegate {
    
    func popupControllerWillDismiss(_ controller: CNPPopupController) {
        print("Popup controller will be dismissed")

    }
    
    func popupControllerDidPresent(_ controller: CNPPopupController) {
        print("Popup controller presented")
    }
    
}
