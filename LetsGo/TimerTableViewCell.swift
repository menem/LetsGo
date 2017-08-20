//
//  TimerTableViewCell.swift
//
//
//  Created by Menem Ragab on  8/3/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit

class TimerTableViewCell: UITableViewCell {
    
    lazy var titlelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont (name: "BetmHairline", size: 24)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var Durationlabel: UILabel = {
        let label = UILabel()
        label.font = UIFont (name: "BetmHairline", size: 24)

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
        self.selectionStyle = .none
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        self.backgroundColor = .clear
        contentView.addSubview(backCardView)
        contentView.addSubview(titlelabel)
        contentView.addSubview(Intervalslabel)
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
            Durationlabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 32),
            Durationlabel.widthAnchor.constraint(equalToConstant: 60),
            Durationlabel.heightAnchor.constraint(equalToConstant: 60),
            
            titlelabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            titlelabel.leftAnchor.constraint(equalTo: self.Durationlabel.rightAnchor, constant: 32),
            titlelabel.rightAnchor.constraint(equalTo: self.Intervalslabel.leftAnchor, constant: -32),
            
            Intervalslabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            Intervalslabel.leftAnchor.constraint(equalTo: self.titlelabel.rightAnchor, constant: 32),
            Intervalslabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -32),
            
            backCardView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            backCardView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            backCardView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, constant: -10),
            backCardView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant: -20),
            
            ])
    }
    
}
