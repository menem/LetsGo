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
        button.tintColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        button.setImage(buttonImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    lazy var pauseButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "icn_pause")
        button.setImage(buttonImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var stopButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "icn_stop")
        button.setImage(buttonImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func adjustTintColor(newColor: UIColor) {
        playButton.tintColor = newColor
        pauseButton.tintColor = newColor
        stopButton.tintColor = newColor
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
            playButton.rightAnchor.constraint(equalTo: self.rightAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 32),
            playButton.heightAnchor.constraint(equalToConstant: 32),
            
            pauseButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            pauseButton.rightAnchor.constraint(equalTo: self.rightAnchor),
            pauseButton.widthAnchor.constraint(equalToConstant: 32),
            pauseButton.heightAnchor.constraint(equalToConstant: 32),
            
            stopButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stopButton.leftAnchor.constraint(equalTo: self.leftAnchor),
            stopButton.widthAnchor.constraint(equalToConstant: 32),
            stopButton.heightAnchor.constraint(equalToConstant: 32)
            
            ])
        super.updateConstraints()
    }
    
}

