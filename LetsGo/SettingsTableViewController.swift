//
//  SettingsTableViewController.swift
//  LetsGo
//
//  Created by Menem Ragab on 9/3/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Settings"

        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.register(TitleBackgroundTableViewCell.self, forCellReuseIdentifier: BannerTableViewCellIdentifier)
        
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "icn_close"), style: .plain, target: self, action: #selector(dismissSettings))
        self.navigationItem.leftBarButtonItem = leftBarButton
        
    }
    
    func dismissSettings() {
    self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: BannerTableViewCellIdentifier, for: indexPath) as! TitleBackgroundTableViewCell
//        cell.backgroundImageView.image = UIImage(named: "icn_sponsor")
       
        switch indexPath.row {
        case 1:
            cell.titlelabel.text = "Height"
        case 2:
            cell.titlelabel.text = "Weight"
        default:
            cell.titlelabel.text = "Night Mode"
        }
        
//         Configure the cell...

        return cell
    }
 

   }
