//
//  IntervalsViewController.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/13/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit
import MZTimerLabel
import CNPPopupController

class IntervalsViewController: UITableViewController {
    
    var timers = [LGTimer]()
    var timeContentView: LGTimerContentView!
    var popupController: CNPPopupController!
        var onTimeSelector: TimePickerView!
        var offTimeSelector: TimePickerView!
//    var onDurationSelector: LGDurationSelection!
//    var offDurationSelector: LGDurationSelection!
    var scrollView: UIScrollView?
    var roundCounter: LGRoundSelector!
    var rounds: Int!
    var ontotalSeconds: Double!
    var offtotalSeconds: Double!
    var currentRound: Int!
    var isCountingOffTimer: Bool!
    var timerSetupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor =  .clear
        self.tableView.separatorStyle = .none
        self.tableView.register(TitleBackgroundTableViewCell.self, forCellReuseIdentifier: BannerTableViewCellIdentifier)
        tableView.isScrollEnabled = false
        
        self.title = "Intervals"
        
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "icn_activities"), style: .plain, target: self, action: #selector(pushActivities))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
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
    
    func openSettings(){
        
        onTimeSelector = TimePickerView(frame: CGRect(x: 0, y: 0, width: 300, height: 140))
        onTimeSelector.titlelabel.text = "Select ON Timer duration:"
        
        offTimeSelector = TimePickerView(frame: CGRect(x: 310, y: 0, width: 300, height: 140))
        offTimeSelector.titlelabel.text = "Select OFF Timer duration:"
        
        
//        onDurationSelector = LGDurationSelection(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
//        offDurationSelector = LGDurationSelection(frame: CGRect(x: 310, y: 0, width: 300, height: 400))
        
        scrollView = UIScrollView(frame: onTimeSelector.frame)
        scrollView?.delegate = self
        let bounds = onTimeSelector.bounds
        let width = bounds.size.width
        let height = bounds.size.height
        scrollView!.contentSize = CGSize(width: 2*width, height: height)
        let views = [onTimeSelector, offTimeSelector]
        
        for view in views {
            scrollView!.addSubview(view!)
        }
        
        roundCounter = LGRoundSelector(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        let closeButton = LGDoneButton(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
        closeButton.doneButton.addTarget(self, action: #selector(dismissPopUp), for: .touchUpInside)
        
        popupController = CNPPopupController(contents: [roundCounter, scrollView!, closeButton])
        popupController.theme.popupStyle = .centered
        popupController.theme.cornerRadius = 14.0
        popupController.theme.backgroundColor = #colorLiteral(red: 0.921908319, green: 0.9026622176, blue: 0.9022395015, alpha: 1)
        popupController.theme.shouldDismissOnBackgroundTouch = true
        popupController.present(animated: true)
        popupController.delegate = self
    }
    
    func dismissPopUp() {
        
        configureTimers()
        self.popupController?.dismiss(animated: true)
    }
    
    func configureTimers() {
//        onDurationSelector.adjustMinutes()
//        onDurationSelector.adjustSeconds()
        
//        let onminuteReading = Double(onDurationSelector.minutesLabel.text! ) ?? 0
//        let onminutesInSeconds = onminuteReading * 60
        ontotalSeconds =  self.onTimeSelector.datePickerView.timeInterval

//        offDurationSelector.adjustMinutes()
//        offDurationSelector.adjustSeconds()
//        
//        let offminuteReading = Double(offDurationSelector.minutesLabel.text! ) ?? 0
//        let offminutesInSeconds = offminuteReading * 60
        offtotalSeconds = self.offTimeSelector.datePickerView.timeInterval

        rounds = Int(roundCounter.roundStepper.value)
        currentRound = 0
        self.timeContentView.timer.setCountDownTime(ontotalSeconds)
        isCountingOffTimer = false
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

extension IntervalsViewController: MZTimerLabelDelegate {
    func timerLabel(_ timerLabel: MZTimerLabel!, countingTo time: TimeInterval, timertype timerType: MZTimerLabelType){
self.timerSetupButton.isHidden = true
    }
    
    func timerLabel(_ timerLabel: MZTimerLabel!, finshedCountDownTimerWithTime countTime: TimeInterval){
        
        if (currentRound < rounds){
            if (isCountingOffTimer){
                isCountingOffTimer = false
                currentRound! += 1
                if (currentRound < rounds){
                    self.timeContentView.tintColor = #colorLiteral(red: 0, green: 0.7402182221, blue: 0.7307808995, alpha: 1)
                    self.timeContentView.timer.setCountDownTime(ontotalSeconds)
                    self.timeContentView.playSound()
                    self.timeContentView.timer.start()
                    return
                }else{
                    self.timeContentView.stopTimer()
                    self.timerSetupButton.isHidden = false
                    configureTimers()
                }
                return
            }
            isCountingOffTimer = true
            self.timeContentView.tintColor = #colorLiteral(red: 0.8494446278, green: 0.2558809817, blue: 0.002898618812, alpha: 1)
            self.timeContentView.timer.setCountDownTime(offtotalSeconds)
            self.timeContentView.playSound()
            self.timeContentView.timer.start()
        }
    }
}


extension IntervalsViewController : CNPPopupControllerDelegate {
    
    func popupControllerWillDismiss(_ controller: CNPPopupController) {
        print("Popup controller will be dismissed")
    }
    
    func popupControllerDidPresent(_ controller: CNPPopupController) {
        print("Popup controller presented")
        
    }
    
}
