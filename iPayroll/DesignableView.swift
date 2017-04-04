//
//  DesignableView.swift
//  iPayroll
//
//  Created by Joel Pineiro on 1/20/17.
//  Copyright © 2017 Joel Pineiro. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableView: GradientView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowWidthOffset: CGFloat = 0 {
        didSet {
            self.layer.shadowOffset = CGSize(width: shadowWidthOffset, height: shadowHeightOffset)
        }
    }
    
    @IBInspectable var shadowHeightOffset: CGFloat = 0 {
        didSet {
            self.layer.shadowOffset = CGSize(width: shadowWidthOffset, height: shadowHeightOffset)
        }
    }
}
