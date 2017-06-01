//
//  CalendarViewModel.swift
//  MyFlightSearchApp
//
//  Created by Christophe Foucan on 14/05/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import UIKit

class CalendarViewModel: NSObject {
    var selectedDateArray = [Date]()
    var error: String = ""
    
    func availableDate(selectedDate : [Date]) {
        let sort = selectedDate.sorted {
            $0 < $1
        }
        selectedDateArray = sort
    }
    
    func checkPeriod(selectedDate : [Date]) -> Bool {
        let calendar = Calendar.current
        let initDate: Date = NSDate(timeIntervalSince1970: 0) as Date
        var date: Date = initDate
        var test: Bool = true

        if(selectedDate.count == 0) {
            test = false
            error = "Veuillez selectionner une date"
        }
        for index in selectedDate {
            if((index != date)&&(date != initDate)){
                test = false
                error = "Veuillez saisir une seule periode"
            }
            date = calendar.date(byAdding: .day, value: 1, to: index)!
        }
        return test
    }  
}
