//
//  AppDelegate.swift
//  LetsGo
//
//  Created by Menem Ragab on 7/26/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit
import Intents
import Pastel
import Onboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.isIdleTimerDisabled = true
        setAppearance()
        
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        let isNightMode = UserDefaults.standard.bool(forKey: "isNightMode")
        
        if launchedBefore  {
            let homeViewController = HomeViewController()
            let navViewController = UINavigationController(rootViewController: homeViewController)
            
            window!.rootViewController = navViewController
            window!.makeKeyAndVisible()
            if !isNightMode {
              setApplicationBackground()
            }
           
            
            return true
        } else {
            let firstPage = OnboardingContentViewController(title: "Page Title", body: "Page body goes here.", image: UIImage(named: "img_onboard_page1"), buttonText: "Text For Button") { () -> Void in
                // do something here when users press the button, like ask for location services permissions, register for push notifications, connect to social media, or finish the onboarding process
            }
            firstPage.iconHeight = 400
            firstPage.iconImageView.contentMode = .scaleAspectFit
            
            let secondPage = OnboardingContentViewController(title: "Track Time", body: "Track your ", image: UIImage(named: "img_onboard_page2"), buttonText: "Text For Button") { () -> Void in
                // do something here when users press the button, like ask for location services permissions, register for push notifications, connect to social media, or finish the onboarding process
            }
            secondPage.iconHeight = 400
            secondPage.iconImageView.contentMode = .scaleAspectFit

            
            let thirdPage = OnboardingContentViewController(title: "Page Title", body: "Page body goes here.", image: UIImage(named: "img_onboard_page3"), buttonText: "Let's Go") { () -> Void in
                let homeViewController = HomeViewController()
                //            homeViewController.userIntent = startIntent
                let navViewController = UINavigationController(rootViewController: homeViewController)
                
                self.window!.rootViewController = navViewController
                self.window!.makeKeyAndVisible()
                
                if !isNightMode {
                    self.setApplicationBackground()
                }
                
            }
            thirdPage.iconHeight = 400
            thirdPage.iconImageView.contentMode = .scaleAspectFit
            // Image
            let onboardingVC = OnboardingViewController(backgroundImage: UIImage(named: "img_onboard_bkg"), contents: [firstPage, secondPage, thirdPage])
            onboardingVC?.shouldFadeTransitions = true
            onboardingVC?.shouldMaskBackground = false
            //        let homeViewController = HomeViewController()
            let navViewController = UINavigationController(rootViewController: onboardingVC!)
            
            window!.rootViewController = navViewController
            window!.makeKeyAndVisible()
            
            if !isNightMode {
                setApplicationBackground()
            }
            
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            
            return true
        }

    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        guard let endIntent = userActivity.interaction?.intent as? INEndWorkoutIntent else {
//            print("AppDelegate: end Workout Intent - FALSE")
            return false
        }
        print(endIntent)
        
        guard let startIntent = userActivity.interaction?.intent as? INStartWorkoutIntent else {
//            print("AppDelegate: Start Workout Intent - FALSE")
            return false
        }
//        print("AppDelegate: Start Workout Intent - TRUE")
        let isNightMode = UserDefaults.standard.bool(forKey: "isNightMode")
        let homeViewController = HomeViewController()
                homeViewController.userIntent = startIntent
        let navViewController = UINavigationController(rootViewController: homeViewController)
        
        window!.rootViewController = navViewController
        window!.makeKeyAndVisible()
        
        if !isNightMode {
            setApplicationBackground()
        }
        return true
    }
    
    func setApplicationBackground(){
        let screenFrame = UIScreen.main.bounds
        let originX = screenFrame.origin.x
        let originY = screenFrame.origin.y - 84
        let height = screenFrame.height + 120
        let width = screenFrame.width
        let pastelView = PastelView(frame: CGRect(x: originX, y: originY, width: width, height: height))
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        pastelView.animationDuration = 3.0
        pastelView.setColors([UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
                              UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
                              UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
                              UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)])
        
        pastelView.startAnimation()
        UIApplication.shared.keyWindow?.insertSubview(pastelView, at: 0)
    }
    func setAppearance() {
        
        self.window?.backgroundColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = #colorLiteral(red: 0.921908319, green: 0.9026622176, blue: 0.9022395015, alpha: 1)
        navigationBarAppearace.barTintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        navigationBarAppearace.titleTextAttributes =  [NSFontAttributeName: UIFont(name: "Betm-Regular3", size: 18)!, NSForegroundColorAttributeName:#colorLiteral(red: 0.921908319, green: 0.9026622176, blue: 0.9022395015, alpha: 1)]
        navigationBarAppearace.shadowImage = UIImage()
        navigationBarAppearace.setBackgroundImage(UIImage(), for: .default)
    }
}

