//
//  SwitchTableViewCell.swift
//  LetsGo
//
//  Created by Menem Ragab on 9/3/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit
//import KNSwitcher

class SwitchTableViewCell: UITableViewCell {

    lazy var modeSwitch: KNSwitcher = {
        let switchButton = KNSwitcher(frame: CGRect(x: 200, y: 0, width: 100, height: 40), on: false)
        switchButton.setImages(onImage: UIImage(named: "Checkmark"), offImage: UIImage(named: "Delete"))
//        switchButton.translatesAutoresizingMaskIntoConstraints = false
        return switchButton
    }()
    
    lazy var titlelabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont (name: "Betm-Regular3", size: 28)
        label.textColor = #colorLiteral(red: 0.9844431281, green: 0.9844661355, blue: 0.9844536185, alpha: 1)
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        self.backgroundColor = .clear
        
        contentView.addSubview(modeSwitch)
        contentView.addSubview(titlelabel)
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            
            titlelabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            titlelabel.leftAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 10),
            titlelabel.rightAnchor.constraint(equalTo: self.modeSwitch.leftAnchor, constant: 10),
            
            
            modeSwitch.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20 ),
            modeSwitch.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            modeSwitch.widthAnchor.constraint(equalToConstant: 100),
            modeSwitch.heightAnchor.constraint(equalToConstant: 40),
            
            ])
    }

}
