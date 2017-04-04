//
//  WorkMonth.swift
//  iPayroll
//
//  Created by Joel Pineiro on 3/23/17.
//  Copyright © 2017 Joel Pineiro. All rights reserved.
//

import Foundation

class WorkMonth: NSObject {
    
    var month: String!
    var days: [WorkDay]!
    
    init(month: String) {
        self.month = month
        self.days = [WorkDay]()
        super.init()
    }
    
    init(month: String, days: [WorkDay]) {
        self.month = month
        self.days = days
        super.init()
    }
    
    func addWorkDay(day: WorkDay) {
        self.days.append(day)
    }
    
}
