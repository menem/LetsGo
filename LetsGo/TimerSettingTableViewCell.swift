//
//  TimerSettingTableViewCell.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/10/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//
import UIKit

class TimerSettingTableViewCell: UITableViewCell {
    
    
    lazy var counterSetupButton: UIButton = {
        let button = UIButton()
//        let buttonImage = UIImage(named: "icn_settings")
        button.setTitle("TAP ON THE TIMER TO EDIT SETTINGS", for: .normal)
        button.titleLabel?.font = UIFont (name: "BetmHairline", size: 18)
//        button.setImage(buttonImage, for: .normal)
        button.tintColor = #colorLiteral(red: 0.921908319, green: 0.9026622176, blue: 0.9022395015, alpha: 1)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        self.backgroundColor = .clear

        contentView.addSubview(counterSetupButton)
        
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            counterSetupButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            counterSetupButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
//            counterSetupButton.widthAnchor.constraint(equalToConstant: 32),
//            counterSetupButton.heightAnchor.constraint(equalToConstant: 32),
            
            ])
    }
    
}
