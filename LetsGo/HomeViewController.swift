//
//  TimerViewController.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/10/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {
    var scrollView: UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenFrame = self.view.bounds
        scrollView = UIScrollView(frame: screenFrame)
        scrollView?.isPagingEnabled = true
        scrollView?.isDirectionalLockEnabled = true
        
//        scrollView?.delegate = self
        self.view.addSubview(scrollView!)
        
        let timerViewController = TimerViewController()
        let stopViewController = StopwatchViewController()
        let intervalsViewController = IntervalsViewController()
        
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        let height = bounds.size.height
        
        scrollView!.contentSize = CGSize(width: 3*width, height: height - 100)
        
        
        let viewControllers = [timerViewController, stopViewController, intervalsViewController]
        
        var idx:Int = 0
        
        
        for viewController in viewControllers {
            // index is the index within the array
            // participant is the real object contained in the array
            addChildViewController(viewController);
            let originX:CGFloat = CGFloat(idx) * width;
            viewController.view.frame = CGRect(x: originX, y: 0, width: width, height: height);
            scrollView!.addSubview(viewController.view)
            viewController.didMove(toParentViewController: self)
            idx += 1;
        }
        self.title = "Timer"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName :#colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)]
        
        
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "icn_activities"), style: .plain, target: self, action: #selector(pushActivities))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    func pushActivities(){
        let activitiesViewController = ActivitiesViewController()
        self.navigationController?.pushViewController(activitiesViewController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

//extension HomeViewController:UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: 64)
//    }
//}

//import EZSwipeController
//
//class HomeViewController: EZSwipeController {
//    override func setupView() {
//        datasource = self
//    }
//    
//    func pushActivities(){
//        let activitiesViewController = ActivitiesViewController()
//        self.navigationController?.pushViewController(activitiesViewController, animated: true)
//    }
//}
//
//extension HomeViewController: EZSwipeControllerDataSource {
//    func viewControllerData() -> [UIViewController] {
//        let timerViewController = TimerViewController()
//        let stopViewController = StopwatchViewController()
//        let intervalsViewController = IntervalsViewController()
//        
//        return [timerViewController, stopViewController,intervalsViewController]
//    }
//    
//    func titlesForPages() -> [String] {
//        return ["Timer", "Stopwatch", "Tabata"]
//    }
//    
//    func indexOfStartingPage() -> Int {
//        return 1
//    }
//    
//    func changedToPageIndex(_ index: Int) {
//        // You can do anything from here, for now we'll just print the new index
//        print(index)
//    }
//
//    func navigationBarDataForPageIndex(_ index: Int) -> UINavigationBar {
//        var title = ""
//        switch index {
//        case 1:
//            title = "Stopwatch"
//        case 2:
//            title = "Tabata"
//        default:
//             title = "Timer"
//        }
//        
//
//        let navigationBar = UINavigationBar()
//         navigationBar.barStyle = UIBarStyle.default
//        let navigationItem = UINavigationItem(title: title)
//        navigationItem.hidesBackButton = true
//        
//        let rightBarButton = UIBarButtonItem(image: UIImage(named: "icn_activities"), style: .plain, target: self, action: #selector(pushActivities))
//        navigationItem.leftBarButtonItem = nil
//        navigationItem.rightBarButtonItem = rightBarButton
//        navigationBar.pushItem(navigationItem, animated: false)
//        return navigationBar
//    }
//
//    func disableSwipingForRightButtonAtPageIndex(_ index: Int) -> Bool {
//         return false
//    }
//    func clickedRightButtonFromPageIndex(_ index: Int) {
//        pushActivities()
//    }
//
//
//}
