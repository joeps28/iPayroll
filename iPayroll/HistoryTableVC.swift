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
    
    var sortedData = [WorkYear]()
    var workDayRecords = [CKRecord]()
    var refresh: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresh.addTarget(self, action: #selector(HistoryTableViewController.loadData), for: .valueChanged)
        self.tableView.addSubview(refresh)
        
        loadData()
    }
    
    func loadData() {
        workDayRecords = [CKRecord]()
        
        let publicData = CKContainer.default().publicCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "WorkDay", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        publicData.perform(query, inZoneWith: nil, completionHandler: ({ results, error in
            if let records = results {
                self.workDayRecords = records
                DispatchQueue.main.async(execute: { () -> Void in
                    self.sortRecords()
                    self.tableView.reloadData()
                    self.refresh.endRefreshing()
                })
            }
        }))
    }
    
    func sortRecords() {
        sortedData = [WorkYear]()
        var map: [String:[WorkMonth]] = [:]
        var added = false
        
        for record in workDayRecords {
            let workday = WorkDay(record: record)
            if map.keys.contains(workday.date.year) {
                for month in map[workday.date.year]! {
                    if month.month == workday.date.monthLong {
                        month.addWorkDay(day: workday)
                        added = true
                        break
                    }
                }
                if !added {
                    map[workday.date.year]?.append(WorkMonth(month: workday.date.monthLong, days: [workday]))
                }
            }
            else {
                map[workday.date.year] = [WorkMonth(month: workday.date.monthLong, days: [workday])]
            }
            added = false
        }
        
        workDayRecords = [CKRecord]()
        
        for (key, value) in map {
            sortedData.append(WorkYear(year: key, months: value))
        }
    }
    
    @IBAction func dismissHistoryVC(_ sender: UIBarButtonItem) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.dismiss(animated: true, completion: nil)
            
        }, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sortedData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedData[section].months.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkMonthCell", for: indexPath) as! MonthTableViewCell

        if sortedData.count == 0 {
            return cell
        }
        let month = sortedData[indexPath.section].months[indexPath.row]
        
        cell.title.text = month.month
        cell.count.text = month.days.count.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sortedData[section].year
    }
    
    // MARK: - Table view data source
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWorkDays" {
            let indexPath: IndexPath = self.tableView.indexPathForSelectedRow!
            let selectedMonth: WorkMonth = sortedData[indexPath.section].months[indexPath.row]
            let controller = segue.destination as! WorkMonthTableViewController
            controller.title = selectedMonth.month
            controller.navigationItem.leftItemsSupplementBackButton = true
            controller.workMonth = selectedMonth
        }
    }
    
}















