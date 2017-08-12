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
}

extension HomeViewController: EZSwipeControllerDataSource {
    func viewControllerData() -> [UIViewController] {
        let timerViewController = TimerViewController()
        let stopViewController = StopwatchViewController()
        let activitiesViewController = ActivitiesViewController()
        
        return [timerViewController, stopViewController,activitiesViewController ]
    }
    
    func titlesForPages() -> [String] {
        return ["Timer", "Stopwatch", "Tabata"]
    }
    
    func indexOfStartingPage() -> Int {
        return 1 // EZSwipeController starts from 2nd, green page
    }
    
    func changedToPageIndex(_ index: Int) {
        // You can do anything from here, for now we'll just print the new index
        print(index)
    }
}
