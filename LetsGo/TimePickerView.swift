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
    
    lazy var datePickerView: LETimeIntervalPicker = {
        let datePicker = LETimeIntervalPicker()
        datePicker.tintColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        datePicker.unitsStyle = .abbreviated
//        datePicker.ti
//        datePicker.ti
//        datePicker.
//        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        return datePicker
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(datePickerView)
        setNeedsUpdateConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        NSLayoutConstraint.activate([
            datePickerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            datePickerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            datePickerView.heightAnchor.constraint(equalToConstant: 130),
            datePickerView.widthAnchor.constraint(equalToConstant: self.frame.size.width)
            ])
        
    }

}
