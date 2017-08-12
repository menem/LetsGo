//
//  CounterTableViewCell.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/10/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//
import UIKit
import RandomColorSwift

class CounterTableViewCell: UITableViewCell {
    
     var timerContentView: LGTimerContentView = {
        var timer = LGTimerContentView()
        timer.translatesAutoresizingMaskIntoConstraints = false
        return timer
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        self.backgroundColor = .clear
        
        contentView.addSubview(timerContentView)
        setNeedsUpdateConstraints()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            timerContentView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            timerContentView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            timerContentView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            timerContentView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor)
            
            ])
    }
    
}
