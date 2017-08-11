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
    var timeContentView: LGTimerContentView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = #colorLiteral(red: 0.921908319, green: 0.9026622176, blue: 0.9022395015, alpha: 1)
        self.tableView.separatorStyle = .none
        self.tableView.register(TitleBackgroundTableViewCell.self, forCellReuseIdentifier: BannerTableViewCellIdentifier)
        self.title = "Timer"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        let playBarButton = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(startActivity))
        self.navigationItem.rightBarButtonItem = playBarButton
    
    }
    
    
    func startActivity(){
        timeContentView.playSound()
        timeContentView.timer.start()
    }
    func resumeActivity(){
        timeContentView.playSound()
        timeContentView.timer.start()
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
        let viewToFlick = LGDurationSelection(frame: CGRect(x: 0, y: 0, width: 280, height: 300))
        viewToFlick.backgroundColor = .white
    // Optional - See FlickToDismissOption for available options.
        let options: [FlickToDismissOption] = [
            .Animation(.Scale),
            .BackgroundColor(UIColor(white: 0.0, alpha: 0.8))
        ]
        let vc = FlickToDismissViewController(flickableView: viewToFlick, options: options)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
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

    }
}
