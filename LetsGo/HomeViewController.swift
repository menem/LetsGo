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
    var pageControl : UIPageControl!
    var viewControllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let screenFrame = self.view.bounds
        scrollView = UIScrollView(frame: screenFrame)
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
        let width = bounds.size.width
        let height = bounds.size.height
        
        scrollView!.contentSize = CGSize(width: 3*width, height: height - 100)
        let pageX = (bounds.size.width/2) - 100
        let pageY = height - 70
         pageControl = UIPageControl(frame: CGRect(x:pageX, y:pageY, width:200, height:50))
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
