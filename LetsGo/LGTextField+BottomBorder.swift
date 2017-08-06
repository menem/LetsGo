//
//  UITextField+BottomBorder.swift
//  PMA
//
//  Created by Fady on 4/21/17.
//  Copyright © 2017 pyramindmartialarts. All rights reserved.
//

import Foundation
import UIKit

extension LGTextField {
    
    func setBottomBarToSelectedState() {
        self.tintColor = #colorLiteral(red: 0.8494446278, green: 0.2558809817, blue: 0.002898618812, alpha: 1)
    }
    
    func setBottomBarToDefaultState() {
        if((self.text?.isEmpty)!) {
            self.tintColor = .white
        }
    }
    

}
