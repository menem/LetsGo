//
//  WalkthroughViewController.swift
//  LetsGo
//
//  Created by Menem Ragab on 9/2/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit
import Onboard
class WalkthroughViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstPage = OnboardingContentViewController(title: "Page Title", body: "Page body goes here.", image: UIImage(named: "img_onboard_page1"), buttonText: "Text For Button") { () -> Void in
            // do something here when users press the button, like ask for location services permissions, register for push notifications, connect to social media, or finish the onboarding process
        }
        let secondPage = OnboardingContentViewController(title: "Page Title", body: "Page body goes here.", image: UIImage(named: "img_onboard_page2"), buttonText: "Text For Button") { () -> Void in
            // do something here when users press the button, like ask for location services permissions, register for push notifications, connect to social media, or finish the onboarding process
        }
        let thirdPage = OnboardingContentViewController(title: "Page Title", body: "Page body goes here.", image: UIImage(named: "img_onboard_page3"), buttonText: "Text For Button") { () -> Void in
            // do something here when users press the button, like ask for location services permissions, register for push notifications, connect to social media, or finish the onboarding process
        }
        // Image
        let onboardingVC = OnboardingViewController(backgroundImage: UIImage(named: "img_onboard_bkg"), contents: [firstPage, secondPage, thirdPage])
        
//        // Video
//        let bundle = NSBundle.mainBundle()
//        let moviePath = bundle.pathForResource("yourVid", ofType: "mp4")
//        let movieURL = NSURL(fileURLWithPath: moviePath!)
//        
//        let onboardingVC = OnboardingViewController(backgroundVideoURL: movieUrl, contents: [firstPage, secondPage, thirdPage])
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
