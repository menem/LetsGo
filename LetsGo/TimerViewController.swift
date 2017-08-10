//
//  TimerViewController.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/10/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit
import MZTimerLabel
import KYNavigationProgress

let CounterTableViewCellIdentifier = "CounterTableViewCellIdentifier"
let TimerSettingTableViewCellIdentifier = "TimerSettingTableViewCellIdentifier"

class TimerViewController: UITableViewController {
    
    var timer: LGTimer!
//    var activity: LGActivity!
    var timeContentView: LGTimerContentView!
//    var currentlyPlaying: Int!
//    var currentInterval: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = #colorLiteral(red: 0.921908319, green: 0.9026622176, blue: 0.9022395015, alpha: 1)
        self.tableView.separatorStyle = .none
        self.tableView.register(TitleBackgroundTableViewCell.self, forCellReuseIdentifier: BannerTableViewCellIdentifier)
        self.title = "Timer" // activity.title
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
//        let timeManager = LGTimerManager()
//        timers = timeManager.loadTimers(activity: activity)
//        self.tableView.reloadData()
        
        let playBarButton = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(startActivity))
        self.navigationItem.rightBarButtonItem = playBarButton
        

//        self.view.addSubview(timeContentView)
        
    }
    
    
    func startActivity(){
//        currentlyPlaying = 0
//        timeContentView.timer.setCountDownTime((timers.first?.duration)!)
//        currentInterval = timers.first?.intervals
//        self.title = timers.first?.title
        timeContentView.playSound()
        timeContentView.timer.start()
    }
    func resumeActivity(){
//        let timerDuration = timers[currentlyPlaying].duration
//        currentInterval = timers[currentlyPlaying].intervals
//        timeContentView.timer.setCountDownTime(timerDuration)
//        self.title = timers[currentlyPlaying].title
        timeContentView.playSound()
        timeContentView.timer.start()
    }
    func resumeTimer(index: Int){
//        let timerDuration = timers[index].duration
//        timeContentView.timer.setCountDownTime(timerDuration)
//        self.title = timers[index].title
        timeContentView.playSound()
        timeContentView.timer.start()
    }
    func calculateTotalTime() -> Double {
//        var accumelatedTime = 0.0
//        for timer in timers {
//            
//            accumelatedTime += timer.duration.multiplied(by:Double(timer.intervals))
//        }
        return 60//accumelatedTime
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
            return 120
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section != 0) {
            return 1
        }
        
        return 0
    }
    func openSettings(){
        let routinesViewController = ActivitiesViewController()
        self.navigationController?.pushViewController(routinesViewController, animated: true)
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
                return cell
            default:
                self.tableView.register(CounterTableViewCell.self, forCellReuseIdentifier: CounterTableViewCellIdentifier)
                let cell = tableView.dequeueReusableCell(withIdentifier: CounterTableViewCellIdentifier, for: indexPath) as! CounterTableViewCell
                cell.timerContentView.timer.setCountDownTime(60)
                cell.timerContentView.timer.delegate = self
                self.timeContentView = cell.timerContentView
                return cell
            }
            

        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {

        }
    }
}

extension TimerViewController: MZTimerLabelDelegate {
    func timerLabel(_ timerLabel: MZTimerLabel!, countingTo time: TimeInterval, timertype timerType: MZTimerLabelType){
        let progress = time/timerLabel.getCountDownTime()
        self.navigationController?.progress = Float(progress)
    }
    
    func timerLabel(_ timerLabel: MZTimerLabel!, finshedCountDownTimerWithTime countTime: TimeInterval){
//        currentInterval! -= 1
//        if (currentInterval > 0) {
//            resumeTimer(index: currentlyPlaying)
//            return
//        }
//        if (currentlyPlaying < timers.count){
//            currentlyPlaying! += 1
//            if currentlyPlaying == timers.count {
//                return
//            }
//            resumeActivity()
//            return
//        }
//        
    }
}
