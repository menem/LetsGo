//
//  LGTimeManager.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/2/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import Foundation

class LGTimerManager {
    
    func saveActivity(title: String, type: String){
        
        let activity = LGActivity(title: title, type: type)
        
        
        guard let activitiesData = UserDefaults.standard.object(forKey: "activities") as? NSData else {
//            print("'places' not found in UserDefaults")
            var activitiesArray: [LGActivity] = []
            activitiesArray.append(activity)
            
            let newActivitiesData = NSKeyedArchiver.archivedData(withRootObject: activitiesArray)
            UserDefaults.standard.set(newActivitiesData, forKey: "activities")
            
            return
        }
        
        guard var activitiesArray = NSKeyedUnarchiver.unarchiveObject(with: activitiesData as Data) as? [LGActivity] else {
//            print("Could not unarchive from placesData")
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
    
    func savetimers(title: String,duration: Double,intervals: Int, activity: LGActivity){
        
        let timersKey = "\(activity.title).timers"
        let timer = LGTimer(title: title, duration: duration, intervals: intervals, isWorkout: true)
        
        guard let timersData = UserDefaults.standard.object(forKey: timersKey) as? NSData else {
//            print("'places' not found in UserDefaults")
            var timersArray: [LGTimer] = []
            timersArray.append(timer)
            
            let newTimersData = NSKeyedArchiver.archivedData(withRootObject: timersArray)
            UserDefaults.standard.set(newTimersData, forKey: timersKey)
            
            return
        }
        
        guard var timersArray = NSKeyedUnarchiver.unarchiveObject(with: timersData as Data) as? [LGTimer] else {
//            print("Could not unarchive from placesData")
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
    
    func loadTimers(activity: LGActivity) -> [LGTimer]{
        
        let timersKey = "\(activity.title).timers"
        let timersData = UserDefaults.standard.object(forKey: timersKey) as? NSData
        
        if let timersData = timersData {
            let timersArray = NSKeyedUnarchiver.unarchiveObject(with: timersData as Data) as? [LGTimer]
            
            if let timersArray = timersArray {
                return timersArray
            }
            return []
        }
        return []
    }
    
    func updateTimers(activity: LGActivity, newtimers: [LGTimer]) ->  [LGTimer] {
        let timersKey = "\(activity.title).timers"
        UserDefaults.standard.removeObject(forKey: timersKey)

        guard let timersData = UserDefaults.standard.object(forKey: timersKey) as? NSData else {
//            print("'places' not found in UserDefaults")
            var timersArray: [LGTimer] = []
            timersArray = newtimers
            
            let newTimersData = NSKeyedArchiver.archivedData(withRootObject: timersArray)
            UserDefaults.standard.set(newTimersData, forKey: timersKey)
            
            return timersArray
        }
        
        guard var timersArray = NSKeyedUnarchiver.unarchiveObject(with: timersData as Data) as? [LGTimer] else {
//            print("Could not unarchive from placesData")
            var timersArray: [LGTimer] = []
            timersArray = newtimers
            
            let newTimersData = NSKeyedArchiver.archivedData(withRootObject: timersArray)
            UserDefaults.standard.set(newTimersData, forKey: timersKey)
            return timersArray
        }
        
        timersArray = newtimers
        let newTimersData = NSKeyedArchiver.archivedData(withRootObject: timersArray)
        UserDefaults.standard.set(newTimersData, forKey: timersKey)
   
        return timersArray

    }
    
    func updateActivities(newActivities: [LGActivity])  {
        UserDefaults.standard.removeObject(forKey: "activities")
        
        
        guard let activitiesData = UserDefaults.standard.object(forKey: "activities") as? NSData else {
//            print("'places' not found in UserDefaults")
            var activitiesArray: [LGActivity] = []
            activitiesArray = newActivities
            
            let newActivitiesData = NSKeyedArchiver.archivedData(withRootObject: activitiesArray)
            UserDefaults.standard.set(newActivitiesData, forKey: "activities")
            
            return
        }
        
        guard var activitiesArray = NSKeyedUnarchiver.unarchiveObject(with: activitiesData as Data) as? [LGActivity] else {
//            print("Could not unarchive from placesData")
            var activitiesArray: [LGActivity] = []
            activitiesArray = newActivities
            
            let newActivitiesData = NSKeyedArchiver.archivedData(withRootObject: activitiesArray)
            UserDefaults.standard.set(newActivitiesData, forKey: "activities")
            
            return
        }
        
        activitiesArray = newActivities
        let newActivitiesData = NSKeyedArchiver.archivedData(withRootObject: activitiesArray)
        UserDefaults.standard.set(newActivitiesData, forKey: "activities")

        
    }
    
    func loadActivities() -> [LGActivity] {
        let activitiesData = UserDefaults.standard.object(forKey: "activities") as? NSData
        
        if let activitiesData = activitiesData {
            let activitiesArray = NSKeyedUnarchiver.unarchiveObject(with: activitiesData as Data) as? [LGActivity]
            
            if let activitiesArray = activitiesArray {
                return activitiesArray
            }
            return []
        }
        return []
    }
}
