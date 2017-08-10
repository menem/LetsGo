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
    
    lazy var timerContentView: LGTimerContentView = {
        var timer = LGTimerContentView()
//        con   tentview
        return timer
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        self.backgroundColor = .clear
        
        contentView.addSubview(timerContentView)
//        timerContentView.frame = contentView.frame
        setNeedsUpdateConstraints()
//        contentView.setNeedsLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            timerContentView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            timerContentView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            timerContentView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            timerContentView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            
            ])
    }
    
}
