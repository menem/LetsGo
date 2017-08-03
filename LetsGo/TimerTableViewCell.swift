//
//  TimerTableViewCell.swift
//
//
//  Created by Menem Ragab on  8/3/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit

class TimerTableViewCell: UITableViewCell {
    
    lazy var activityTypeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titlelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.340575099, green: 0.3558157086, blue: 0.4202301502, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        contentView.addSubview(titlelabel)
        contentView.addSubview(activityTypeImageView)
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            activityTypeImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            activityTypeImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 32),
            activityTypeImageView.widthAnchor.constraint(equalToConstant: 60),
            activityTypeImageView.heightAnchor.constraint(equalToConstant: 60),
            
            titlelabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            titlelabel.leftAnchor.constraint(equalTo: self.activityTypeImageView.rightAnchor, constant: 32),
            titlelabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -32),
            
            ])
    }
    
}
