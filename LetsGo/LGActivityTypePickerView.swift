//
//  LGActivityTypePickerView.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/26/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit

class LGActivityTypePickerView: UIView {
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont (name: "BetmHairline", size: 18)
        label.textColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        label.text = "Select Activity Type"
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var workButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "icn_work")
        button.tintColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        button.tag = 1
        button.setImage(buttonImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    lazy var workoutButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "icn_workout")
        button.tag = 3
        button.setImage(buttonImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var cookingButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "icn_cooking")
        button.tag = 2
        button.setImage(buttonImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLabel)
        self.addSubview(workButton)
        self.addSubview(workoutButton)
        self.addSubview(cookingButton)
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func updateConstraints() {
        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 25),
            
            workButton.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            workButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            workButton.widthAnchor.constraint(equalToConstant: 48),
            workButton.heightAnchor.constraint(equalToConstant: 48),
            
            workoutButton.centerYAnchor.constraint(equalTo: self.workButton.centerYAnchor),
            workoutButton.rightAnchor.constraint(equalTo: self.workButton.leftAnchor, constant: -10),
            workoutButton.widthAnchor.constraint(equalToConstant: 48),
            workoutButton.heightAnchor.constraint(equalToConstant: 48),
            
            cookingButton.centerYAnchor.constraint(equalTo: self.workButton.centerYAnchor),
            cookingButton.leftAnchor.constraint(equalTo: self.workButton.rightAnchor, constant: 10),
            cookingButton.widthAnchor.constraint(equalToConstant: 48),
            cookingButton.heightAnchor.constraint(equalToConstant: 48)
            
            ])
        super.updateConstraints()
    }
    

}
