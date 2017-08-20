//
//  LGDoneButton.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/16/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit

class LGDoneButton: UIView {

    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Betm-Regular3", size: 25)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 4
        button.layer.borderColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(doneButton)
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            doneButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            doneButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            doneButton.widthAnchor.constraint(equalTo: self.widthAnchor),
            doneButton.heightAnchor.constraint(equalToConstant: 50),
            
            ])
        super.updateConstraints()
    }


}
