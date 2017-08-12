////
////  TimerViewController.swift
////  LetsGo
////
////  Created by Menem Ragab on 8/10/17.
////  Copyright © 2017 Phoenix fitness. All rights reserved.
////
//
//import UIKit
//import MZTimerLabel
//import KYNavigationProgress
//import CNPPopupController
//
//let CounterTableViewCellIdentifier = "CounterTableViewCellIdentifier"
//let TimerSettingTableViewCellIdentifier = "TimerSettingTableViewCellIdentifier"
//
//class TimerViewController: UITableViewController {
//    
//    var timer: LGTimer!
//    var timeContentView: LGTimerContentView!
//    var popupController: CNPPopupController!
//    var durationSelector: LGDurationSelection!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.tableView.tableFooterView = UIView()
//        self.tableView.backgroundColor = #colorLiteral(red: 0.921908319, green: 0.9026622176, blue: 0.9022395015, alpha: 1)
//        self.tableView.separatorStyle = .none
//        self.tableView.register(TitleBackgroundTableViewCell.self, forCellReuseIdentifier: BannerTableViewCellIdentifier)
//        self.title = "Timer"
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName :#colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)]
//        
//        
//        let rightBarButton = UIBarButtonItem(image: UIImage(named: "icn_activities"), style: .plain, target: self, action: #selector(pushActivities))
//        self.navigationItem.rightBarButtonItem = rightBarButton
//    
//    }
//    
//    func pushActivities(){
//        let activitiesViewController = ActivitiesViewController()
//        self.navigationController?.pushViewController(activitiesViewController, animated: true)
//    }
//    
////    
////    func startActivity(){
////        timeContentView.playSound()
////        timeContentView.timer.start()
////    }
////    func resumeActivity(){
////        timeContentView.playSound()
////        timeContentView.timer.start()
////    }
//    
//    // MARK: - Table view data source
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//        
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if (section == 0) {
//            return 1
//        } else {
//            return 2
//        }
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if (indexPath.section == 0) {
//            return 40
//        } else {
//            return self.view.frame.size.height * 0.75
//        }
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if (section != 0) {
//            return 1
//        }
//        
//        return 0
//    }
//    
//    func openSettings(){
//        durationSelector = LGDurationSelection(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
//       
//        let closeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
//         let buttonImage = UIImage(named: "icn_close")
//        closeButton.setImage(buttonImage, for: .normal)
//        closeButton.addTarget(self, action: #selector(dismissPopUp), for: .touchUpInside)
//        
//        popupController = CNPPopupController(contents: [closeButton, durationSelector])
//        popupController.theme.popupStyle = .centered
//        popupController.theme.cornerRadius = 14.0
//        popupController.theme.backgroundColor = #colorLiteral(red: 0.921908319, green: 0.9026622176, blue: 0.9022395015, alpha: 1)
//        popupController.theme.shouldDismissOnBackgroundTouch = true
//        popupController.present(animated: true)
//        popupController.delegate = self
//    }
//    
//    func dismissPopUp() {
//        self.popupController?.dismiss(animated: true)
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if (indexPath.section == 0) {
//            let cell = tableView.dequeueReusableCell(withIdentifier: BannerTableViewCellIdentifier, for: indexPath) as! TitleBackgroundTableViewCell
//            cell.backgroundImageView.image = UIImage(named: "icn_sponsor")
//            return cell
//        } else {
//            switch indexPath.row {
//            case 1:
//                self.tableView.register(TimerSettingTableViewCell.self, forCellReuseIdentifier: TimerSettingTableViewCellIdentifier)
//                let cell = tableView.dequeueReusableCell(withIdentifier: TimerSettingTableViewCellIdentifier, for: indexPath) as! TimerSettingTableViewCell
//                cell.counterSetupButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
//                return cell
//            default:
//                self.tableView.register(CounterTableViewCell.self, forCellReuseIdentifier: CounterTableViewCellIdentifier)
//                let cell = tableView.dequeueReusableCell(withIdentifier: CounterTableViewCellIdentifier, for: indexPath) as! CounterTableViewCell
//                cell.timerContentView.timer.setCountDownTime(60)
//                cell.timerContentView.timer.delegate = self
//                self.timeContentView = cell.timerContentView
//                return cell
//            }
//            
//
//        }
//        
//    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if (indexPath.section == 0) {
////            let newActivityViewController = ActivitiesViewController()
////            self.navigationController?.pushViewController(newActivityViewController, animated: true)
//        }
//    }
//}
//
//extension TimerViewController: MZTimerLabelDelegate {
//    func timerLabel(_ timerLabel: MZTimerLabel!, countingTo time: TimeInterval, timertype timerType: MZTimerLabelType){
//        let progress = time/timerLabel.getCountDownTime()
//        self.navigationController?.progress = Float(progress)
//    }
//    
//    func timerLabel(_ timerLabel: MZTimerLabel!, finshedCountDownTimerWithTime countTime: TimeInterval){
//
//    }
//}
//
//
//extension TimerViewController : CNPPopupControllerDelegate {
//    
//    func popupControllerWillDismiss(_ controller: CNPPopupController) {
//        print("Popup controller will be dismissed")
//        let minutesInSeconds = Double(self.durationSelector.minutesLabel.text!)! * 60
//        let totalSeconds = minutesInSeconds + Double(self.durationSelector.secondsLabel.text!)!
//        self.timeContentView.timer.setCountDownTime(totalSeconds)
//    }
//    
//    func popupControllerDidPresent(_ controller: CNPPopupController) {
//        print("Popup controller presented")
//    }
//    
//}
