//
//  ProfileViewController.swift
//  iPayroll
//
//  Created by Joel Pineiro on 1/20/17.
//  Copyright © 2017 Joel Pineiro. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
            
            self.dismiss(animated: true, completion: nil)
            
        }, completion: nil)
    }
    

}
