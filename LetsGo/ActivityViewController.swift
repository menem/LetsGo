//
//  ActivityViewController.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/3/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit

//let BannerTableViewCellIdentifier = "BannerTableViewCellIdentifier"
//let ActivityTableViewCellIdentifier = "ActivityTableViewCellIdentifier"

class ActivityViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor.white
        self.tableView.separatorStyle = .none
//        self.tableView.register(TitleBackgroundTableViewCell.self, forCellReuseIdentifier: BannerTableViewCellIdentifier)
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        } else {
            return 3
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
            
            self.tableView.register(ActivityTableViewCell.self, forCellReuseIdentifier: ActivityTableViewCellIdentifier)
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ActivityTableViewCellIdentifier, for: indexPath) as! ActivityTableViewCell
            
            
            
            switch indexPath.row
            {
            case 0:
                
                cell.titlelabel.text = "Dummy Text 1"
                cell.activityTypeImageView.image = (UIImage (named: "icn_Level_Beginner"))
            case 1:
                
                cell.titlelabel.text = "Dummy Text 2"
                cell.activityTypeImageView.image = (UIImage (named: "icn_Level_Extreme"))
            case 2:
                
                cell.titlelabel.text = "Dummy Text 3"
                cell.activityTypeImageView.image = (UIImage (named: "icn_Level_Hardcore"))
                
            default:
                break
            }
            return cell
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 1) {
            
        }
    }
    
    
}
