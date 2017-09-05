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
    var selectedGlobalRow: Int!
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
      LogScreenLoad()
    }
    
    func loadRecords(){
        let recordsManager = LGRecordsManager()
        records = recordsManager.loadRecords()
        self.sortRecords()
        self.tableView.reloadData()
    }
    
    func sortRecords(){
        var orderedRecords = [LGRecord]()
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
                    orderedRecords.append(record)
                }
                
            }
            
            recordsInDates[recordDate] = groupedRecords
        }
        print(recordsInDates)
        
        records.removeAll()
        records = orderedRecords
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
        
        let closeButton = LGDoneButton(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
        closeButton.doneButton.addTarget(self, action: #selector(dismissPopUp), for: .touchUpInside)
        
        popupController = CNPPopupController(contents: [recordNameTextField, notesTextView, closeButton])
        popupController.theme.popupStyle = .centered
        popupController.theme.cornerRadius = 14.0
        popupController.theme.backgroundColor = #colorLiteral(red: 0.921908319, green: 0.9026622176, blue: 0.9022395015, alpha: 1)
        popupController.theme.shouldDismissOnBackgroundTouch = true
        
    }
    func openSettings(){
        popupController.present(animated: true)
        
    }
    
    func dismissPopUp() {
        let manager = LGRecordsManager()
        selectedRecord.notes = notesTextView.text
        selectedRecord.title = self.recordNameTextField.text!
        
        records.remove(at: selectedGlobalRow)
        records.insert(selectedRecord, at: selectedGlobalRow)

        manager.updateRecords(newRecords: records)
        self.sortRecords()
        tableView.reloadData()
        
        self.popupController?.dismiss(animated: true)
    }
    // MARK: - Table view data source
     func rowPositionForThisIndexPath(indexPath: IndexPath, insideThisTable theTable: UITableView)->Int{
        
        var i = 0
        var rowCount = 0
        
        while i < indexPath.section {
            
            rowCount += theTable.numberOfRows(inSection: i)
            
            i += 1
        }
        
        rowCount += indexPath.row
        // Because the array is sorted Desendingly (to get the fresh date first)
        // We have to reserve that row count, achieved by the next equation
//        let rightRowPlacement = (records.count - 1) - rowCount
        return rowCount
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return recordDates.count
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let recordDate = recordDates[section]
        let recordsFoundinDate = recordsInDates[recordDate]
            return recordsFoundinDate!.count
    }
    
    override  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
            return true
    }
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
            return true
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
            let  label = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 40))
            label.textAlignment = .center
            label.font = UIFont (name: "Betm-Regular3", size: 30)
            label.textColor = #colorLiteral(red: 0.9844431281, green: 0.9844661355, blue: 0.9844536185, alpha: 1)
            label.text = recordDates[section]
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
    
    }
    override   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            let manager = LGRecordsManager()
            
            records.remove(at: self.rowPositionForThisIndexPath(indexPath: indexPath, insideThisTable: tableView))
            manager.updateRecords(newRecords: records)
            self.sortRecords()
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            self.tableView.register(RecordTableViewCell.self, forCellReuseIdentifier: RecordTableViewCellIdentifier)
            
            let cell = tableView.dequeueReusableCell(withIdentifier: RecordTableViewCellIdentifier, for: indexPath) as! RecordTableViewCell
            let recordsSetForDate = recordsInDates[recordDates[indexPath.section]]
            let record = recordsSetForDate?[indexPath.row]
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
   
    }
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
    selectedGlobalRow = self.rowPositionForThisIndexPath(indexPath: indexPath, insideThisTable: tableView)
    print ("Selected row\(selectedGlobalRow)")
    selectedRecord = records[selectedGlobalRow]
    configureSettings(record: selectedRecord)
    openSettings()
    }
}
