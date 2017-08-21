//
//  LGRecordsManager.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/18/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit

class LGRecordsManager: NSObject {
    
    func saveRecord(title: String, timer: String){
        
        let record = LGRecord(title: title, time: timer)
        
        
        guard let recordData = UserDefaults.standard.object(forKey: "records") as? NSData else {
            print("'places' not found in UserDefaults")
            var recordsArray: [LGRecord] = []
            recordsArray.append(record)
            
            let newrecordData = NSKeyedArchiver.archivedData(withRootObject: recordsArray)
            UserDefaults.standard.set(newrecordData, forKey: "records")
            
            return
        }
        
        guard var recordsArray = NSKeyedUnarchiver.unarchiveObject(with: recordData as Data) as? [LGRecord] else {
            print("Could not unarchive from placesData")
            var recordsArray: [LGRecord] = []
            recordsArray.append(record)
            
            let newrecordData = NSKeyedArchiver.archivedData(withRootObject: recordsArray)
            UserDefaults.standard.set(newrecordData, forKey: "records")
            
            return
        }
        
        recordsArray.append(record)
        let newrecordData = NSKeyedArchiver.archivedData(withRootObject: recordsArray)
        UserDefaults.standard.set(newrecordData, forKey: "records")
        
    }
    func updateRecords(newRecords: [LGRecord])  {
            UserDefaults.standard.removeObject(forKey: "records")
        
        guard let recordData = UserDefaults.standard.object(forKey: "records") as? NSData else {
            print("'places' not found in UserDefaults")
            var recordsArray: [LGRecord] = []
            recordsArray = newRecords
            
            let newrecordData = NSKeyedArchiver.archivedData(withRootObject: recordsArray)
            UserDefaults.standard.set(newrecordData, forKey: "records")
            
            return
        }
        
        guard var recordsArray = NSKeyedUnarchiver.unarchiveObject(with: recordData as Data) as? [LGRecord] else {
            print("Could not unarchive from placesData")
            var recordsArray: [LGRecord] = []
           recordsArray = newRecords
            
            let newrecordData = NSKeyedArchiver.archivedData(withRootObject: recordsArray)
            UserDefaults.standard.set(newrecordData, forKey: "records")
            
            return
        }
        
        recordsArray = newRecords
        let newrecordData = NSKeyedArchiver.archivedData(withRootObject: recordsArray)
        UserDefaults.standard.set(newrecordData, forKey: "records")
        
    }
    func loadRecords() -> [LGRecord]{
        
        let recordsKey = "records"
        let recordsData = UserDefaults.standard.object(forKey: recordsKey) as? NSData
        
        if let recordsData = recordsData {
            let recordsArray = NSKeyedUnarchiver.unarchiveObject(with: recordsData as Data) as? [LGRecord]
            
            if let recordsArray = recordsArray {
                return recordsArray
            }
            return []
        }
        return []
    }
    
}
