//
//  SettingsTableViewController.swift
//  LetsGo
//
//  Created by Menem Ragab on 9/3/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit
let MeasurementTableViewCellIdentifier = "MeasurementTableViewCellIdentifier"
let SwitchTableViewCellIdentifier = "SwitchTableViewCellIdentifier"

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Settings"

        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        
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
      
    
//        cell.backgroundImageView.image = UIImage(named: "icn_sponsor")
       
        switch indexPath.row {
        case 1:
            self.tableView.register(MeasurementTableViewCell.self, forCellReuseIdentifier: MeasurementTableViewCellIdentifier)
            let cell = tableView.dequeueReusableCell(withIdentifier: MeasurementTableViewCellIdentifier, for: indexPath) as! MeasurementTableViewCell
            cell.measurementSelector.title = "Height"
            cell.measurementSelector.value = 150
            cell.measurementSelector.unit = .float
            cell.measurementSelector.minValue = 100
            cell.measurementSelector.maxValue = 300
            cell.measurementSelector.incrementValue = 1
            return cell
        case 2:
            self.tableView.register(MeasurementTableViewCell.self, forCellReuseIdentifier: MeasurementTableViewCellIdentifier)
            let cell = tableView.dequeueReusableCell(withIdentifier: MeasurementTableViewCellIdentifier, for: indexPath) as! MeasurementTableViewCell
            cell.measurementSelector.title = "Weight"
            cell.measurementSelector.value = 150
            cell.measurementSelector.unit = .float
            cell.measurementSelector.minValue = 100
            cell.measurementSelector.maxValue = 300
            cell.measurementSelector.incrementValue = 1
            return cell
        default:
            self.tableView.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCellIdentifier)
            let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCellIdentifier, for: indexPath) as! SwitchTableViewCell
            cell.titlelabel.text = "Night Mode"
            
            return cell
        }
        
//         Configure the cell...

        
    }
 

   }
