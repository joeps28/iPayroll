//
//  ProfileViewController.swift
//  iPayroll
//
//  Created by Joel Pineiro on 1/20/17.
//  Copyright © 2017 Joel Pineiro. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var weekdayPayTextField: UITextField!
    @IBOutlet weak var weekendPayTextField: UITextField!
    @IBOutlet weak var weekendDiffTextField: UITextField!
    @IBOutlet weak var wkndsBeforeDiffTextField: UITextField!
    
    @IBOutlet weak var patientPayTextField: UITextField!
    @IBOutlet weak var patientWithPATextField: UITextField!
    @IBOutlet weak var patientDiffTextField: UITextField!
    @IBOutlet weak var patientsBeforeDiffTextField: UITextField!
    
    @IBOutlet weak var profileContainerScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage(named: "profile_highlighted")!.withRenderingMode(.alwaysTemplate)
        profileImageView.image = image
        profileImageView.tintColor = UIColor.lightGray
        
        addTextFieldsAccessoryView()
    }
    
    func addTextFieldsAccessoryView() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneButtonOnToolBar))
        
        toolBar.setItems([flexibleSpace, doneButton], animated: true)
        
        weekdayPayTextField.inputAccessoryView = toolBar
        weekendPayTextField.inputAccessoryView = toolBar
        weekendDiffTextField.inputAccessoryView = toolBar
        wkndsBeforeDiffTextField.inputAccessoryView = toolBar
        
        patientPayTextField.inputAccessoryView = toolBar
        patientWithPATextField.inputAccessoryView = toolBar
        patientDiffTextField.inputAccessoryView = toolBar
        patientsBeforeDiffTextField.inputAccessoryView = toolBar
        
    }
    
    func doneButtonOnToolBar() {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let yTextField = textField.frame.origin.y
        let heightScrollView = profileContainerScrollView.frame.height
        
        if (yTextField > heightScrollView - 250) {
            profileContainerScrollView.setContentOffset(CGPoint(x: 0, y: heightScrollView - yTextField), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        profileContainerScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
            
            self.dismiss(animated: true, completion: nil)
            
        }, completion: nil)
    }
    

}
