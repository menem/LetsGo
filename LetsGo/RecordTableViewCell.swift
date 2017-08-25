//
//  RecordTableViewCell.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/18/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    lazy var timeElapsedlabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont (name: "BetmHairline", size: 26)
        label.textColor = #colorLiteral(red: 0.340575099, green: 0.3558157086, blue: 0.4202301502, alpha: 1)
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    lazy var calorieslabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont (name: "BetmHairline", size: 26)
        label.textColor = #colorLiteral(red: 0.340575099, green: 0.3558157086, blue: 0.4202301502, alpha: 1)
    label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var calorieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icn_calorie")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = #colorLiteral(red: 0.340575099, green: 0.3558157086, blue: 0.4202301502, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var backCardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5.0
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
        contentView.addSubview(timeElapsedlabel)
        contentView.addSubview(calorieImageView)
        contentView.addSubview(calorieslabel)
        contentView.sendSubview(toBack: backCardView)
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            timeElapsedlabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            timeElapsedlabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 32),
            timeElapsedlabel.widthAnchor.constraint(equalToConstant: 60),
            timeElapsedlabel.heightAnchor.constraint(equalToConstant: 32),
            
            titlelabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            titlelabel.leftAnchor.constraint(equalTo: self.timeElapsedlabel.rightAnchor, constant: 8),
            titlelabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10),
            
            backCardView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            backCardView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            backCardView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, constant: -10),
            backCardView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant: -20),
            
            calorieImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            calorieImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -15),
            calorieImageView.widthAnchor.constraint(equalToConstant: 16),
            calorieImageView.heightAnchor.constraint(equalToConstant: 16),
            
            calorieslabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            calorieslabel.rightAnchor.constraint(equalTo: self.calorieImageView.leftAnchor, constant: 5),
//            calorieslabel.widthAnchor.constraint(equalToConstant: 100),
            calorieslabel.heightAnchor.constraint(equalToConstant: 32),
            ])
    }

}
