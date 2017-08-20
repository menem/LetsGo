//
//  ActivitiesViewController.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/3/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit
import RandomColorSwift
import CNPPopupController
import Pastel

let BannerTableViewCellIdentifier = "BannerTableViewCellIdentifier"
let ActivityTableViewCellIdentifier = "ActivityTableViewCellIdentifier"

class ActivitiesViewController: UITableViewController {
    
    var activities = [LGActivity]()
    var colors = [UIColor]()
    var activityNameTextField: LGTextField!
    var activityName: String!
    var popupController: CNPPopupController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let screenFrame = self.view.frame
//        let originX = screenFrame.origin.x
//        let originY = screenFrame.origin.y - 84
//        let height = screenFrame.height + 120
//        let width = screenFrame.width
//        let pastelView = PastelView(frame: CGRect(x: originX, y: originY, width: width, height: height))
//        
//        // Custom Direction
//        pastelView.startPastelPoint = .bottomLeft
//        pastelView.endPastelPoint = .topRight
//        
//        // Custom Duration
//        pastelView.animationDuration = 3.0
//        
//        // Custom Color
//        pastelView.setColors([UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
//                              UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
//                              UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
//                              UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
//                              UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
//                              UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
//                              UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)])
//        
//        pastelView.startAnimation()
//        view.insertSubview(pastelView, at: 0)
        
       self.becomeFirstResponder()
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.register(TitleBackgroundTableViewCell.self, forCellReuseIdentifier: BannerTableViewCellIdentifier)
        self.title = "Activities"

        loadActivities()
        
        let addButtonImage = UIImage(named:"icn_add")
        let addBarButtonItem  = UIBarButtonItem(image: addButtonImage, style: .plain, target: self, action: #selector(openSettings))
        self.navigationItem.rightBarButtonItem = addBarButtonItem
        
    }

    
    // We are willing to become first responder to get shake motion
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    // Enable detection of shake motion
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            tableView.reloadData()
        }
    }
    
    func loadActivities(){
        let timeManager = LGTimerManager()
        activities = timeManager.loadActivities()
        self.tableView.reloadData()
    }
    
    func openSettings(){
        activityNameTextField = LGTextField(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        activityNameTextField.autocapitalizationType = .none
        activityNameTextField.autocorrectionType = .no
        activityNameTextField.tintColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        activityNameTextField.textAlignment = .center
        activityNameTextField.textColor = #colorLiteral(red: 0.2333382666, green: 0.5698561072, blue: 0.8839787841, alpha: 1)
//        activityNameTextField.translatesAutoresizingMaskIntoConstraints = false
        activityNameTextField.placeholder = "Enter Activity Name"
        activityNameTextField.tintColor = #colorLiteral(red: 0.8494446278, green: 0.2558809817, blue: 0.002898618812, alpha: 1)

        let closeButton = LGDoneButton(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
        closeButton.doneButton.addTarget(self, action: #selector(dismissPopUp), for: .touchUpInside)
        
        popupController = CNPPopupController(contents: [activityNameTextField,closeButton])
        popupController.theme.popupStyle = .centered
        popupController.theme.cornerRadius = 14.0
        popupController.theme.backgroundColor = #colorLiteral(red: 0.921908319, green: 0.9026622176, blue: 0.9022395015, alpha: 1)
        popupController.theme.shouldDismissOnBackgroundTouch = true
        popupController.present(animated: true)
        popupController.delegate = self
    }
    
    func dismissPopUp() {
        saveActivity()
        loadActivities()
        self.popupController?.dismiss(animated: true)
    }
    
    
    func saveActivity() {
        if ((activityNameTextField?.text?.characters.count)! > 0) {
            let manager = LGTimerManager()
            manager.saveActivity(title: (activityNameTextField?.text)!, type: "Workout")
            print(activityName)
            print(activityNameTextField?.text ?? "Workout")
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
            let activity = activities[indexPath.row]
            cell.activityTypeImageView.image = UIImage(named: "icn_timer")
            cell.titlelabel.text = activity.title.capitalized
            cell.backCardView.backgroundColor = randomColor(hue: .random, luminosity: .light)
            return cell
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {

        }else{
        let selectedActivity = activities[indexPath.row]
        let activityViewController = ActivityViewController()
            let selectedCell = self.tableView.cellForRow(at: indexPath) as! ActivityTableViewCell
            activityViewController.cellColor = selectedCell.backCardView.backgroundColor
            activityViewController.activity = selectedActivity
            self.navigationController?.pushViewController(activityViewController, animated: true)
        }
        
    }

}

extension ActivitiesViewController : CNPPopupControllerDelegate {
    
    func popupControllerWillDismiss(_ controller: CNPPopupController) {
        print("Popup controller will be dismissed")

    }
    
    func popupControllerDidPresent(_ controller: CNPPopupController) {
        print("Popup controller presented")
    }
    
}

extension ActivitiesViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case activityNameTextField:
            activityNameTextField.setBottomBarToSelectedState()
            activityNameTextField.setPlaceHolderTextColorForBeingSelected()
        default:
            return
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case activityNameTextField:
            activityNameTextField.setBottomBarToDefaultState()
            activityNameTextField.changePlaceHolderTextColorToDefault()
            activityName = textField.text
        default:
            return
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (textField.text != nil && !(textField.text?.isEmpty)!) {
            
            switch activityNameTextField {
            case activityNameTextField:
                activityName = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            default:
                return false
            }
        }
        return true
    }
}
