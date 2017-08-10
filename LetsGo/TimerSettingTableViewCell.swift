//
//  TimerSettingTableViewCell.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/10/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//
import UIKit
import VBFPopFlatButton

class TimerSettingTableViewCell: UITableViewCell {
    
    lazy var counterSetupButton: VBFPopFlatButton = {
        let button = VBFPopFlatButton()
        button.roundBackgroundColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        button.tintColor = #colorLiteral(red: 0.921908319, green: 0.9026622176, blue: 0.9022395015, alpha: 1)
        button.lineThickness = 2
        button.currentButtonType = .buttonMenuType
        button.currentButtonStyle = .buttonRoundedStyle
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
            counterSetupButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            counterSetupButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10),
            counterSetupButton.widthAnchor.constraint(equalToConstant: 60),
            counterSetupButton.heightAnchor.constraint(equalToConstant: 60),
            
            ])
    }
    
}
