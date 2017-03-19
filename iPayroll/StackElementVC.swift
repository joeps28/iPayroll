//
//  StackElementViewController.swift
//  iPayroll
//
//  Created by Joel Pineiro on 1/15/17.
//  Copyright © 2017 Joel Pineiro. All rights reserved.
//

import UIKit

class StackElementViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var clockImageView: UIImageView!
    @IBOutlet weak var patientsIconImageView: UIImageView!
    @IBOutlet weak var moneyEarnedImageView: UIImageView!
    
    // TODO
    // substitute String for data model class
    var headerString: String? {
        didSet {
            configureView()
        }
    }
    
    func configureView() {
        titleLabel.text = headerString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clockImageView.tintColor = UIColor.init(red: 235/255, green: 100/255, blue: 100/255, alpha: 1.0)
        moneyEarnedImageView.tintColor = UIColor.lightGray;
    }
    

}
