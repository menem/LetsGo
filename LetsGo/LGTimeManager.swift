//
//  LGTimeManager.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/2/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import Foundation

class LGTimerManager {

//    func makeActivity (activity: LGActivity){
//
//        }
//    
//    func startTimer(timer: LGTimer) {
//        
//    }
    
    func saveActivity(title: String, type: String){
        
        let activity = LGActivity(title: title, type: type)

        
        guard let activitiesData = UserDefaults.standard.object(forKey: "activities") as? NSData else {
            print("'places' not found in UserDefaults")
            var activitiesArray: [LGActivity] = []
            activitiesArray.append(activity)
            
            let newActivitiesData = NSKeyedArchiver.archivedData(withRootObject: activitiesArray)
            UserDefaults.standard.set(newActivitiesData, forKey: "activities")

            return
        }
        
        guard var activitiesArray = NSKeyedUnarchiver.unarchiveObject(with: activitiesData as Data) as? [LGActivity] else {
            print("Could not unarchive from placesData")
            var activitiesArray: [LGActivity] = []
            activitiesArray.append(activity)
            
            let newActivitiesData = NSKeyedArchiver.archivedData(withRootObject: activitiesArray)
            UserDefaults.standard.set(newActivitiesData, forKey: "activities")

            return
        }
        
        activitiesArray.append(activity)
        let newActivitiesData = NSKeyedArchiver.archivedData(withRootObject: activitiesArray)
        UserDefaults.standard.set(newActivitiesData, forKey: "activities")
        
    }

    func savetimers(title: String, type: String, activity: LGActivity){
        
        let timersKey = "\(activity.title).timers"
        let timer = LGTimer(title: title, duration: 1.0, intervals: 1, isWorkout: true)
        
        guard let timersData = UserDefaults.standard.object(forKey: timersKey) as? NSData else {
            print("'places' not found in UserDefaults")
            var timersArray: [LGTimer] = []
            timersArray.append(timer)
            
            let newTimersData = NSKeyedArchiver.archivedData(withRootObject: timersArray)
            UserDefaults.standard.set(newTimersData, forKey: timersKey)
            
            return
        }
        
        guard var timersArray = NSKeyedUnarchiver.unarchiveObject(with: timersData as Data) as? [LGTimer] else {
            print("Could not unarchive from placesData")
            var timersArray: [LGTimer] = []
            timersArray.append(timer)
            
            let newTimersData = NSKeyedArchiver.archivedData(withRootObject: timersArray)
            UserDefaults.standard.set(newTimersData, forKey: timersKey)
            return
        }
        
        timersArray.append(timer)
        let newTimersData = NSKeyedArchiver.archivedData(withRootObject: timersArray)
        UserDefaults.standard.set(newTimersData, forKey: timersKey)
        
    }
    //MARK: Implement Load Activities
    //MARK: Implement Load Timers For Activity
}
