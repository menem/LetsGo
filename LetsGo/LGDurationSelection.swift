//
//  LGDurationSelection.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/10/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import Foundation
import UIKit
import HGCircularSlider

class LGDurationSelection: UIView {
  
    lazy var secondsCircularSlider: CircularSlider = {
       let circularSlider = CircularSlider()
        circularSlider.diskColor = .clear
        circularSlider.diskFillColor = .clear
        circularSlider.trackFillColor = #colorLiteral(red: 0.340575099, green: 0.3558157086, blue: 0.4202301502, alpha: 1)
        circularSlider.trackColor = #colorLiteral(red: 0.8633617759, green: 0.8748404384, blue: 0.9247974157, alpha: 1)
        circularSlider.backgroundColor = .clear
        circularSlider.lineWidth = 4
        circularSlider.thumbLineWidth = 4
        circularSlider.thumbRadius = 4
        circularSlider.endThumbTintColor = #colorLiteral(red: 0.340575099, green: 0.3558157086, blue: 0.4202301502, alpha: 1)
        circularSlider.endThumbStrokeHighlightedColor = .clear
        circularSlider.endThumbStrokeColor = .clear
        
        circularSlider.minimumValue = 0
        circularSlider.maximumValue = 60
        circularSlider.endPointValue = 30
        circularSlider.addTarget(self, action: #selector(updateSeconds), for: .valueChanged)
        circularSlider.addTarget(self, action: #selector(adjustSeconds), for: .editingDidEnd)
        circularSlider.translatesAutoresizingMaskIntoConstraints = false
        return circularSlider
    }()
    
    lazy var minutesCircularSlider: CircularSlider = {
        let circularSlider =  CircularSlider()
        circularSlider.diskColor = .clear
        circularSlider.diskFillColor = .clear
        circularSlider.trackFillColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        circularSlider.trackColor = #colorLiteral(red: 0.8633617759, green: 0.8748404384, blue: 0.9247974157, alpha: 1)
        circularSlider.backgroundColor = .clear
        circularSlider.lineWidth = 4
        circularSlider.thumbLineWidth = 4
        circularSlider.thumbRadius = 4
        circularSlider.endThumbTintColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        circularSlider.endThumbStrokeHighlightedColor = .clear
        circularSlider.endThumbStrokeColor = .clear
        
        
        circularSlider.minimumValue = 1
        circularSlider.maximumValue = 60
        circularSlider.endPointValue = 10
        circularSlider.addTarget(self, action: #selector(updateMinutes), for: .valueChanged)
        circularSlider.addTarget(self, action: #selector(adjustMinutes), for: .editingDidEnd)
        circularSlider.translatesAutoresizingMaskIntoConstraints = false
        return circularSlider
    }()
    
    var minutesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont (name: "Betm-Regular3", size: 25)
        label.textColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var separatorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont (name: "Betm-Regular3", size: 30)
        label.textColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        label.text = ":"
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var secondsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont (name: "BetmHairline", size: 25)
        label.textColor = #colorLiteral(red: 0.340575099, green: 0.3558157086, blue: 0.4202301502, alpha: 1)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var timeTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont (name: "BetmHairline", size: 15)
        label.text = "MIN:sec"
        label.textColor = #colorLiteral(red: 0.340575099, green: 0.3558157086, blue: 0.4202301502, alpha: 1)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(secondsCircularSlider)
        self.addSubview(minutesCircularSlider)
        self.addSubview(minutesLabel)
        self.addSubview(separatorLabel)
        self.addSubview(secondsLabel)
        self.addSubview(timeTextLabel)
        
        updateMinutes()
        updateSeconds()
        setNeedsUpdateConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            secondsCircularSlider.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            secondsCircularSlider.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            secondsCircularSlider.widthAnchor.constraint(equalTo: self.widthAnchor),
            secondsCircularSlider.heightAnchor.constraint(equalTo: self.heightAnchor),
            
            minutesCircularSlider.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            minutesCircularSlider.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            minutesCircularSlider.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -100),
            minutesCircularSlider.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -100),
            
            minutesLabel.centerXAnchor.constraint(equalTo: minutesCircularSlider.centerXAnchor, constant: -20),
            minutesLabel.centerYAnchor.constraint(equalTo: minutesCircularSlider.centerYAnchor),
        
            separatorLabel.centerYAnchor.constraint(equalTo: minutesLabel.centerYAnchor),
            separatorLabel.leftAnchor.constraint(equalTo: minutesLabel.rightAnchor),
            
            secondsLabel.centerYAnchor.constraint(equalTo: separatorLabel.centerYAnchor),
            secondsLabel.leftAnchor.constraint(equalTo: separatorLabel.rightAnchor),
            
            timeTextLabel.topAnchor.constraint(equalTo: minutesLabel.bottomAnchor),
            timeTextLabel.centerXAnchor.constraint(equalTo: minutesLabel.rightAnchor),

            ])
        super.updateConstraints()
    }

    func updateMinutes() {
        var selectedMinute = Int(minutesCircularSlider.endPointValue)
        selectedMinute = (selectedMinute == 60 ? 0 : selectedMinute)
        minutesLabel.text = String(format: "%02d", selectedMinute)
    }
    
    func adjustMinutes() {
        let selectedMinute = round(minutesCircularSlider.endPointValue)
        minutesCircularSlider.endPointValue = selectedMinute
        updateMinutes()
    }
    
    func updateSeconds() {
        var selectedSecond = Int(secondsCircularSlider.endPointValue)
        selectedSecond = (selectedSecond == 60 ? 0 : selectedSecond)
        secondsLabel.text = String(format: "%02d", selectedSecond)
    }
    
    func adjustSeconds() {
        let selectedSecond = round(secondsCircularSlider.endPointValue)
        secondsCircularSlider.endPointValue = selectedSecond
        updateSeconds()
    }
}
