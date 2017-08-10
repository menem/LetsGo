//
//  LGDurationSelection.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/10/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import Foundation
import UIKit
import MZTimerLabel

class LGDurationSelection: UIView {
    
    //TODO: the timelabel requires the frame being set!!
    
    lazy var timeLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 120))
        label.textAlignment = .center
        label.font = UIFont (name: "Betm-Regular3", size: 60)
        label.textColor = #colorLiteral(red: 1, green: 0.4542224407, blue: 0.1010893807, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(timeLabel)
        self.bringSubview(toFront: timeLabel)
        setNeedsUpdateConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timeLabel.topAnchor.constraint(equalTo:  self.topAnchor),
            timeLabel.widthAnchor.constraint(equalToConstant: self.frame.size.width),
            timeLabel.heightAnchor.constraint(equalToConstant: self.frame.size.height)
            ])
        super.updateConstraints()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
}
