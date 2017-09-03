//
//  MeasurementTableViewCell.swift
//  LetsGo
//
//  Created by Menem Ragab on 9/3/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit
import ODMSwipeSelector

class MeasurementTableViewCell: UITableViewCell {
    
    
    lazy var measurementSelector: ODMSwipeSelector = {
        let swipeSelector = ODMSwipeSelector()
        swipeSelector.backgroundColor = .blue
        swipeSelector.translatesAutoresizingMaskIntoConstraints = false
        return swipeSelector
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        self.backgroundColor = .clear
        
        contentView.addSubview(measurementSelector)
        
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            measurementSelector.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            measurementSelector.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            measurementSelector.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            measurementSelector.heightAnchor.constraint(equalTo: self.contentView.heightAnchor),
            
            ])
    }
    
}
