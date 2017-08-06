//
//  NewTimerViewController.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/3/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit

let NewTimerTableViewCellIdentifier = "NewTimerTableViewCellIdentifier"

class NewTimerViewController: UITableViewController {
    
    var timers = [LGTimer]()
    var timerName: String!
//    var activityNameTextField: LGTextField!
    var timerNameTextField: LGTextField!
    var timerDurationTextField: LGTextField!
    var timerIntervalTextField: LGTextField!
    
    
    var activity: LGActivity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor.white
        self.tableView.separatorStyle = .none
        self.tableView.register(TitleBackgroundTableViewCell.self, forCellReuseIdentifier: BannerTableViewCellIdentifier)
        
        let saveBarButton  = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTimersForActivity))
        self.navigationItem.rightBarButtonItem = saveBarButton
        
    }
    func saveTimersForActivity() {
        let manager = LGTimerManager()
        let intervals = Int(timerIntervalTextField.text!)
        let duration = Double(timerDurationTextField.text!)
        let name = timerNameTextField.text!
        manager.savetimers(title: name, duration: duration!, intervals: intervals!, activity: activity)
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
            
            self.tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: TextFieldTableViewCellIdentifier)
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            switch indexPath.row {
            case 1:
                cell.userInputTextField.placeholder = "Enter Timers duration"
                cell.tintColor = #colorLiteral(red: 0.8494446278, green: 0.2558809817, blue: 0.002898618812, alpha: 1)
                timerDurationTextField = cell.userInputTextField
            case 2:
                cell.userInputTextField.placeholder = "Enter Timers intervals"
                cell.tintColor = #colorLiteral(red: 0.8494446278, green: 0.2558809817, blue: 0.002898618812, alpha: 1)
                timerIntervalTextField = cell.userInputTextField
            default:
                cell.userInputTextField.placeholder = "Enter Timers Name"
                cell.tintColor = #colorLiteral(red: 0.8494446278, green: 0.2558809817, blue: 0.002898618812, alpha: 1)
                timerNameTextField = cell.userInputTextField
            }

            return cell
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            
        }
    }
    
    //MARK: - UITextField Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case timerNameTextField:
            timerNameTextField.setBottomBarToSelectedState()
            timerNameTextField.setPlaceHolderTextColorForBeingSelected()
        default:
            return
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case timerNameTextField:
            timerNameTextField.setBottomBarToDefaultState()
            timerNameTextField.changePlaceHolderTextColorToDefault()
            timerName = textField.text
        default:
            return
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (textField.text != nil && !(textField.text?.isEmpty)!) {
            
            switch timerNameTextField {
            case timerNameTextField:
                timerName = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            default:
                return false
            }
        }
        return true
    }
  
}
