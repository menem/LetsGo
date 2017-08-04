//
//  LGTextField.swift
//
//
//  Created by Menem Ragab on  8/4/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import Foundation
import UIKit

class LGTextField : UITextField {
    
    override var tintColor: UIColor! {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let startingPoint = CGPoint(x: rect.minX, y: rect.maxY)
        let endingPoint = CGPoint(x: rect.maxX, y: rect.maxY)
        let path = UIBezierPath()
        path.move(to: startingPoint)
        path.addLine(to: endingPoint)
        path.lineWidth = 2.0
        tintColor.setStroke()
        path.stroke()
    }
}
