//
//  TimerViewController.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/10/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit
import Pastel


class HomeViewController: UIViewController {
    var scrollView: UIScrollView?
    var pageControl : UIPageControl!
    var viewControllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
           let screenFrame = UIScreen.main.bounds
//        let pastelView = PastelView(frame: screenFrame)
//        
//        // Custom Direction
//        pastelView.startPastelPoint = .bottomLeft
//        pastelView.endPastelPoint = .topRight
//        
//        // Custom Duration
//        pastelView.animationDuration = 3.0
//        
//        // Custom Color
//        pastelView.setColors([UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
//                              UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
//                              UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
//                              UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
//                              UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
//                              UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
//                              UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)])
//        
//        pastelView.startAnimation()
//        view.insertSubview(pastelView, at: 0)
//        
     
        scrollView = UIScrollView(frame: screenFrame)
//        scrollView?.contentInset = UIEdgeInsets(top: -84, left: 0, bottom: 0, right: 0)
        scrollView?.isPagingEnabled = true
        scrollView?.isDirectionalLockEnabled = true
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.delegate = self
        self.view.addSubview(scrollView!)

        let timerViewController = TimerViewController()
        let stopViewController = StopwatchViewController()
        let intervalsViewController = IntervalsViewController()
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

        self.title = "Timer"
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName :#colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)]
     self.navigationController?.navigationBar.titleTextAttributes =  [NSFontAttributeName: UIFont(name: "Betm-Regular3", size: 18)!, NSForegroundColorAttributeName:#colorLiteral(red: 0.921908319, green: 0.9026622176, blue: 0.9022395015, alpha: 1)]
        
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "icn_activities"), style: .plain, target: self, action: #selector(pushActivities))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "icn_records"), style: .plain, target: self, action: #selector(pushRecords))
        self.navigationItem.leftBarButtonItem = leftBarButton
        
    }
    
    func pushActivities(){
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
    

    
}
extension HomeViewController:UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
        let viewcontroller = viewControllers[Int(pageNumber)]
        self.title = viewcontroller.title
    }
}
