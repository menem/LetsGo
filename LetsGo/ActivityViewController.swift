//
//  ActivityViewController.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/3/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit

let TimerTableViewCellIdentifier = "TimerTableViewCellIdentifier"

class ActivityViewController: UITableViewController {
    
    var timers = [LGTimer]()
    var activity: LGActivity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor.white
        self.tableView.separatorStyle = .none
        self.tableView.register(TitleBackgroundTableViewCell.self, forCellReuseIdentifier: BannerTableViewCellIdentifier)
        self.title = activity.title
        
         let timersKey = "\(activity.title).timers"
        let timersData = UserDefaults.standard.object(forKey: timersKey) as? NSData
        
        if let timersData = timersData {
            let timersArray = NSKeyedUnarchiver.unarchiveObject(with: timersData as Data) as? [LGTimer]
            
            if let timersArray = timersArray {
                timers = timersArray
                self.tableView.reloadData()
            }
            
        }
        
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
        //      This is the Sponsor cell
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: BannerTableViewCellIdentifier, for: indexPath) as! TitleBackgroundTableViewCell
            
            cell.backgroundImageView.image = UIImage(named: "icn_sponsor")
            
            return cell
        } else {

            self.tableView.register(TimerTableViewCell.self, forCellReuseIdentifier: TimerTableViewCellIdentifier)
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TimerTableViewCellIdentifier, for: indexPath) as! TimerTableViewCell
            let timer = timers[indexPath.row]
            cell.titlelabel.text = timer.title
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
