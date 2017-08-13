//
//  TimerViewController.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/10/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import Foundation
import UIKit
import EZSwipeController

class HomeViewController: EZSwipeController {
    override func setupView() {
        datasource = self
    }
    
    func pushActivities(){
        let activitiesViewController = ActivitiesViewController()
        self.navigationController?.pushViewController(activitiesViewController, animated: true)
    }
}

extension HomeViewController: EZSwipeControllerDataSource {
    func viewControllerData() -> [UIViewController] {
        let timerViewController = TimerViewController()
        let stopViewController = StopwatchViewController()
        let intervalsViewController = IntervalsViewController()
        
        return [timerViewController, stopViewController,intervalsViewController]
    }
    
    func titlesForPages() -> [String] {
        return ["Timer", "Stopwatch", "Tabata"]
    }
    
    func indexOfStartingPage() -> Int {
        return 1
    }
    
    func changedToPageIndex(_ index: Int) {
        // You can do anything from here, for now we'll just print the new index
        print(index)
    }

    func navigationBarDataForPageIndex(_ index: Int) -> UINavigationBar {
        var title = ""
        switch index {
        case 1:
            title = "Stopwatch"
        case 2:
            title = "Tabata"
        default:
             title = "Timer"
        }
        

        let navigationBar = UINavigationBar()
         navigationBar.barStyle = UIBarStyle.default
        let navigationItem = UINavigationItem(title: title)
        navigationItem.hidesBackButton = true
        
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "icn_activities"), style: .plain, target: self, action: #selector(pushActivities))
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = rightBarButton
        navigationBar.pushItem(navigationItem, animated: false)
        return navigationBar
    }

    func disableSwipingForRightButtonAtPageIndex(_ index: Int) -> Bool {
         return false
    }
    func clickedRightButtonFromPageIndex(_ index: Int) {
        pushActivities()
    }


}
