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

class LGTimer: NSObject {
    
    var title: String
    var duration: Double
    var type: TimerType
    var routineType: String
    var isWorkout: Bool
    
    init(title: String, type: TimerType, duration: Double, routineType: String, isWorkout: Bool) {
        self.title = title
        self.duration = duration
        self.type = type
        self.routineType = routineType
        self.isWorkout = isWorkout
    }
}
