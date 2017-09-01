//
//  TimerTableViewCell.swift
//
//
//  Created by Menem Ragab on  8/3/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit
import QuartzCore

protocol TimerCellUpdateDelegate {
    func cellDidChangeState(cell: TimerTableViewCell)
}

class TimerTableViewCell: UITableViewCell {
//    var isHightlightedForDisplay: Bool!
    var delegate: TimerCellUpdateDelegate?
    
    public  var isHightlightedForDisplay: Bool = false {
//        willSet(newTotalSteps) {
//            
//        }
        didSet {
            delegate?.cellDidChangeState(cell: self)
        }
    }
    lazy var titlelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont (name: "Betm-Regular3", size: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var Durationlabel: UILabel = {
        let label = UILabel()
        label.font = UIFont (name: "BetmHairline", size: 21)
        label.layer.cornerRadius = 5.0
        label.layer.masksToBounds = true
        label.sizeToFit()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var backCardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var Intervalslabel: UILabel = {
        let label = UILabel()
        label.font = UIFont (name: "BetmHairline", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.isHightlightedForDisplay = false
        self.selectionStyle = .none
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        self.backgroundColor = .clear
        contentView.addSubview(backCardView)
        contentView.addSubview(titlelabel)
        contentView.addSubview(Durationlabel)
        contentView.sendSubview(toBack: backCardView)
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            Durationlabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            Durationlabel.rightAnchor.constraint(equalTo: self.backCardView.rightAnchor, constant: -10),
            
            titlelabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            titlelabel.leftAnchor.constraint(equalTo: self.backCardView.leftAnchor, constant: 10),
            titlelabel.rightAnchor.constraint(equalTo: self.Durationlabel.leftAnchor, constant: -32),
            
            backCardView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            backCardView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            backCardView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, constant: -10),
            backCardView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant: -20),
            
            ])
    }
    
}
