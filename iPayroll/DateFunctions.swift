//
//  DateFunctions.swift
//  iPayroll
//
//  Created by Joel Pineiro on 3/19/17.
//  Copyright © 2017 Joel Pineiro. All rights reserved.
//

import Foundation

func toDateFromString(_ myDateString : String, myDateFormat : String ) -> Date {
    
    let myDateFormatter = DateFormatter()
    myDateFormatter.dateFormat = myDateFormat
    let date = myDateFormatter.date(from: myDateString)
    
    return date!
}

func getDateOnlyString(_ date: Date,  myDateFormat : String) -> String{
    
    let myDateFormatter = DateFormatter()
    myDateFormatter.dateFormat = myDateFormat  //adjust to your specific date format
    //myDateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
    //Short style would print 77 instead of 1977
    return myDateFormatter.string(from: date);
    
    
}

func isLeapYear(_ year: Int) -> Bool {
    return (( year%100 != 0) && (year%4 == 0)) || year%400 == 0
}

func daysInMonth(_ year: Int, month: Int) -> Int {
    if month == 2 {
        if isLeapYear(year) {
            return 29
        }
        return 28
    }
    else if month == 4 || month == 6 || month == 9 || month == 11 {
        return 30
    }
    else {
        return 31
    }
}

func monthNumberToString(_ month: Int) -> String {
    let dateFormatter: DateFormatter = DateFormatter()
    let months = dateFormatter.monthSymbols
    let monthSymbol = months?[month-1]
    return monthSymbol!
}

func dayNumberToString(_ day: Int) -> String {
    var dayStr = String()
    
    switch day {
    case 1:
        dayStr = "Sunday"
    case 2:
        dayStr = "Monday"
    case 3:
        dayStr = "Tuesday"
    case 4:
        dayStr = "Wednesday"
    case 5:
        dayStr = "Thursday"
    case 6:
        dayStr = "Friday"
    case 7:
        dayStr = "Saturday"
    default:
        break
        
    }
    return dayStr
}

func monthNumberToString(month: Int) throws -> String {
    var monthStr = ""
    
    switch month {
    case 1:
        monthStr = "January"
    case 2:
        monthStr = "February"
    case 3:
        monthStr = "March"
    case 4:
        monthStr = "April"
    case 5:
        monthStr = "May"
    case 6:
        monthStr = "June"
    case 7:
        monthStr = "July"
    case 8:
        monthStr = "August"
    case 9:
        monthStr = "September"
    case 10:
        monthStr = "October"
    case 11:
        monthStr = "November"
    case 12:
        monthStr = "December"
    default:
        break
        
    }
    
    if monthStr == "" {
        throw NSException(name: NSExceptionName.invalidArgumentException,
                          reason: "month should be between 1 and 12",
                          userInfo: nil) as! Error
    }
    
    return monthStr
}
