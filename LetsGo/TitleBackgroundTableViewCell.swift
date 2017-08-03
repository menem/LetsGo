//
//  TitleBackgroundTableViewCell.swift
//
//
//  Created by Menem Ragab on  8/3/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//

import UIKit

class TitleBackgroundTableViewCell: UITableViewCell {
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titlelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 55)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.shadowColor = UIColor.black.cgColor
        label.textAlignment = .center
        label.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        label.layer.shadowOpacity = 0.8
        label.layer.shadowRadius = 1.0
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(titlelabel)
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            backgroundImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 40),
            
            titlelabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            titlelabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            ])
    }
}
