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
        swipeSelector.backgroundColor = .clear
        swipeSelector.tintColor = #colorLiteral(red: 0.9844431281, green: 0.9844661355, blue: 0.9844536185, alpha: 1)
        swipeSelector.swipingLabelColor = #colorLiteral(red: 0.9765378833, green: 0.8906318545, blue: 0.4612582326, alpha: 1)
        swipeSelector.maxSwipingColor = #colorLiteral(red: 0.5015509129, green: 0.5780293345, blue: 0.8545677066, alpha: 1)
        swipeSelector.minSwipingColor = #colorLiteral(red: 0, green: 0.7402182221, blue: 0.7307808995, alpha: 1)
        swipeSelector.swipingLabelColor = #colorLiteral(red: 0.9844431281, green: 0.9844661355, blue: 0.9844536185, alpha: 1)
        swipeSelector.defaultLabelColor = #colorLiteral(red: 0.9844431281, green: 0.9844661355, blue: 0.9844536185, alpha: 1)
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
