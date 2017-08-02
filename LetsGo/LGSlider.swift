//
//  LGSlider.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/2/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import Foundation
import CircularSlider

class LGSlider : CircularSlider {
    
    var containerView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.xibSetup()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.xibSetup()
        self.maximumValue = 5
        self.minimumValue = 0.1
        self.value = 0.1
        self.knobRadius = 20
        self.radiansOffset = 0.01
        self.lineWidth = 10
        self.backgroundColor = .clear
        self.pgHighlightedColor = #colorLiteral(red: 0.9765378833, green: 0.8906318545, blue: 0.4612582326, alpha: 1)
        self.pgNormalColor = #colorLiteral(red: 0.9373082519, green: 0.9373301864, blue: 0.9373183846, alpha: 1)
        self.bgColor = #colorLiteral(red: 0.9373082519, green: 0.9373301864, blue: 0.9373183846, alpha: 1)
        self.tintColor = #colorLiteral(red: 0.9765378833, green: 0.8906318545, blue: 0.4612582326, alpha: 1)
        self.highlighted = true
        self.title = "ON"
        self.divisa = "Min"
        
    }
    
     func xibSetup() {
        containerView = loadViewFromNib()
        containerView.frame = bounds
        containerView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(containerView)
    }
    
     func loadViewFromNib() -> UIView {
        let nibName = "CircularSlider"
        let bundle = Bundle(for: type(of: superclass) as! AnyClass)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner:self, options: nil).first as! UIView
        return view
    }
 
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    
}
