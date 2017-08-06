//
//  TimerTableViewCell.swift
//
//
//  Created by Menem Ragab on  8/3/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit

class TimerTableViewCell: UITableViewCell {
    
//    lazy var activityTypeImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
    
    lazy var titlelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.340575099, green: 0.3558157086, blue: 0.4202301502, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var Durationlabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.8494446278, green: 0.2558809817, blue: 0.002898618812, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var Intervalslabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.9765378833, green: 0.8906318545, blue: 0.4612582326, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        contentView.addSubview(titlelabel)
//        contentView.addSubview(activityTypeImageView)
        contentView.addSubview(Intervalslabel)
        contentView.addSubview(Durationlabel)
        
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            Durationlabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            Durationlabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 32),
            Durationlabel.widthAnchor.constraint(equalToConstant: 60),
            Durationlabel.heightAnchor.constraint(equalToConstant: 60),
            
            titlelabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            titlelabel.leftAnchor.constraint(equalTo: self.Durationlabel.rightAnchor, constant: 32),
            titlelabel.rightAnchor.constraint(equalTo: self.Intervalslabel.leftAnchor, constant: -32),
            
            Intervalslabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            Intervalslabel.leftAnchor.constraint(equalTo: self.titlelabel.rightAnchor, constant: 32),
            Intervalslabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -32),
            
            ])
    }
    
}
