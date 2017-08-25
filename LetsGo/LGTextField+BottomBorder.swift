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
        self.tintColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
    }
    
    func setBottomBarToDefaultState() {
        if((self.text?.isEmpty)!) {
            self.tintColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        }
    }
    
    
}
