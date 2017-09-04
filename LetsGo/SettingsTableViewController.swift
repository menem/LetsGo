//
//  SettingsTableViewController.swift
//  LetsGo
//
//  Created by Menem Ragab on 9/3/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit
import ODMSwipeSelector

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
       
        switch indexPath.row {
        case 1:
            self.tableView.register(MeasurementTableViewCell.self, forCellReuseIdentifier: MeasurementTableViewCellIdentifier)
            let cell = tableView.dequeueReusableCell(withIdentifier: MeasurementTableViewCellIdentifier, for: indexPath) as! MeasurementTableViewCell
            cell.measurementSelector.title = "Height (Cm)"
//            cell.measurementSelector.value = 150
            cell.measurementSelector.unit = .float
            cell.measurementSelector.minValue = 100
            cell.measurementSelector.maxValue = 300
            cell.measurementSelector.incrementValue = 1
            cell.measurementSelector.maxIncrementValue = 15
            
            if let userHeight = UserDefaults.standard.object(forKey: "userHeight") as! Double! {
                if userHeight > 1 {
                    cell.measurementSelector.value = Float(userHeight)
                }else{
                    cell.measurementSelector.value = 150
                }
                
            }else{
                cell.measurementSelector.value = 150
            }
            return cell
        case 2:
            self.tableView.register(MeasurementTableViewCell.self, forCellReuseIdentifier: MeasurementTableViewCellIdentifier)
            let cell = tableView.dequeueReusableCell(withIdentifier: MeasurementTableViewCellIdentifier, for: indexPath) as! MeasurementTableViewCell
            cell.measurementSelector.title = "Weight (Kg)"
//            cell.measurementSelector.value = 80
            cell.measurementSelector.unit = .float
            cell.measurementSelector.minValue = 20
            cell.measurementSelector.maxValue = 250
            cell.measurementSelector.incrementValue = 1
            cell.measurementSelector.maxIncrementValue = 15
            cell.measurementSelector.delegate = self 
            
            
            if let userWeight = UserDefaults.standard.object(forKey: "userWeight") as! Double! {
                if userWeight > 1 {
                    cell.measurementSelector.value = Float(userWeight)
                }else{
                    cell.measurementSelector.value = 80
                }
                
            }else{
                cell.measurementSelector.value = 80
            }
            return cell
        default:
            self.tableView.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCellIdentifier)
            let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCellIdentifier, for: indexPath) as! SwitchTableViewCell
            cell.titlelabel.text = "Night Mode"
            cell.modeSwitch.delegate = self
            
            if let isNightModeEnabled = UserDefaults.standard.object(forKey: "isNightMode") as! Bool! {
                     cell.modeSwitch.on = isNightModeEnabled
            }
            
            return cell
        }

        
    }
 

   }
extension SettingsTableViewController : ODMSwipeSelectorDelegate {

    func swipeSelector(_ swipeSelector: ODMSwipeSelector!, didChangeToValue value: Float) {
        let userDefaults = UserDefaults.standard
        
   
        if swipeSelector.title == "Height (Cm)" {
            userDefaults.set(value, forKey: "userHeight")
        }else{
            userDefaults.set(value, forKey: "userWeight")
        }
         userDefaults.synchronize()
    }
}
extension SettingsTableViewController : KNSwitcherChangeValueDelegate {
    func switcherDidChangeValue(switcher:KNSwitcher, value: Bool) {
        if value {
            let userDefaults = UserDefaults.standard
            userDefaults.set(value, forKey: "isNightMode")
            userDefaults.synchronize()
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            if value {
                
                UIView.animate(withDuration: 0.3, animations: {
                    appDelegate.pastelView.alpha = 1
                })
                
            }else{
                UIView.animate(withDuration: 0.3, animations: {
                    appDelegate.pastelView.alpha = 0

                })
            }

        }
    }
}
