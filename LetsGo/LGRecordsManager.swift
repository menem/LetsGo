//
//  LGRecordsManager.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/18/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit
import HealthKit

class LGRecordsManager: NSObject {
    var record : LGRecord!
    
    func saveRecord(title: String, timer: Double, isWorkout: Bool){
        
        record = LGRecord(title: title, time: timer, isWorkout: isWorkout)
        
        
        //1. Setup the Calorie Quantity for total energy burned
        let calorieQuantity = HKQuantity(unit: HKUnit.kilocalorie(),
                                         doubleValue: record.calories)
        
        //2. Build the workout using data from your Prancercise workout
        let workout = HKWorkout(activityType: .other,
                                start: Date(),
                                end: Date(),
                                duration: record.timeElapsed,
                                totalEnergyBurned: calorieQuantity,
                                totalDistance: nil,
                                device: HKDevice.local(),
                                metadata: nil)
        
        //3. Save your workout to HealthKit
        let healthStore = HKHealthStore()
        var samples = [HKSample]()
        //1. Verify that the energy quantity type is still available to HealthKit.
        guard let energyQuantityType = HKSampleType
            .quantityType(forIdentifier:HKQuantityTypeIdentifier
                .activeEnergyBurned) else {
                    fatalError("*** Energy Burned Type Not Available ***")
        }
        
        //2. Create a sample for each PrancerciseWorkoutInterval
        //        for interval in workout.intervals {
        
//        let calorieQuantity = HKQuantity(unit: HKUnit.kilocalorie(),
//                                         doubleValue: self.record.calories)
        
        let sample = HKQuantitySample(type: energyQuantityType,
                                      quantity: calorieQuantity,
                                      start: Date(),
                                      end: Date())
        samples.append(sample)
        healthStore.save(workout) { (success, error) in
            
            guard error == nil else {
//                completion(false, error)
                return
            }
            
            healthStore.add(samples,
                            to: workout,
                            completion: { (workout, error) in
                                
                                guard error == nil else {
//                                    completion(false, error)
                                    return
                                }
                                
//                                completion(true, nil)
            })
            
        }
        
        guard let recordData = UserDefaults.standard.object(forKey: "records") as? NSData else {
//            print("'places' not found in UserDefaults")
            var recordsArray: [LGRecord] = []
            recordsArray.append(record)
            
            let newrecordData = NSKeyedArchiver.archivedData(withRootObject: recordsArray)
            UserDefaults.standard.set(newrecordData, forKey: "records")
            
            return
        }
        
        guard var recordsArray = NSKeyedUnarchiver.unarchiveObject(with: recordData as Data) as? [LGRecord] else {
//            print("Could not unarchive from placesData")
            var recordsArray: [LGRecord] = []
            recordsArray.append(record)
            
            let newrecordData = NSKeyedArchiver.archivedData(withRootObject: recordsArray)
            UserDefaults.standard.set(newrecordData, forKey: "records")
            
            return
        }
        
        recordsArray.append(record)
        let newrecordData = NSKeyedArchiver.archivedData(withRootObject: recordsArray)
        UserDefaults.standard.set(newrecordData, forKey: "records")
        
    }
    func updateRecords(newRecords: [LGRecord])  {
            UserDefaults.standard.removeObject(forKey: "records")
        
        guard let recordData = UserDefaults.standard.object(forKey: "records") as? NSData else {
//            print("'places' not found in UserDefaults")
            var recordsArray: [LGRecord] = []
            recordsArray = newRecords
            
            let newrecordData = NSKeyedArchiver.archivedData(withRootObject: recordsArray)
            UserDefaults.standard.set(newrecordData, forKey: "records")
            
            return
        }
        
        guard var recordsArray = NSKeyedUnarchiver.unarchiveObject(with: recordData as Data) as? [LGRecord] else {
//            print("Could not unarchive from placesData")
            var recordsArray: [LGRecord] = []
           recordsArray = newRecords
            
            let newrecordData = NSKeyedArchiver.archivedData(withRootObject: recordsArray)
            UserDefaults.standard.set(newrecordData, forKey: "records")
            
            return
        }
        
        recordsArray = newRecords
        let newrecordData = NSKeyedArchiver.archivedData(withRootObject: recordsArray)
        UserDefaults.standard.set(newrecordData, forKey: "records")
        
    }
    func loadRecords() -> [LGRecord]{
        
        let recordsKey = "records"
        let recordsData = UserDefaults.standard.object(forKey: recordsKey) as? NSData
        
        if let recordsData = recordsData {
            let recordsArray = NSKeyedUnarchiver.unarchiveObject(with: recordsData as Data) as? [LGRecord]
            
            if let recordsArray = recordsArray {
                return recordsArray
            }
            return []
        }
        return []
    }
 
//    private class func samples(for workout: HKWorkout) -> [HKSample] {
//        
//        var samples = [HKSample]()
//        
//        //1. Verify that the energy quantity type is still available to HealthKit.
//        guard let energyQuantityType = HKSampleType
//            .quantityType(forIdentifier:HKQuantityTypeIdentifier
//                .activeEnergyBurned) else {
//                    fatalError("*** Energy Burned Type Not Available ***")
//        }
//        
//        //2. Create a sample for each PrancerciseWorkoutInterval
////        for interval in workout.intervals {
//        
//            let calorieQuantity = HKQuantity(unit: HKUnit.kilocalorie(),
//                                             doubleValue: self.record.calories)
//            
//            let sample = HKQuantitySample(type: energyQuantityType,
//                                          quantity: calorieQuantity,
//                                          start: Date(),
//                                          end: Date())
//            
//            samples.append(sample)
////        }
//        
//        return samples
//    }
    
}
