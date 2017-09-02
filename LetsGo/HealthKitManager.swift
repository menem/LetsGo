//
//  ViewController.swift
//  LetsGo
//
//  Created by Menem Ragab on 7/26/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitManager {
    
    let healthKitStore: HKHealthStore = HKHealthStore()
    
    func authorizeHealthKit(completion: ((_ success: Bool, _ error: Error?) -> Void)!) {
        
        let height = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!
        let weight = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
        
        
        // State the health data type(s) we want to read from HealthKit.
//            let healthDataToRead = Set(arrayLiteral: HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!)

        let healthDataToRead = Set(arrayLiteral: height, weight)//Set.setWithObjects:
        
        let activeCalories = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!
//        let workoutdone = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.total)!
        // State the health data type(s) we want to write from HealthKit.
        let healthDataToWrite = Set(arrayLiteral: activeCalories)
        
        // Just in case OneHourWalker makes its way to an iPad...
        if !HKHealthStore.isHealthDataAvailable() {
//            print("Can't access HealthKit.")
        }
        
        // Request authorization to read and/or write the specific data.
        healthKitStore.requestAuthorization(toShare: healthDataToWrite, read: healthDataToRead) { (success, error) -> Void in
            if( completion != nil ) {
                //             completion(success:success, error:error)
                
            }
        }
    }
    
//    func saveDistance(distanceRecorded: Double, date: NSDate ) {
//        
//        // Set the quantity type to the running/walking distance.
//        let distanceType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)
//        
//        // Set the unit of measurement to miles.
//        let distanceQuantity = HKQuantity(unit: HKUnit.mile(), doubleValue: distanceRecorded)
//        
//        // Set the official Quantity Sample.
//        let distance = HKQuantitySample(type: distanceType!, quantity: distanceQuantity, start: date as Date, end: date as Date)
//        
//        // Save the distance quantity sample to the HealthKit Store.
//        healthKitStore.save(distance, withCompletion: { (success, error) -> Void in
//            if( error != nil ) {
//                //                print(error ?? <#default value#>)
//            } else {
////                print("The distance has been recorded! Better go check!")
//            }
//        })
//    }
    
    func getHeight(sampleType: HKSampleType , completion: ((HKSample?, Error?) -> Void)!) {
        
        // Predicate for the height query
        let distantPastHeight = NSDate.distantPast as NSDate
        let currentDate = NSDate()
        let lastHeightPredicate = HKQuery.predicateForSamples(withStart: distantPastHeight as Date, end: currentDate as Date, options: [])
        
        // Get the single most recent height
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        // Query HealthKit for the last Height entry.
        let heightQuery = HKSampleQuery(sampleType: sampleType, predicate: lastHeightPredicate, limit: 1, sortDescriptors: [sortDescriptor]) { (sampleQuery, results, error ) -> Void in
            
            if let queryError = error {
                completion(nil, queryError)
                return
            }
            
            // Set the first HKQuantitySample in results as the most recent height.
            let lastHeight = results!.first
            
            if completion != nil {
                completion(lastHeight, nil)
            }
        }
        
        // Time to execute the query.
        self.healthKitStore.execute(heightQuery)
    }

    func getWeight(sampleType: HKSampleType , completion: ((HKSample?, Error?) -> Void)!) {
        
        // Predicate for the Weight query
        let distantPastWeight = NSDate.distantPast as NSDate
        let currentDate = NSDate()
        let lastWeightPredicate = HKQuery.predicateForSamples(withStart: distantPastWeight as Date, end: currentDate as Date, options: [])
        
        // Get the single most recent Weight
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        // Query HealthKit for the last Weight entry.
        let WeightQuery = HKSampleQuery(sampleType: sampleType, predicate: lastWeightPredicate, limit: 1, sortDescriptors: [sortDescriptor]) { (sampleQuery, results, error ) -> Void in
            
            if let queryError = error {
                completion(nil, queryError)
                return
            }
            
            // Set the first HKQuantitySample in results as the most recent height.
            let lastWeight = results!.first
            
            if completion != nil {
                completion(lastWeight, nil)
            }
        }
        
        // Time to execute the query.
        self.healthKitStore.execute(WeightQuery)
    }
    
}
