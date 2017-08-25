//
//  LGCountDownTimer.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/16/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit
import CountdownLabel
import AVFoundation

class LGCountDownTimer: UIView {
    
    lazy var timeLabel: CountdownLabel = {
       let  label = CountdownLabel()
        label.setCountDownTime(minutes: 10)
        label.animationType = .Scale
        label.textAlignment = .center
        label.font = UIFont (name: "Betm-Regular3", size: 60)
        label.textColor = #colorLiteral(red: 0.9765378833, green: 0.8906318545, blue: 0.4612582326, alpha: 1)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var tintColor: UIColor! {
        didSet {
            timeLabel.textColor = tintColor
            setNeedsDisplay()
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(timeLabel)
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func updateConstraints() {
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo:  self.centerYAnchor),
            timeLabel.widthAnchor.constraint(equalTo:  self.widthAnchor),
            timeLabel.heightAnchor.constraint(equalTo:  self.heightAnchor),
            ])
        super.updateConstraints()
    }
}
