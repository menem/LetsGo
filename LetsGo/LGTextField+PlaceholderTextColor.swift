//
//  UITextField+PlaceholderTextColor.swift
//  PMA
//
//  Created by Fady on 4/21/17.
//  Copyright © 2017 pyramindmartialarts. All rights reserved.
//

import Foundation
import UIKit

extension LGTextField {
    
    func setPlaceHolder(placeHolderText: String) {
        self.attributedPlaceholder = NSAttributedString(string: placeHolderText,
                                                        attributes: [NSForegroundColorAttributeName: UIColor.white])
    }
    
    func setPlaceHolderTextColorForBeingSelected() {
        if let placeHolderText = self.placeholder {
            self.attributedPlaceholder = NSAttributedString(string: placeHolderText,
                                                            attributes: [NSForegroundColorAttributeName: #colorLiteral(red: 0.8494446278, green: 0.2558809817, blue: 0.002898618812, alpha: 1)])
        }
    }
    
    func changePlaceHolderTextColorToDefault() {
        if (self.text?.isEmpty)! {
            if let placeHolderText = self.placeholder {
                self.attributedPlaceholder = NSAttributedString(string: placeHolderText,
                                                                attributes: [NSForegroundColorAttributeName: UIColor.white])
            }

        }
    }
}
