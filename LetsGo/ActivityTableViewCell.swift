//
//  ActivityTableViewCell.swift
//
//
//  Created by Menem Ragab on  8/3/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {
    
    lazy var activityTypeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = #colorLiteral(red: 0.340575099, green: 0.3558157086, blue: 0.4202301502, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titlelabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont (name: "BetmHairline", size: 36)
        label.textColor = #colorLiteral(red: 0.340575099, green: 0.3558157086, blue: 0.4202301502, alpha: 1)
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var backCardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5.0
        view.alpha = 0.7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        contentView.addSubview(backCardView)
        contentView.addSubview(titlelabel)
        contentView.addSubview(activityTypeImageView)
        contentView.sendSubview(toBack: backCardView)
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            activityTypeImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            activityTypeImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 32),
            activityTypeImageView.widthAnchor.constraint(equalToConstant: 32),
            activityTypeImageView.heightAnchor.constraint(equalToConstant: 32),
            
            titlelabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            titlelabel.leftAnchor.constraint(equalTo: self.activityTypeImageView.rightAnchor, constant: 8),
            titlelabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10),
            
            backCardView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            backCardView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            backCardView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, constant: -10),
            backCardView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant: -20),
            
            
            ])
    }
    
}
