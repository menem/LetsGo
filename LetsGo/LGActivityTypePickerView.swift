//
//  LGActivityTypePickerView.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/26/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit

class LGActivityTypePickerView: UIView {

    lazy var workButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "icn_work")
        button.tintColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        button.setImage(buttonImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    lazy var workoutButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "icn_workout")
        button.setImage(buttonImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var cookingButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "icn_cooking")
        button.setImage(buttonImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
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
            workButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            workButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            workButton.widthAnchor.constraint(equalToConstant: 48),
            workButton.heightAnchor.constraint(equalToConstant: 48),
            
            workoutButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            workoutButton.rightAnchor.constraint(equalTo: self.workButton.leftAnchor, constant: -10),
            workoutButton.widthAnchor.constraint(equalToConstant: 48),
            workoutButton.heightAnchor.constraint(equalToConstant: 48),
            
            cookingButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cookingButton.leftAnchor.constraint(equalTo: self.workButton.rightAnchor, constant: 10),
            cookingButton.widthAnchor.constraint(equalToConstant: 48),
            cookingButton.heightAnchor.constraint(equalToConstant: 48)
            
            ])
        super.updateConstraints()
    }
    

}
