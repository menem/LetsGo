//
//  TimeHelper.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/25/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit

class TimeHelper: NSObject {
    static let sharedInstance = TimeHelper()
    
    func timefromTimeInterval(timeInterval: TimeInterval) -> String {
        
        let ti = NSInteger(timeInterval)
        
//        let ms = Int((timeInterval % 1) * 1000)
        
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        
        if hours <= 0 {
            if minutes <= 0 {
                return String(format: "%0.2d Sec",seconds)
            }else{
                    return String(format: "%0.2d:%0.2d",minutes,seconds)
            }
        }else{
        return String(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
        }
        
    }
}
