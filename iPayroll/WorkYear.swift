//
//  WorkYear.swift
//  iPayroll
//
//  Created by Joel Pineiro on 3/27/17.
//  Copyright © 2017 Joel Pineiro. All rights reserved.
//

import Foundation

class WorkYear: NSObject {
    
    var year: String!
    var months: [WorkMonth]!
    
    init(year: String) {
        self.year = year
        self.months = [WorkMonth]()
        super.init()
    }
    
    init(year: String, months: [WorkMonth]) {
        self.year = year
        self.months = months
        super.init()
    }
    
    func addWorkMonth(month: WorkMonth) {
        self.months.append(month)
    }
    
}
