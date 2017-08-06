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
    //MARK: Implement Load Activities
    //MARK: Implement Load Timers For Activity
}
