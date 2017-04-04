//
//  AddEditVC.swift
//  iPayroll
//
//  Created by Joel Pineiro on 3/19/17.
//  Copyright © 2017 Joel Pineiro. All rights reserved.
//

import UIKit
import CloudKit

class AddEditVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var dateTextField: DesignableTextField!
    @IBOutlet weak var locationTextField: DesignableTextField!
    @IBOutlet weak var hoursTextField: DesignableTextField!
    @IBOutlet weak var patientsTextField: DesignableTextField!
    @IBOutlet weak var patientsWithPaTextField: DesignableTextField!
    @IBOutlet weak var holidaySwitch: UISwitch!
    @IBOutlet weak var notesTextView: DesignableTextView!
    @IBOutlet weak var containerScrollView: UIScrollView!
    
    @IBOutlet weak var holidayIconImage: UIImageView!
    
    var editingWorkDay: Bool = false
    var workDay = WorkDay()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    @IBAction func dismissModal(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveWorkDay(_ sender: Any) {
        if allRequiredFields() {
        
            let newWorkDay = WorkDay()
            if let dateStr = dateTextField.text {
                newWorkDay.date = toDateFromString(dateStr, myDateFormat: "EEE MMMM dd, yyyy")
            }
            if let location = locationTextField.text { newWorkDay.location = location}
            if let hours = hoursTextField.text { newWorkDay.hours = hours.floatValue }
            if let patients = patientsTextField.text { newWorkDay.patients = patients.intValue }
            if let paPatients = patientsWithPaTextField.text { newWorkDay.patientsWithPa = paPatients.intValue }
            if let notes = notesTextView.text {
                if notes != "Use this field to enter enything you would like to remember!" {
                    newWorkDay.notes = notes
                }
            }
            newWorkDay.holiday = holidaySwitch.isOn
            
            let record = CKRecord(recordType: "WorkDay")
            record.setValue(newWorkDay.date, forKey: "date")
            record.setValue(newWorkDay.location, forKey: "location")
            record.setValue(newWorkDay.hours, forKey: "hours")
            record.setValue(newWorkDay.patients, forKey: "patients")
            record.setValue(newWorkDay.patientsWithPa, forKey: "patientsWithPa")
            record.setValue(newWorkDay.holiday, forKey: "holiday")
            record.setValue(newWorkDay.notes, forKey: "notes")
            
            let publicData = CKContainer.default().publicCloudDatabase
            publicData.save(record, completionHandler: { record, error in
                if error != nil {
                    print(error!)
                }
            })
            dismiss(animated: true, completion: nil)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.isEqual(dateTextField) {
            dateTextField.text = getDateOnlyString(self.workDay.date, myDateFormat: "EEE MMMM dd, yyyy")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        notesTextView.text = ""
        
        self.containerScrollView.setContentOffset(CGPoint(x: 0, y: 200), animated: true)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.isEqual(notesTextView) && notesTextView.text == "" {
            notesTextView.text = "Use this field to enter enything you would like to remember!"
        }
        self.containerScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func setUp() {
        let image = UIImage(named: "suitcase-icon")!.withRenderingMode(.alwaysTemplate)
        holidayIconImage.image = image
        holidayIconImage.tintColor = UIColor.white
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.frame = CGRect(x: 0, y: 50, width: 300, height: 226)
        datePicker.addTarget(self, action: #selector(self.dataPickerChanged(_:)), for: .valueChanged)
        dateTextField.inputView = datePicker
        
        self.addTextFieldsAccessoryView()
        
        dateTextField.delegate = self
        locationTextField.delegate = self
        hoursTextField.delegate = self
        patientsTextField.delegate = self
        patientsWithPaTextField.delegate = self
        
        notesTextView.delegate = self
    }
    
    func allRequiredFields() -> Bool {
        if dateTextField.text       == "" ||
           hoursTextField.text      == "" ||
           patientsTextField.text   == "" {
            
            let alert = UIAlertController(title: "Error", message: "Date, Hours and Patients are required fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            return false
        }
        
        return true
    }
    
    func dataPickerChanged(_ sender: UIDatePicker) {
        if !editingWorkDay {
            self.workDay.date = sender.date
            dateTextField.text = getDateOnlyString(self.workDay.date, myDateFormat: "EEE MMMM dd, yyyy")
        }
    }
    
    func addTextFieldsAccessoryView() {
        
        let fixedSpaceButton = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        
        let downButton = UIBarButtonItem(image: UIImage(named: "down-arrow-icon"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.downKeyBoard))
        
        let upButton = UIBarButtonItem(image: UIImage(named: "up-arrow-icon"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.upKeyBoard))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneKeyBoard))
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.setItems([fixedSpaceButton, upButton, fixedSpaceButton, downButton, flexibleSpace, doneButton], animated: true)
        
        locationTextField.inputAccessoryView = toolBar
        hoursTextField.inputAccessoryView = toolBar
        patientsTextField.inputAccessoryView = toolBar
        patientsWithPaTextField.inputAccessoryView = toolBar
        
        self.addDateTextFieldToolBar()
        self.addNotesTextViewToolBar()
    }
    
    func addDateTextFieldToolBar() {
        
        let fixedSpaceButton = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        
        let disabledDownButton = UIBarButtonItem(image: UIImage(named: "down-arrow-icon"), style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        disabledDownButton.isEnabled = false
        
        let upButton = UIBarButtonItem(image: UIImage(named: "up-arrow-icon"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.upKeyBoard))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneKeyBoard))
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.setItems([fixedSpaceButton, upButton, fixedSpaceButton, disabledDownButton, flexibleSpace, doneButton], animated: true)
        notesTextView.inputAccessoryView = toolBar
    }
    
    func addNotesTextViewToolBar() {
        
        let fixedSpaceButton = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        
        let downButton = UIBarButtonItem(image: UIImage(named: "down-arrow-icon"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.downKeyBoard))
        
        let disabledUpButton = UIBarButtonItem(image: UIImage(named: "up-arrow-icon"), style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        disabledUpButton.isEnabled = false
        
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneKeyBoard))
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.setItems([fixedSpaceButton, disabledUpButton, fixedSpaceButton, downButton, flexibleSpace, doneButton], animated: true)
        dateTextField.inputAccessoryView = toolBar
    }
    
    func upKeyBoard() {
        if notesTextView.isFirstResponder {
            patientsWithPaTextField.becomeFirstResponder()
        }
        else if patientsWithPaTextField.isFirstResponder {
            patientsTextField.becomeFirstResponder()
        }
        else if patientsTextField.isFirstResponder {
            hoursTextField.becomeFirstResponder()
        }
        else if hoursTextField.isFirstResponder {
            locationTextField.becomeFirstResponder()
        }
        else if locationTextField.isFirstResponder {
            dateTextField.becomeFirstResponder()
        }
    }
    
    func downKeyBoard() {
        if dateTextField.isFirstResponder {
            locationTextField.becomeFirstResponder()
        }
        else if locationTextField.isFirstResponder {
            hoursTextField.becomeFirstResponder()
        }
        else if hoursTextField.isFirstResponder {
            patientsTextField.becomeFirstResponder()
        }
        else if patientsTextField.isFirstResponder {
            patientsWithPaTextField.becomeFirstResponder()
        }
        else if patientsWithPaTextField.isFirstResponder {
            notesTextView.becomeFirstResponder()
        }
    }
    
    func doneKeyBoard() {
        view.endEditing(true)
    }
}
