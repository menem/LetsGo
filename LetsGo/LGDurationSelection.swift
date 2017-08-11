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
       let circularSlider = CircularSlider(frame: CGRect(x: 20, y: 20, width: 150, height: 150))
        circularSlider.minimumValue = 0
        circularSlider.maximumValue = 60
        circularSlider.endPointValue = 35
        circularSlider.addTarget(self, action: #selector(updateMinutes), for: .valueChanged)
        circularSlider.addTarget(self, action: #selector(adjustMinutes), for: .editingDidEnd)
        return circularSlider
    }()
    
    
    lazy var hoursCircularSlider: CircularSlider = {
        let circularSlider =  CircularSlider(frame: CGRect(x: 40, y: 40, width: 100, height: 100))
        circularSlider.minimumValue = 0
        circularSlider.maximumValue = 12
        circularSlider.endPointValue = 6
        circularSlider.addTarget(self, action: #selector(updateHours), for: .valueChanged)
        circularSlider.addTarget(self, action: #selector(adjustHours), for: .editingDidEnd)
        return circularSlider
    }()
    
    lazy var hoursLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 120))
        label.textAlignment = .center
        label.font = UIFont (name: "Betm-Regular3", size: 60)
        label.textColor = #colorLiteral(red: 1, green: 0.4542224407, blue: 0.1010893807, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var minutesLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 120))
        label.textAlignment = .center
        label.font = UIFont (name: "Betm-Regular3", size: 60)
        label.textColor = #colorLiteral(red: 1, green: 0.4542224407, blue: 0.1010893807, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(minutesCircularSlider)
        self.addSubview(hoursCircularSlider)
//        self.addSubview(hoursLabel)
//        self.addSubview(minutesLabel)
        
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
            hoursCircularSlider.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20),
            hoursCircularSlider.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -20)
            
            
            
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
