//
//  TimerViewController.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/10/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//
import UIKit
import MZTimerLabel
import CNPPopupController
import LETimeIntervalPicker

let CounterTableViewCellIdentifier = "CounterTableViewCellIdentifier"
let TimerSettingTableViewCellIdentifier = "TimerSettingTableViewCellIdentifier"

class TimerViewController: UITableViewController {
    
    var timer: LGTimer!
    var timeContentView: LGTimerContentView!
    var popupController: CNPPopupController!
    var durationSelector: LGDurationSelection!
    var timerSetupButton: UIButton!
    var timeSelector: LGTimePickerView!
       var totalTimeCounted: TimeInterval!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.register(TitleBackgroundTableViewCell.self, forCellReuseIdentifier: BannerTableViewCellIdentifier)
        self.title = "Timer"
        tableView.isScrollEnabled = false
        
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "icn_activities"), style: .plain, target: self, action: #selector(pushActivities))
        self.navigationItem.rightBarButtonItem = rightBarButton
        

        
        configureSettings()
        
    }
    
    
    func saveRecord()  {
        let manager = LGRecordsManager()
        manager.saveRecord(title: "Timer", timer: totalTimeCounted)
    }
    
    func startRecording(){
        totalTimeCounted = 0
    }
    
    func pushActivities(){
        let activitiesViewController = ActivitiesViewController()
        self.navigationController?.pushViewController(activitiesViewController, animated: true)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        } else {
            return 2
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 40
        } else {
            if(indexPath.row == 0){
                return self.view.frame.size.height * 0.7
            }else{
                return self.view.frame.size.height * 0.1
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func configureSettings() {

        
        timeSelector = LGTimePickerView(frame: CGRect(x: 0, y: 0, width: 300, height: 140))
        timeSelector.titlelabel.text = "Select Timer duration:"
        timeSelector.datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
        let closeButton = LGDoneButton(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
        closeButton.doneButton.addTarget(self, action: #selector(dismissPopUp), for: .touchUpInside)
        
        popupController = CNPPopupController(contents: [timeSelector, closeButton])
        popupController.theme.popupStyle = .centered
        popupController.theme.cornerRadius = 14.0
        popupController.theme.backgroundColor = #colorLiteral(red: 0.921908319, green: 0.9026622176, blue: 0.9022395015, alpha: 1)
        popupController.theme.shouldDismissOnBackgroundTouch = true
        
        popupController.delegate = self
        
    }
    func openSettings(){
        popupController.present(animated: true)
        
    }
    
    func datePickerValueChanged(sender: LETimeIntervalPicker) {
         self.timeContentView.timer.setCountDownTime(sender.timeInterval)
//        print("\(sender.timeInterval)")
    }
    
    func dismissPopUp() {
//        durationSelector.adjustMinutes()
//        durationSelector.adjustSeconds()
//        
//        let minuteReading = Double(durationSelector.minutesLabel.text! ) ?? 0
//        let minutesInSeconds = minuteReading * 60
//        let totalSeconds = minutesInSeconds + Double(durationSelector.secondsLabel.text!)!
//        self.timeContentView.timer.setCountDownTime(totalSeconds)
        self.popupController?.dismiss(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: BannerTableViewCellIdentifier, for: indexPath) as! TitleBackgroundTableViewCell
            cell.backgroundImageView.image = UIImage(named: "icn_sponsor")
            return cell
        } else {
            switch indexPath.row {
            case 1:
                self.tableView.register(TimerSettingTableViewCell.self, forCellReuseIdentifier: TimerSettingTableViewCellIdentifier)
                let cell = tableView.dequeueReusableCell(withIdentifier: TimerSettingTableViewCellIdentifier, for: indexPath) as! TimerSettingTableViewCell
                cell.counterSetupButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
                cell.counterSetupButton.tintColor = #colorLiteral(red: 0.921908319, green: 0.9026622176, blue: 0.9022395015, alpha: 1)
                self.timerSetupButton = cell.counterSetupButton

                return cell
            default:
                self.tableView.register(CounterTableViewCell.self, forCellReuseIdentifier: CounterTableViewCellIdentifier)
                let cell = tableView.dequeueReusableCell(withIdentifier: CounterTableViewCellIdentifier, for: indexPath) as! CounterTableViewCell
                cell.timerContentView.timer.setCountDownTime(60)
                cell.timerContentView.timer.delegate = self
                cell.timerContentView.timerControls.stopButton.addTarget(self, action: #selector(saveRecord), for: .touchUpInside)
                cell.timerContentView.timerControls.playButton.addTarget(self, action: #selector(startRecording), for: .touchUpInside)
                self.timeContentView = cell.timerContentView
                let settingTapGesture = UITapGestureRecognizer(target: self, action: #selector(openSettings))
                self.timeContentView.addGestureRecognizer(settingTapGesture)
                return cell
            }
            
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension TimerViewController: MZTimerLabelDelegate {
    func timerLabel(_ timerLabel: MZTimerLabel!, countingTo time: TimeInterval, timertype timerType: MZTimerLabelType){
        self.timerSetupButton.isHidden = true
        
        if self.timeContentView.timer.getTimeCounted() > 0 {
            totalTimeCounted = self.timeContentView.timer.getTimeCounted()
        }
        
    }
    
    func timerLabel(_ timerLabel: MZTimerLabel!, finshedCountDownTimerWithTime countTime: TimeInterval){
        self.timeContentView.stopTimer()
         saveRecord()
        self.timerSetupButton.isHidden = false
        
    }
}


extension TimerViewController : CNPPopupControllerDelegate {
    
    func popupControllerWillDismiss(_ controller: CNPPopupController) {
        print("Popup controller will be dismissed")
        
    }
    
    func popupControllerDidPresent(_ controller: CNPPopupController) {
        print("Popup controller presented")
    }
    
}
