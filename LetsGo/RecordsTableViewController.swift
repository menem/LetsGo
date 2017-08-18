//
//  RecordsTableViewController.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/18/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit
import RandomColorSwift

let RecordTableViewCellIdentifier = "RecordTableViewCellIdentifier"

class RecordsTableViewController: UITableViewController {

    var records = [LGRecord]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = #colorLiteral(red: 0.921908319, green: 0.9026622176, blue: 0.9022395015, alpha: 1)
        self.tableView.separatorStyle = .none
        self.tableView.register(TitleBackgroundTableViewCell.self, forCellReuseIdentifier: BannerTableViewCellIdentifier)
        self.title = "Records"
        
        loadRecords()
        
    }
    

    
    func loadRecords(){
        let recordsManager = LGRecordsManager()
        records = recordsManager.loadRecords()
        self.tableView.reloadData()
    }

    

    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        } else {
            return records.count
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
            
            self.tableView.register(RecordTableViewCell.self, forCellReuseIdentifier: RecordTableViewCellIdentifier)
            
            let cell = tableView.dequeueReusableCell(withIdentifier: RecordTableViewCellIdentifier, for: indexPath) as! RecordTableViewCell
            let record = records[indexPath.row]
            cell.timeElapsedlabel.text = record.timeElapsed
            cell.titlelabel.text = record.title.capitalized
            cell.backCardView.backgroundColor = randomColor(hue: .random, luminosity: .light)
            return cell
        }
        
        
    }
    

    
}
