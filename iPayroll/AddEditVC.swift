//
//  AddEditVC.swift
//  iPayroll
//
//  Created by Joel Pineiro on 3/19/17.
//  Copyright © 2017 Joel Pineiro. All rights reserved.
//

import UIKit

class AddEditVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var holidayIconImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "suitcase-icon")!.withRenderingMode(.alwaysTemplate)
        holidayIconImage.image = image
        holidayIconImage.tintColor = UIColor.white
        
    }
    
    @IBAction func dismissModal(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveWorkDay(_ sender: Any) {
        
    }
    
}
