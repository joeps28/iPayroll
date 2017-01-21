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

        
    }
    

}
