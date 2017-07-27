//
//  ViewController.swift
//  LetsGo
//
//  Created by Menem Ragab on 7/26/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit
import MZTimerLabel
import KYNavigationProgress
import HGCircularSlider

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        MZTimerLabel *timer = [[MZTimerLabel alloc] initWithLabel:aUILabel andTimerType:MZTimerLabelTypeTimer];
//        [timer setCountDownTime:60];
//        [timer start];
        
        
        
        // get and set progress.
        
        let circularSlider = RangeCircularSlider(frame: CGRect(x: 0, y: self.view.frame.size.height/2, width: self.view.frame.size.width, height: 200))
        circularSlider.startThumbImage = UIImage(named: "Bedtime")
        circularSlider.endThumbImage = UIImage(named: "Wake")
        circularSlider.backgroundColor = .clear
        let dayInSeconds = 24 * 60 * 60
        circularSlider.maximumValue = CGFloat(dayInSeconds)
        
        circularSlider.startPointValue = 1 * 60 * 60
        circularSlider.endPointValue = 8 * 60 * 60
//        circularSlider.numberOfRounds = 2 // Two rotations for full 24h range
        
        self.view.addSubview(circularSlider)
        
        let timerLabel = UILabel(frame: CGRect(x: 0, y: (self.view.frame.size.height/2)+40, width: self.view.frame.size.width, height: 40))
        timerLabel.textAlignment = .center
        let timer = MZTimerLabel(label: timerLabel, andTimerType: MZTimerLabelTypeTimer)
        timer?.setCountDownTime(50)
        self.view.addSubview(timerLabel)
        self.navigationController?.progressTintColor = UIColor(red:0.83, green:0.00, blue:0.00, alpha:1.00)
        timer?.delegate = self
        timer?.start()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: MZTimerLabelDelegate {
    func timerLabel(_ timerLabel: MZTimerLabel!, countingTo time: TimeInterval, timertype timerType: MZTimerLabelType){
        let progress = time/timerLabel.getCountDownTime()
        self.navigationController?.progress = Float(progress)
    }
    
    func timerLabel(_ timerLabel: MZTimerLabel!, finshedCountDownTimerWithTime countTime: TimeInterval){
        
    }
}
