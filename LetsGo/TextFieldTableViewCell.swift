//
//  TextFieldTableViewCell.swift
//
//
//  Created by Menem Ragab on  8/4/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    
    lazy var userInputTextField: LGTextField = {
        let textField = LGTextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.tintColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        textField.textAlignment = .center
        textField.textColor = #colorLiteral(red: 0.2333382666, green: 0.5698561072, blue: 0.8839787841, alpha: 1)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.addSubview(userInputTextField)
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        NSLayoutConstraint.activate([
            userInputTextField.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 50),
            userInputTextField.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            userInputTextField.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 48),
            userInputTextField.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -48)
            ])
    }
    
}
