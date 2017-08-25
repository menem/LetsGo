//
//  TimePickerView.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/24/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit
import LETimeIntervalPicker

class TimePickerView: UIView {
    
    lazy var titlelabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont (name: "BetmHairline", size: 26)
        label.textColor = #colorLiteral(red: 0.340575099, green: 0.3558157086, blue: 0.4202301502, alpha: 1)
        label.sizeToFit()
//        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var datePickerView: LETimeIntervalPicker = {
        let datePicker = LETimeIntervalPicker()
        datePicker.tintColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        datePicker.unitsStyle = .short
       datePicker.components = [.minutes, .seconds]
          datePicker.set(numberOfRows: 121, for: .minutes)
        datePicker.textFont = UIFont (name: "BetmHairline", size: 21)!
    datePicker.numberFont = UIFont (name: "Betm-Regular3", size: 25)!
datePicker.contentMode = .center
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        return datePicker
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(datePickerView)
        self.addSubview(titlelabel)
        setNeedsUpdateConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        NSLayoutConstraint.activate([

            
            titlelabel.topAnchor.constraint(equalTo: self.topAnchor),
            titlelabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        
            datePickerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            datePickerView.topAnchor.constraint(equalTo: self.titlelabel.bottomAnchor),
            datePickerView.heightAnchor.constraint(equalToConstant: 120),
            datePickerView.widthAnchor.constraint(equalToConstant: self.frame.size.width),
            
            ])
        
    }

}
