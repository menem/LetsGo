//
//  LGActivity.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/1/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//
import Foundation

class LGActivity: NSObject {
    var title: String
    var timers = [LGTimer]()
    var type: String
    var isWorkout: Bool
    
    init(title: String, type: String, timers: [LGTimer], isWorkout: Bool) {
        self.title = title
        self.timers = timers
        self.type = type
        self.isWorkout = isWorkout
    }

}
