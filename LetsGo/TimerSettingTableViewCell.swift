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
        let counterSetupButton = UIButton()
        let buttonImage = UIImage(named: "icn_settings")
        counterSetupButton.setImage(buttonImage, for: .normal)
        counterSetupButton.translatesAutoresizingMaskIntoConstraints = false
        return counterSetupButton
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
            counterSetupButton.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            counterSetupButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10),
            counterSetupButton.widthAnchor.constraint(equalToConstant: 32),
            counterSetupButton.heightAnchor.constraint(equalToConstant: 32),
            
            ])
    }
    
}
