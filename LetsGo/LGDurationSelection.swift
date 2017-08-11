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
       let circularSlider = CircularSlider(frame: CGRect(x: 20, y: 20, width: 250, height: 250))
        circularSlider.diskColor = .clear
        circularSlider.diskFillColor = .clear
        circularSlider.trackFillColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        circularSlider.trackColor = .clear
        circularSlider.backgroundColor = .clear
        circularSlider.lineWidth = 4
        circularSlider.thumbLineWidth = 4
        circularSlider.thumbRadius = 4
        circularSlider.endThumbTintColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        circularSlider.endThumbStrokeHighlightedColor = .clear
        circularSlider.endThumbStrokeColor = .clear
        
        circularSlider.minimumValue = 0
        circularSlider.maximumValue = 60
        circularSlider.endPointValue = 30
        circularSlider.addTarget(self, action: #selector(updateSeconds), for: .valueChanged)
        circularSlider.addTarget(self, action: #selector(adjustSeconds), for: .editingDidEnd)
        return circularSlider
    }()
    
//    minutesCircularSlider
    lazy var minutesCircularSlider: CircularSlider = {
        let circularSlider =  CircularSlider(frame: CGRect(x: 50, y: 50, width: 190, height: 190))
        circularSlider.diskColor = .clear
        circularSlider.diskFillColor = .clear
        circularSlider.trackFillColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        circularSlider.trackColor = .clear
        circularSlider.backgroundColor = .clear
        circularSlider.lineWidth = 4
        circularSlider.thumbLineWidth = 4
        circularSlider.thumbRadius = 4
        circularSlider.endThumbTintColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        circularSlider.endThumbStrokeHighlightedColor = .clear
        circularSlider.endThumbStrokeColor = .clear
        
        
        circularSlider.minimumValue = 0
        circularSlider.maximumValue = 60
        circularSlider.endPointValue = 10
        circularSlider.addTarget(self, action: #selector(updateMinutes), for: .valueChanged)
        circularSlider.addTarget(self, action: #selector(adjustMinutes), for: .editingDidEnd)
        return circularSlider
    }()
    
    var minutesLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 200, y: 270, width: 60, height: 120))
        label.textAlignment = .center
        label.font = UIFont (name: "Betm-Regular3", size: 25)
        label.textColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var secondsLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 260, y: 270, width: 60, height: 40))
        label.textAlignment = .center
        label.font = UIFont (name: "Betm-Regular3", size: 25)
        label.textColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(secondsCircularSlider)
        self.addSubview(minutesCircularSlider)
        self.addSubview(minutesLabel)
        self.addSubview(secondsLabel)
        
        setNeedsUpdateConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            secondsCircularSlider.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            secondsCircularSlider.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            secondsCircularSlider.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20),
            secondsCircularSlider.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -20),
            
            minutesCircularSlider.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            minutesCircularSlider.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            minutesCircularSlider.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40),
            minutesCircularSlider.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -40),
            
            minutesLabel.centerXAnchor.constraint(equalTo: minutesCircularSlider.centerXAnchor, constant: -20),
            minutesLabel.centerYAnchor.constraint(equalTo: minutesCircularSlider.centerYAnchor),
            minutesLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40),
            minutesLabel.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -40),
            
        
            secondsLabel.centerXAnchor.constraint(equalTo: minutesCircularSlider.centerXAnchor, constant: 20),
            secondsLabel.centerYAnchor.constraint(equalTo: minutesCircularSlider.centerYAnchor),
            secondsLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40),
            secondsLabel.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -40)
            ])
        super.updateConstraints()
    }
    // MARK: user interaction methods
    
    func updateMinutes() {
        var selectedHour = Int(minutesCircularSlider.endPointValue)
        // TODO: use date formatter
        selectedHour = (selectedHour == 0 ? 12 : selectedHour)
        minutesLabel.text = String(format: "%02d", selectedHour)
    }
    
    func adjustMinutes() {
        let selectedHour = round(minutesCircularSlider.endPointValue)
        minutesCircularSlider.endPointValue = selectedHour
        updateMinutes()
    }
    
    func updateSeconds() {
        var selectedSecond = Int(secondsCircularSlider.endPointValue)
        // TODO: use date formatter
        selectedSecond = (selectedSecond == 60 ? 0 : selectedSecond)
        secondsLabel.text = String(format: "%02d", selectedSecond)
    }
    
    func adjustSeconds() {
        let selectedSecond = round(secondsCircularSlider.endPointValue)
        secondsCircularSlider.endPointValue = selectedSecond
        updateSeconds()
    }
}
