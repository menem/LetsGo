//
//  RecordsTableViewController.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/18/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit
import RandomColorSwift
import CNPPopupController

let RecordTableViewCellIdentifier = "RecordTableViewCellIdentifier"

class RecordsTableViewController: UITableViewController {
    var popupController: CNPPopupController!
    var records = [LGRecord]()
    var selectedRecord: LGRecord!
    var selectedRecordIndexPath: IndexPath!
    var notesTextView: UITextView!
    var recordNameTextField: LGTextField!
    var recordDates = [String]()
    var recordsInDates = [String: [LGRecord]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.register(TitleBackgroundTableViewCell.self, forCellReuseIdentifier: BannerTableViewCellIdentifier)
        self.title = "Records"
        
        loadRecords()
     
    }
    
    func loadRecords(){
        let recordsManager = LGRecordsManager()
        records = recordsManager.loadRecords()
        var setofDates = Set<String>()
        for record in records{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
            dateFormatter.locale = Locale(identifier: "en_US")
            let date = dateFormatter.date(from:record.timestamp)!
            dateFormatter.dateFormat = "yyyy/MM/dd"
            let dateString = dateFormatter.string(from:date)
            setofDates.insert(dateString)
        }
        recordDates = Array(setofDates)
        recordDates.sort { $0 > $1 }
        
        for recordDate in recordDates{
            var groupedRecords = [LGRecord]()

            for record in records{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
                dateFormatter.locale = Locale(identifier: "en_US")
                let date = dateFormatter.date(from:record.timestamp)!
                dateFormatter.dateFormat = "yyyy/MM/dd"
                let dateString = dateFormatter.string(from:date)
                
                if dateString == recordDate{
                groupedRecords.append(record)
                }
             
            }
            
           recordsInDates[recordDate] = groupedRecords
        }
        print(recordsInDates)
        
        self.tableView.reloadData()
    }
    func configureSettings(record: LGRecord) {
        
        recordNameTextField = LGTextField(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        recordNameTextField.autocapitalizationType = .none
        recordNameTextField.autocorrectionType = .no
        recordNameTextField.tintColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        recordNameTextField.textAlignment = .center
        recordNameTextField.textColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        recordNameTextField.placeholder = "Enter Record Name"
        recordNameTextField.text = record.title
        recordNameTextField.tintColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        
        notesTextView = UITextView(frame: CGRect(x: 0, y: 0, width: 300.0, height: 200.0))
        self.automaticallyAdjustsScrollViewInsets = false
        
        notesTextView.text = record.notes
        notesTextView.font = UIFont(name: "Betm-Regular3", size: 18)
        notesTextView.textColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        notesTextView.backgroundColor = .clear
        notesTextView.layer.borderColor = UIColor(red:0.15, green:0.16, blue:0.20, alpha:0.50).cgColor
        notesTextView.layer.cornerRadius = 5.0
        notesTextView.layer.borderWidth = 1.0
//        notesTextView.layer.borderColor?.alpha = 0.5
        
        let closeButton = LGDoneButton(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
        closeButton.doneButton.addTarget(self, action: #selector(dismissPopUp), for: .touchUpInside)
        
        popupController = CNPPopupController(contents: [recordNameTextField, notesTextView, closeButton])
        popupController.theme.popupStyle = .centered
        popupController.theme.cornerRadius = 14.0
        popupController.theme.backgroundColor = #colorLiteral(red: 0.921908319, green: 0.9026622176, blue: 0.9022395015, alpha: 1)
        popupController.theme.shouldDismissOnBackgroundTouch = true
        
//        popupController.delegate = self
        
    }
    func openSettings(){
        popupController.present(animated: true)
        
    }
    
    func dismissPopUp() {
        let manager = LGRecordsManager()
        selectedRecord.notes = notesTextView.text
        selectedRecord.title = self.recordNameTextField.text!
        
        records.remove(at: selectedRecordIndexPath.row)
        records.insert(selectedRecord, at: selectedRecordIndexPath.row)
        
        manager.updateRecords(newRecords: records)
        tableView.reloadData()
        
        self.popupController?.dismiss(animated: true)
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return recordDates.count
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let recordDate = recordDates[section]
        let recordsFoundinDate = recordsInDates[recordDate]
            return recordsFoundinDate!.count
//        }
    }
    
    override  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
//        if indexPath.section != 0 {
            return true
//        }else{
//            return false
//        }
        
    }
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
//        if indexPath.section != 0 {
            return true
//        }else{
//            return false
//        }
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
            let  label = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 40))
//            label.setCountDownTime(minutes: 10)
//            label.animationType = .Scale
            label.textAlignment = .center
            label.font = UIFont (name: "Betm-Regular3", size: 30)
            label.textColor = #colorLiteral(red: 0.9844431281, green: 0.9844661355, blue: 0.9844536185, alpha: 1)
        label.text = recordDates[section]
//            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
    
    }
    override   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            let manager = LGRecordsManager()
            
            records.remove(at: indexPath.row)
            manager.updateRecords(newRecords: records)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if (indexPath.section == 0) {
//            return 40
//        } else {
            return 80
//        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //      This is the Sponsor cell
//        if (indexPath.section == 0) {
//            let cell = tableView.dequeueReusableCell(withIdentifier: BannerTableViewCellIdentifier, for: indexPath) as! TitleBackgroundTableViewCell
//            
//            cell.backgroundImageView.image = UIImage(named: "icn_sponsor")
//            
//            return cell
//        } else {
        
            self.tableView.register(RecordTableViewCell.self, forCellReuseIdentifier: RecordTableViewCellIdentifier)
            
            let cell = tableView.dequeueReusableCell(withIdentifier: RecordTableViewCellIdentifier, for: indexPath) as! RecordTableViewCell
        let recordDate = recordDates[indexPath.section]
        let recordsFoundinDate = recordsInDates[recordDate]
            let record = recordsFoundinDate?[indexPath.row]
            let timeString = LGTimeHelper.sharedInstance.timefromTimeInterval(timeInterval: (record?.timeElapsed)!)
            cell.timeElapsedlabel.text = timeString
            cell.titlelabel.text = record?.title.capitalized
            let caloriesInt = Int((record?.calories.rounded(.down))!)
           
            if caloriesInt <= 0 {
                cell.calorieslabel.isHidden = true
                cell.calorieImageView.isHidden = true
            }else{
                cell.calorieslabel.isHidden = false
                cell.calorieImageView.isHidden = false
                cell.calorieslabel.text = "\(caloriesInt)"
            }
           
            cell.backCardView.backgroundColor = randomColor(hue: .random, luminosity: .light)
            return cell
//        }
        
    }
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   selectedRecordIndexPath = indexPath
    let recordDate = recordDates[indexPath.section]
    let recordsFoundinDate = recordsInDates[recordDate]
    selectedRecord = recordsFoundinDate?[indexPath.row]
//    selectedRecord = records[indexPath.row]
    configureSettings(record: selectedRecord)
    openSettings()
    }
}
