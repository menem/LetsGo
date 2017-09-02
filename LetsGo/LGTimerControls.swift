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
        let button = UIButton()
        let buttonImage = UIImage(named: "icn_play")
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        button.setImage(buttonImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    lazy var pauseButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "icn_pause")
         button.imageView?.contentMode = .scaleAspectFill
        button.setImage(buttonImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var stopButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "icn_stop")
         button.imageView?.contentMode = .scaleAspectFill
        button.setImage(buttonImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override var tintColor: UIColor! {
        didSet {
            playButton.tintColor = tintColor
            pauseButton.tintColor = tintColor
            stopButton.tintColor = tintColor
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(playButton)
        self.addSubview(pauseButton)
        self.addSubview(stopButton)
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            playButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            playButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 64),
            playButton.heightAnchor.constraint(equalToConstant: 64),
            
            pauseButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            pauseButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            pauseButton.widthAnchor.constraint(equalToConstant: 64),
            pauseButton.heightAnchor.constraint(equalToConstant: 64),
            
            stopButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stopButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            stopButton.widthAnchor.constraint(equalToConstant: 64),
            stopButton.heightAnchor.constraint(equalToConstant: 64)
            
            ])
        super.updateConstraints()
    }
    
}

