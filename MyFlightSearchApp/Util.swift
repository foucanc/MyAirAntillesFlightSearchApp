//
//  Util.swift
//  MyFlightSearchApp
//
//  Created by Christophe Foucan on 24/04/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import Foundation

class DateHourUtil {
    
    static func hourToString(date: String) -> String {
        let index = date.index(date.startIndex, offsetBy: 16)
        let tmp = date.substring(to: index)
        let index2 = tmp.index((tmp.startIndex), offsetBy: 11)
        let str = tmp.substring(from: index2)
        return str
    }
}
