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
  
    lazy var minutesCircularSlider: CircularSlider = {
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
        circularSlider.endPointValue = 35
        circularSlider.addTarget(self, action: #selector(updateMinutes), for: .valueChanged)
        circularSlider.addTarget(self, action: #selector(adjustMinutes), for: .editingDidEnd)
        return circularSlider
    }()
    
    
    lazy var hoursCircularSlider: CircularSlider = {
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
        circularSlider.maximumValue = 12
        circularSlider.endPointValue = 6
        circularSlider.addTarget(self, action: #selector(updateHours), for: .valueChanged)
        circularSlider.addTarget(self, action: #selector(adjustHours), for: .editingDidEnd)
        return circularSlider
    }()
    
    var hoursLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 200, y: 270, width: 60, height: 120))
        label.textAlignment = .center
        label.font = UIFont (name: "Betm-Regular3", size: 25)
        label.textColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var minutesLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 260, y: 270, width: 60, height: 40))
        label.textAlignment = .center
        label.font = UIFont (name: "Betm-Regular3", size: 25)
        label.textColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(minutesCircularSlider)
        self.addSubview(hoursCircularSlider)
        self.addSubview(hoursLabel)
        self.addSubview(minutesLabel)
        
        setNeedsUpdateConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            minutesCircularSlider.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            minutesCircularSlider.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            minutesCircularSlider.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20),
            minutesCircularSlider.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -20),
            
            hoursCircularSlider.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            hoursCircularSlider.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            hoursCircularSlider.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40),
            hoursCircularSlider.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -40),
            
            hoursLabel.centerXAnchor.constraint(equalTo: hoursCircularSlider.centerXAnchor, constant: -20),
            hoursLabel.centerYAnchor.constraint(equalTo: hoursCircularSlider.centerYAnchor),
            hoursLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40),
            hoursLabel.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -40),
            
            minutesLabel.centerXAnchor.constraint(equalTo: hoursCircularSlider.centerXAnchor, constant: 20),
            minutesLabel.centerYAnchor.constraint(equalTo: hoursCircularSlider.centerYAnchor),
            minutesLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40),
            minutesLabel.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -40)
            ])
        super.updateConstraints()
    }
    // MARK: user interaction methods
    
    func updateHours() {
        var selectedHour = Int(hoursCircularSlider.endPointValue)
        // TODO: use date formatter
        selectedHour = (selectedHour == 0 ? 12 : selectedHour)
        hoursLabel.text = String(format: "%02d", selectedHour)
    }
    
    func adjustHours() {
        let selectedHour = round(hoursCircularSlider.endPointValue)
        hoursCircularSlider.endPointValue = selectedHour
        updateHours()
    }
    
    func updateMinutes() {
        var selectedMinute = Int(minutesCircularSlider.endPointValue)
        // TODO: use date formatter
        selectedMinute = (selectedMinute == 60 ? 0 : selectedMinute)
        minutesLabel.text = String(format: "%02d", selectedMinute)
    }
    
    func adjustMinutes() {
        let selectedMinute = round(minutesCircularSlider.endPointValue)
        minutesCircularSlider.endPointValue = selectedMinute
        updateMinutes()
    }
}
