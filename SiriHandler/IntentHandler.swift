//
//  IntentHandler.swift
//  SiriHandler
//
//  Created by Menem Ragab on 7/27/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import Intents

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"
class IntentHandler: INExtension, INStartWorkoutIntentHandling, INPauseWorkoutIntentHandling, INResumeWorkoutIntentHandling, INCancelWorkoutIntentHandling, INEndWorkoutIntentHandling {
    
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
    public func handle(startWorkout intent: INStartWorkoutIntent, completion: @escaping (INStartWorkoutIntentResponse) -> Swift.Void) {
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INStartWorkoutIntent.self))
        let response = INStartWorkoutIntentResponse(code: .continueInApp, userActivity: userActivity)
        completion(response)
        
    }
    
    func handle(endWorkout intent: INEndWorkoutIntent, completion: @escaping (INEndWorkoutIntentResponse) -> Void) {
//        print("Ending Service")
        let result = INEndWorkoutIntentResponse(code: .ready, userActivity: nil)
        completion(result)
    }
    
    func handle(pauseWorkout intent: INPauseWorkoutIntent, completion: @escaping (INPauseWorkoutIntentResponse) -> Void) {
//        print("Pausing Service")
        let result = INPauseWorkoutIntentResponse(code: .ready, userActivity: nil)
        completion(result)
    }
    
    func handle(cancelWorkout intent: INCancelWorkoutIntent, completion: @escaping (INCancelWorkoutIntentResponse) -> Void) {
//        print("Cancel Service")
        let result = INCancelWorkoutIntentResponse(code: .ready, userActivity: nil)
        completion(result)
    }
    
    func handle(resumeWorkout intent: INResumeWorkoutIntent, completion: @escaping (INResumeWorkoutIntentResponse) -> Void) {
//        print("Resume Service")
        let result = INResumeWorkoutIntentResponse(code: .ready, userActivity: nil)
        completion(result)
    }
}
