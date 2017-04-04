//
//  WorkDay.swift
//  iPayroll
//
//  Created by Joel Pineiro on 3/19/17.
//  Copyright © 2017 Joel Pineiro. All rights reserved.
//

import UIKit
import CloudKit

class WorkDay: NSObject {

    var date: Date = Date()
    var location: String = ""
    var hours: Float = 0.0
    var patients: Int = 0
    var patientsWithPa: Int = 0
    var holiday: Bool = false
    var notes: String = ""
    
    override init() {
        super.init()
    }
    
    init(record: CKRecord) {
        super.init()
        if let date = record["date"] as? Date { self.date = date }
        if let location = record["location"] as? String { self.location = location }
        if let hours = record["hours"] as? Float { self.hours = hours }
        if let patients = record["patients"] as? Int { self.patients = patients }
        if let patientsWithPa = record["patientsWithPa"] as? Int { self.patientsWithPa = patientsWithPa }
        if let holiday = record["holiday"] as? Bool { self.holiday = holiday }
        if let notes = record["notes"] as? String { self.notes = notes }
    }
}
