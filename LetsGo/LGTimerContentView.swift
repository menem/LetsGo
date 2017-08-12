//
//  LGTimerContentView.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/8/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
import MZTimerLabel

class LGTimerContentView: UIView {
    
    var player: AVAudioPlayer?
    
//TODO: the timelabel requires the frame being set!!
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont (name: "Betm-Regular3", size: 60)
        label.textColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var timer: MZTimerLabel = {
        let timer = MZTimerLabel(label: self.timeLabel)
        timer?.timerType = MZTimerLabelTypeTimer
        timer?.resetTimerAfterFinish = false
        return timer!
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
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "tone", withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timeLabel.topAnchor.constraint(equalTo:  self.topAnchor),
            timeLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            timeLabel.heightAnchor.constraint(equalTo: self.heightAnchor)
            ])
        super.updateConstraints()
    }
    
}
