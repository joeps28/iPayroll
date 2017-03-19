//
//  DesignableTextView.swift
//  iPayroll
//
//  Created by Joel Pineiro on 3/18/17.
//  Copyright © 2017 Joel Pineiro. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableTextView: UITextView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
}
