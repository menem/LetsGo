//
//  LGRecord.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/18/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit

let KCrossfitMET = 8

class LGRecord: NSObject, NSCoding {
    var title: String
    var timestamp: String
    var notes: String
    var calories: Double
    var timeElapsed: Double
    var isWorkout: Bool
    
    init(title: String, time: Double, isWorkout: Bool) {
        self.title = title
        self.timestamp = Date().description
        self.notes = " "
        self.isWorkout = isWorkout
        if isWorkout{
            if let userWeight = UserDefaults.standard.object(forKey: "userWeight") as! Double! {
                if userWeight > 1 {
                    self.calories = 0.0175 * Double(KCrossfitMET) * userWeight * (time/60)
                }else{
                    self.calories = 0.0175 * Double(KCrossfitMET) * 90 * (time/60)
                }
            }else{
                self.calories = 0.0175 * Double(KCrossfitMET) * 90 * (time/60)
            }
        }else{
        self.calories = 0
        }
        
        self.timeElapsed = time
    }
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "title") as? String ?? ""
         self.timestamp = aDecoder.decodeObject(forKey: "timestamp") as? String ?? ""
         self.notes = aDecoder.decodeObject(forKey: "notes") as? String ?? ""
        self.calories = aDecoder.decodeDouble(forKey: "calories")
        self.timeElapsed = aDecoder.decodeDouble(forKey: "timeElapsed")
         self.isWorkout = aDecoder.decodeBool(forKey: "isWorkout")
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(timestamp, forKey: "timestamp")
        aCoder.encode(notes, forKey: "notes")
        aCoder.encode(calories, forKey: "calories")
        aCoder.encode(timeElapsed, forKey: "timeElapsed")
         aCoder.encode(isWorkout, forKey: "isWorkout")
        
    }
}
