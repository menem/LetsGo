//
//  LGTimeManager.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/2/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import Foundation

class LGTimerManager {

    func makeActivity (activity: LGActivity){

        }
    
    func startTimer(timer: LGTimer) {
        
    }
    
    func saveActivity(title: String, type: String){
        
        let activity = LGActivity(title: title, type: type)
        let activitiesData = UserDefaults.standard.object(forKey: "activities") as? NSData
        
        if let activitiesData = activitiesData {
            
            let activitiesArray = NSKeyedUnarchiver.unarchiveObject(with: activitiesData as Data) as? [LGActivity]
            if var activitiesArray = activitiesArray {
              activitiesArray.append(activity)
            let newactiviesData = NSKeyedArchiver.archivedData(withRootObject: activitiesArray)
                UserDefaults.standard.set(newactiviesData, forKey: "activities")
            }
            
        }else{
            var activitiesArray = [LGActivity]()
            activitiesArray.append(activity)
            let newactiviesData = NSKeyedArchiver.archivedData(withRootObject: activitiesArray)
            UserDefaults.standard.set(newactiviesData, forKey: "activities")
        }
        
    }


}
