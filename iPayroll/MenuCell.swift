//
//  MenuCell.swift
//  iPayroll
//
//  Created by Joel Pineiro on 1/11/17.
//  Copyright © 2017 Joel Pineiro. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    var setting: MenuItem? {
        didSet {
            nameLabel.text = setting?.name
        
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.black
            }
            
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.black
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home-icon")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    func setupViews() {
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstraintsWithFormat(format: "H:|-15-[v0(30)]-20-[v1]|", views: iconImageView, nameLabel)
        
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        
        addConstraintsWithFormat(format: "V:[v0(30)]", views: iconImageView)
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


