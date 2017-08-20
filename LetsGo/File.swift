//
//  File.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/12/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//
//
// ViewController.swift
//  LetsGo
//
//  Created by Menem Ragab on 7/26/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//
/*
import UIKit
import Intents
import HealthKit

class ViewController: UIViewController {


    let healthManager:HealthKitManager = HealthKitManager()
    var height: HKQuantitySample?
    

    
    func getHealthKitPermission() {
        healthManager.authorizeHealthKit { (authorized,  error) -> Void in
            if authorized {
                
                self.setHeight()
            } else {
                if error != nil {
                }
                print("Permission denied.")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getHealthKitPermission()

    }
    

    
    func setHeight() {
        let heightSample = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)
        self.healthManager.getHeight(sampleType: heightSample!, completion: { (userHeight, error) -> Void in
            
            if( error != nil ) {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            var heightString = ""
            self.height = userHeight as? HKQuantitySample
            if let meters = self.height?.quantity.doubleValue(for: HKUnit.meter()) {
                let formatHeight = LengthFormatter()
                formatHeight.isForPersonHeightUse = true
                heightString = formatHeight.string(fromMeters: meters)
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                self.heightLabel.text = heightString
            })
        })
        
    }
    
}
extension ViewController: MZTimerLabelDelegate {

    func timerLabel(_ timerLabel: MZTimerLabel!, finshedCountDownTimerWithTime countTime: TimeInterval){
        healthManager.saveDistance(distanceRecorded: 0.1, date: NSDate())

    }
}
 */
