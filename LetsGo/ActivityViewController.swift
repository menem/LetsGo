//
//  ActivityViewController.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/3/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit
import MZTimerLabel
import KYNavigationProgress
import RandomColorSwift

let TimerTableViewCellIdentifier = "TimerTableViewCellIdentifier"

class ActivityViewController: UITableViewController {
    
    var timers = [LGTimer]()
    var activity: LGActivity!
    var timeContentView: LGTimerContentView!
    var currentlyPlaying: Int!
    var currentInterval: Int!
    var colors = [UIColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor.white
        self.tableView.separatorStyle = .none
        self.tableView.register(TitleBackgroundTableViewCell.self, forCellReuseIdentifier: BannerTableViewCellIdentifier)
        self.title = activity.title
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        let timeManager = LGTimerManager()
        timers = timeManager.loadTimers(activity: activity)
        colors = randomColors(count: timers.count, hue: .random, luminosity: .light)
        self.tableView.reloadData()
        
        let playBarButton = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(startActivity))
        self.navigationItem.rightBarButtonItem = playBarButton
        
        timeContentView = LGTimerContentView(frame: CGRect(x:0, y: (self.view.frame.size.height)-160, width: self.view.frame.size.width, height: 120))
        timeContentView.timer.setCountDownTime(calculateTotalTime())
        timeContentView.timer.delegate = self
        self.view.addSubview(timeContentView)

    }
    

    func startActivity(){
        
        currentlyPlaying = 0
        timeContentView.timer.setCountDownTime((timers.first?.duration)!)
        currentInterval = timers.first?.intervals
        self.title = timers.first?.title
        timeContentView.playSound()
        timeContentView.timer.start()
    }
    func resumeActivity(){
        let timerDuration = timers[currentlyPlaying].duration
        currentInterval = timers[currentlyPlaying].intervals
        timeContentView.timer.setCountDownTime(timerDuration)
        self.title = timers[currentlyPlaying].title
        timeContentView.playSound()
        timeContentView.timer.start()
    }
    func resumeTimer(index: Int){
        let timerDuration = timers[index].duration
        timeContentView.timer.setCountDownTime(timerDuration)
        self.title = timers[index].title
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
        if (section != 0) {
            return 1
        }
        
        return 0
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
            cell.titlelabel.textColor = colors[indexPath.row]
            cell.Durationlabel.textColor = colors[indexPath.row]
            cell.Intervalslabel.textColor = colors[indexPath.row]
            return cell
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            let newTimerViewController = NewTimerViewController()
            newTimerViewController.activity = activity
            self.navigationController?.pushViewController(newTimerViewController, animated: true)
        }
    }
}

extension ActivityViewController: MZTimerLabelDelegate {
    func timerLabel(_ timerLabel: MZTimerLabel!, countingTo time: TimeInterval, timertype timerType: MZTimerLabelType){
        let progress = time/timerLabel.getCountDownTime()
        self.navigationController?.progress = Float(progress)        
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
                return
            }
            resumeActivity()
            return
        }
        
    }
}
