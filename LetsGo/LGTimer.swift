//
//  LGTimer.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/1/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import Foundation

public enum TimerType
{
    case timer
    case stopwatch
    case tabata
    case rest
}

class LGTimer: NSObject, NSCoding {
    
    var title: String
    var duration: Double
    var type: TimerType
    var isWorkout: Bool
    var intervals: Int
    
    init(title: String, type: TimerType, duration: Double, intervals: Int, isWorkout: Bool) {
        self.title = title
        self.duration = duration
        self.type = type
        self.intervals = intervals
        self.isWorkout = isWorkout
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.title = aDecoder.decodeObject(forKey: "title") as? String ?? ""
        self.duration = aDecoder.decodeDouble(forKey: "duration")
        self.intervals = aDecoder.decodeInteger(forKey: "intervals")
        self.isWorkout = aDecoder.decodeBool(forKey: "isWorkout")
        self.type = aDecoder.decodeObject(forKey: "type") as! TimerType
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(duration, forKey: "duration")
        aCoder.encode(intervals, forKey: "intervals")
        aCoder.encode(isWorkout, forKey: "isWorkout")
        aCoder.encode(type, forKey: "type")
    }
}
