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
    
    
    lazy var selectionView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = view.frame.size.width/2
        view.layer.masksToBounds = true
        view.backgroundColor = #colorLiteral(red: 0.340575099, green: 0.3558157086, blue: 0.4202301502, alpha: 1)
        view.alpha = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var workButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "icn_work")
        button.tintColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        button.tag = 1
        button.setImage(buttonImage, for: .normal)
        button.addTarget(self, action: #selector(setSelectedType(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    lazy var workoutButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "icn_workout")
        button.tag = 3
        button.setImage(buttonImage, for: .normal)
        button.addTarget(self, action: #selector(setSelectedType(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var cookingButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "icn_cooking")
        button.tag = 2
        button.setImage(buttonImage, for: .normal)
        button.addTarget(self, action: #selector(setSelectedType(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setSelectedType(sender: AnyObject) {
        self.selectionView.center = sender.center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(selectionView)
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
            
            selectionView.centerYAnchor.constraint(equalTo: self.workoutButton.centerYAnchor),
            selectionView.centerXAnchor.constraint(equalTo: self.workoutButton.centerXAnchor),
            selectionView.widthAnchor.constraint(equalTo: self.workoutButton.widthAnchor, constant: -4),
            selectionView.heightAnchor.constraint(equalTo: self.workoutButton.heightAnchor, constant: -4),
            
            cookingButton.centerYAnchor.constraint(equalTo: self.workButton.centerYAnchor),
            cookingButton.leftAnchor.constraint(equalTo: self.workButton.rightAnchor, constant: 10),
            cookingButton.widthAnchor.constraint(equalToConstant: 48),
            cookingButton.heightAnchor.constraint(equalToConstant: 48)
            
            ])
        selectionView.layer.cornerRadius = 22
        selectionView.clipsToBounds = true
        super.updateConstraints()
    }
    

}
