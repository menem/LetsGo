//
//  LGRoundSelector.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/15/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit

class LGRoundSelector: UIView {

    var quantity: Double!
    
    lazy var roundsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont (name: "BetmHairline", size: 25)
        label.textColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        label.text = "Rounds: 1"
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var roundStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.autorepeat = true
        stepper.maximumValue = 10.0
        stepper.minimumValue = 1.0
        stepper.tintColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
        stepper.addTarget(self, action: #selector(stepperValueDidChange), for: .valueChanged)

        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    
//    lazy var quantityLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.font = UIFont (name: "BetmHairline", size: 25)
//        label.textColor = #colorLiteral(red: 0.1977134943, green: 0.2141624689, blue: 0.2560140491, alpha: 1)
//        label.sizeToFit()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
    override var tintColor: UIColor! {
        didSet {
//            quantityLabel.tintColor = tintColor
            roundStepper.tintColor = tintColor
            roundsLabel.tintColor = tintColor
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(roundsLabel)
        self.addSubview(roundStepper)
//        self.addSubview(quantityLabel)

        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            roundsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            roundsLabel.rightAnchor.constraint(equalTo: self.centerXAnchor),
            
            roundStepper.centerYAnchor.constraint(equalTo: roundsLabel.centerYAnchor),
            roundStepper.leftAnchor.constraint(equalTo: roundsLabel.rightAnchor , constant: 5),
            roundStepper.widthAnchor.constraint(equalToConstant: 100),
            roundStepper.heightAnchor.constraint(equalToConstant: 40),
            
            ])
        super.updateConstraints()
    }
    
    func stepperValueDidChange(stepper: UIStepper) {
        
        let stepperMapping: [UIStepper: UILabel] = [roundStepper: roundsLabel]
        
        stepperMapping[stepper]!.text = "Rounds: \(Int(stepper.value))"
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
