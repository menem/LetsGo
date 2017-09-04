//
//  TimerViewController.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/10/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit
import Pastel
import Intents
import HealthKit

class HomeViewController: UIViewController {
    var scrollView: UIScrollView?
    var pageControl : UIPageControl!
    var viewControllers = [UIViewController]()
    var userIntent: INStartWorkoutIntent!
    let timerViewController = TimerViewController()
    let stopViewController = StopwatchViewController()
    let intervalsViewController = IntervalsViewController()
    let healthManager:HealthKitManager = HealthKitManager()
    var height: HKQuantitySample?
    var Weight: HKQuantitySample?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getHealthKitPermission()
        setHeight()
        setWeight()
        let swipeupforsetting = UISwipeGestureRecognizer(target: self, action: #selector(pushModalSettings))
        swipeupforsetting.direction = .up
        self.view.addGestureRecognizer(swipeupforsetting)
        
        let screenFrame = UIScreen.main.bounds
        
        scrollView = UIScrollView(frame: screenFrame)
        scrollView?.isPagingEnabled = true
        scrollView?.isDirectionalLockEnabled = true
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.delegate = self
        self.view.addSubview(scrollView!)
        

        viewControllers = [timerViewController, stopViewController, intervalsViewController]
        
        let bounds = UIScreen.main.bounds
        let width = screenFrame.size.width
        let height = screenFrame.size.height
        
        scrollView!.contentSize = CGSize(width: 3*width, height: height - 80)
        let pageX = (bounds.size.width/2) - 125
        let pageY = height - 70
        pageControl = UIPageControl(frame: CGRect(x:pageX, y:pageY, width:250, height:50))
        var idx:Int = 0
        
        
        for viewController in viewControllers {
            addChildViewController(viewController);
            let originX:CGFloat = CGFloat(idx) * width;
            viewController.view.frame = CGRect(x: originX, y: 0, width: width, height: height);
            scrollView!.addSubview(viewController.view)
            viewController.didMove(toParentViewController: self)
            idx += 1;
        }
        configurePageControl()
        configureSiri()
        
        self.title = "Home"
        self.navigationController?.navigationBar.titleTextAttributes =  [NSFontAttributeName: UIFont(name: "Betm-Regular3", size: 18)!, NSForegroundColorAttributeName:#colorLiteral(red: 0.921908319, green: 0.9026622176, blue: 0.9022395015, alpha: 1)]
        
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "icn_activities"), style: .plain, target: self, action: #selector(pushActivities))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "icn_records"), style: .plain, target: self, action: #selector(pushRecords))
        self.navigationItem.leftBarButtonItem = leftBarButton
        
    }
    func pushModalSettings(){
        print("Settings ya ma3alem")
        let settingsViewController = SettingsTableViewController()
        let navViewController = UINavigationController(rootViewController: settingsViewController)
        self.present(navViewController, animated: true, completion: nil)
    }
    func getHealthKitPermission() {
        healthManager.authorizeHealthKit { (authorized,  error) -> Void in
            if authorized {
                
                self.setHeight()
            } else {
                if error != nil {
                }
//                print("Permission denied.")
            }
        }
    }
    
    func pushActivities(){
//         healthManager.saveDistance(distanceRecorded: 0.1, date: NSDate())
        let activitiesViewController = ActivitiesViewController()
        self.navigationController?.pushViewController(activitiesViewController, animated: true)
    }
    
    func pushRecords(){
        let recordsTableViewController = RecordsTableViewController()
        self.navigationController?.pushViewController(recordsTableViewController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setHeight() {
        let heightSample = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)
        self.healthManager.getHeight(sampleType: heightSample!, completion: { (userHeight, error) -> Void in
            
            if( error != nil ) {
//                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            var heightString = ""
            var heightValue = 0.0
            self.height = userHeight as? HKQuantitySample
            if let meters = self.height?.quantity.doubleValue(for: HKUnit.meter()) {
                let formatHeight = LengthFormatter()
                formatHeight.isForPersonHeightUse = true
                heightString = formatHeight.string(fromMeters: meters)
                heightValue = meters * 100.0
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
               print("Menem's Height is \(heightString)")
                let userDefaults = UserDefaults.standard
                userDefaults.set(heightValue, forKey: "userHeight")
                userDefaults.synchronize()
            })
        })
        
    }
    
    func setWeight() {
        let WeightSample = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)
        self.healthManager.getWeight(sampleType: WeightSample!, completion: { (userWeight, error) -> Void in
            
            if( error != nil ) {
                //                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            var WeightString = ""
            var weightValue = 0.0
            self.Weight = userWeight as? HKQuantitySample
            if let gram = self.Weight?.quantity.doubleValue(for: HKUnit.gram()) {
                let formatWeight = MassFormatter()
                formatWeight.isForPersonMassUse = true
                WeightString = formatWeight.string(fromKilograms: gram/1000)
                weightValue = gram/1000.0
               
            }
            
                        DispatchQueue.main.async(execute: { () -> Void in
                            print("Menem's Weight is \(WeightString)")
                            let userDefaults = UserDefaults.standard
                            print("Menem's Weight is (Without Unit) \(weightValue)")
                            userDefaults.set(weightValue, forKey: "userWeight")
                            userDefaults.synchronize()
                        })
        })
        
    }

    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        self.pageControl.numberOfPages = 3
        self.pageControl.currentPage = 0
        self.pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        self.pageControl.currentPageIndicatorTintColor = UIColor(red:0.83, green:0.84, blue:0.91, alpha:1.00)
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
        self.view.addSubview(pageControl)
        
    }
    
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * (scrollView?.frame.size.width)!
        scrollView?.setContentOffset(CGPoint(x:x, y:-64), animated: true)
    }
    
    func configureSiri()  {
        INPreferences.requestSiriAuthorization { (status) in
            
        }
        INVocabulary.shared().setVocabularyStrings(["interval","emom","time cap", "wod", "timer", "tabata", "amrap", "stopwatch"], of: .workoutActivityName)
        if ((userIntent) != nil){
            
//            let minute = userIntent.goalValue!/60
            switch String(describing: userIntent.workoutName).lowercased() {
            case "interval":
                self.pageControl.currentPage = 2
                stopViewController.timeContentView.toggleTimer()
            case "time cap":
                self.pageControl.currentPage = 0
                stopViewController.timeContentView.toggleTimer()
            case "stopwatch":
                self.pageControl.currentPage = 1
                stopViewController.timeContentView.toggleTimer()
            default:
                self.pageControl.currentPage = 1
                stopViewController.timeContentView.toggleTimer()
            }
        }
    }
    
}
extension HomeViewController:UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
        let viewcontroller = viewControllers[Int(pageNumber)]
        self.title = viewcontroller.title
    }
}
