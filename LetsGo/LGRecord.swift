//
//  LGRecord.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/18/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit

class LGRecord: NSObject, NSCoding {
    var title: String
    var timestamp: String
    var notes: String
    var timerMode: String
    var calories: Double
    var timeElapsed: String
    
    init(title: String, time: String) {
        self.title = title
        self.timerMode = " "
        
        self.timestamp = " "
        self.notes = " "
        self.calories = 1.0
        self.timeElapsed = time
    }
    required init?(coder aDecoder: NSCoder) {
        self.timerMode = aDecoder.decodeObject(forKey: "timerMode") as? String ?? ""
        self.title = aDecoder.decodeObject(forKey: "title") as? String ?? ""
         self.timestamp = aDecoder.decodeObject(forKey: "timestamp") as? String ?? ""
         self.notes = aDecoder.decodeObject(forKey: "notes") as? String ?? ""
        self.calories = aDecoder.decodeDouble(forKey: "calories")
        self.timeElapsed = aDecoder.decodeObject(forKey: "timeElapsed") as? String ?? ""
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(timerMode, forKey: "timerMode")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(timestamp, forKey: "timestamp")
        aCoder.encode(notes, forKey: "notes")
        aCoder.encode(calories, forKey: "calories")
        aCoder.encode(timeElapsed, forKey: "timeElapsed")
        
    }
}
