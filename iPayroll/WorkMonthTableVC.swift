//
//  WorkMonthDetailsTableViewCell.swift
//  iPayroll
//
//  Created by Joel Pineiro on 3/29/17.
//  Copyright © 2017 Joel Pineiro. All rights reserved.
//

import UIKit

class WorkMonthTableViewController: UITableViewController {
    
    var workMonth: WorkMonth!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workMonth.days.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkDayCell", for: indexPath) as! DayTableViewCell
        
        if workMonth.days.count == 0 {
            return cell
        }
        
        cell.title.text = getDateOnlyString(workMonth.days[indexPath.row].date, myDateFormat: "EEE MMM dd, yyyy")
        return cell
    }

}
