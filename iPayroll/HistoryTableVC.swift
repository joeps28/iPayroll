//
//  HistoryTableViewController.swift
//  iPayroll
//
//  Created by Joel Pineiro on 1/21/17.
//  Copyright © 2017 Joel Pineiro. All rights reserved.
//

import UIKit
import CloudKit

class HistoryTableViewController: UITableViewController {
    
    var workDays = [CKRecord]()
    var refresh: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Pull to load work days")
        refresh.addTarget(self, action: #selector(HistoryTableViewController.loadData), for: .valueChanged)
        self.tableView.addSubview(refresh)
        
        loadData()
    }
    
    func loadData () {
        workDays = [CKRecord]()
        
        let privateData = CKContainer.default().privateCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "WorkDay", predicate: predicate)
        
        privateData.perform(query, inZoneWith: nil, completionHandler: ({ results, error in
            if let workDays = results {
                self.workDays = workDays
                DispatchQueue.main.async(execute: { () -> Void in
                    self.tableView.reloadData()
                    self.refresh.endRefreshing()
                })
            }
        }))
    }
        
    
    @IBAction func addWorkDay(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Work Day", message: "Enter a message", preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) -> Void in
            textField.placeholder = "Your message"
        }
        
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action:UIAlertAction) -> Void in
            let textField = alert.textFields!.first!
            
            if textField.text != "" {
                let newWorkDay = CKRecord(recordType: "WorkDay")
                newWorkDay["content"] = textField.text as CKRecordValue?
                
                let privateData = CKContainer.default().privateCloudDatabase
                
                privateData.save(newWorkDay, completionHandler: { record, error in
                    if error != nil {
                        
                        print(error!)
                        
                    } else {
                        DispatchQueue.main.async(execute: { () -> Void in
                            self.tableView.beginUpdates()
                            self.workDays.insert(newWorkDay, at: 0)
                            let indexPath = IndexPath(row: 0, section: 0)
                            self.tableView.insertRows(at: [indexPath], with: .top)
                            self.tableView.endUpdates()
                        })
                    }
                })
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)

    }
    
    @IBAction func dismissHistoryVC(_ sender: UIBarButtonItem) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.dismiss(animated: true, completion: nil)
            
        }, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workDays.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        if workDays.count == 0 {
            return cell
        }
        
        let workDay = workDays[indexPath.row]
        
        if let workDayContent = workDay["content"] as? String {
            cell.textLabel?.text = workDayContent
        }

        return cell
    }
}
