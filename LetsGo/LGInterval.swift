//
//  LGInterval.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/1/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import Foundation

class LGInterval: NSObject {

    var title: String
    var timer: LGTimer
    var cycles: Int
    var isAlternating: Bool
    
    init(title: String, timer: LGTimer, cycles: Int, isAlternating: Bool) {
        self.title = title
        self.timer = timer
        self.cycles = cycles
        self.isAlternating = isAlternating
        
    }
}
