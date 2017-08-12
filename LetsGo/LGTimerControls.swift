//
//  LGTimer Controls.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/12/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import Foundation
import UIKit

class LGTimerControls: UIView {
    
    lazy var playButton: UIButton = {
        let counterSetupButton = UIButton()
        let buttonImage = UIImage(named: "icn_play")
        counterSetupButton.setImage(buttonImage, for: .normal)
        counterSetupButton.translatesAutoresizingMaskIntoConstraints = false
        return counterSetupButton
    }()
    
    
    lazy var pauseButton: UIButton = {
        let counterSetupButton = UIButton()
        let buttonImage = UIImage(named: "icn_pause")
        counterSetupButton.setImage(buttonImage, for: .normal)
        counterSetupButton.translatesAutoresizingMaskIntoConstraints = false
        return counterSetupButton
    }()
    
    lazy var stopButton: UIButton = {
        let counterSetupButton = UIButton()
        let buttonImage = UIImage(named: "icn_stop")
        counterSetupButton.setImage(buttonImage, for: .normal)
        counterSetupButton.translatesAutoresizingMaskIntoConstraints = false
        return counterSetupButton
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSub
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            playButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            playButton.rightAnchor.constraint(equalTo: self.rightAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 32),
            playButton.heightAnchor.constraint(equalToConstant: 32),
            ])
        super.updateConstraints()
    }
    
}

