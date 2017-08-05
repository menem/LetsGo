//
//  File.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/3/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit
import HGPlaceholders

let BannerTableViewCellIdentifier = "BannerTableViewCellIdentifier"
let ActivityTableViewCellIdentifier = "ActivityTableViewCellIdentifier"

class ActivitiesViewController: UITableViewController {
    
    var placeholderTableView: TableView?
    var activities = [LGActivity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor.white
        self.tableView.separatorStyle = .none
        self.tableView.register(TitleBackgroundTableViewCell.self, forCellReuseIdentifier: BannerTableViewCellIdentifier)
        
        let saveBarButton  = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveActivity))
        self.navigationController?.navigationItem.rightBarButtonItem = saveBarButton
        
        placeholderTableView = tableView as? TableView
        placeholderTableView?.placeholderDelegate = self
        placeholderTableView?.showNoResultsPlaceholder()
        self.placeholderTableView?.reloadData()
        
    }
    
    // MARK: - Table view data source
    func saveActivity() {
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        } else {
            return activities.count
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

            return cell
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            let newActivityViewController = NewActivityViewController()
            self.navigationController?.pushViewController(newActivityViewController, animated: true)
        }
    }
    
    
}

extension ActivitiesViewController: PlaceholderDelegate {
    
    func tableView(_ tableView: TableView, actionButtonTappedFor placeholder: Placeholder) {
        print(placeholder.key.value)
        placeholderTableView?.showDefault()
    }
}

class ProjectNameTableView: TableView {
    
    override func customSetup() {
        placeholdersProvider = .basic
    }
    
}
