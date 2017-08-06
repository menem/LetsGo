//
//  LGActivity.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/1/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//
import Foundation

class LGActivity: NSObject, NSCoding {
    var title: String
//    var timers = [LGTimer]()
    var type: String
//    var isWorkout: Bool
    
    init(title: String, type: String) {
        self.title = title
//        self.timers = timers
        self.type = type
//        self.isWorkout = isWorkout
    }
    required init?(coder aDecoder: NSCoder) {
        
        self.type = aDecoder.decodeObject(forKey: "type") as? String ?? ""
        self.title = aDecoder.decodeObject(forKey: "title") as? String ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(type, forKey: "type")
        aCoder.encode(title, forKey: "title")
    }

}
