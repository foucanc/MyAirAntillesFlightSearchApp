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

class Conversion {
    
    static func Currency(price: String) -> String {
        var str = ""
        if (price.contains("EUR")) {
            str = price.replacingOccurrences(of: "EUR", with: "") + " €"
        }
        if (price.contains("USD")) {
            str = price.replacingOccurrences(of: "USD", with: "") + " $"
        }
        return str
    }

}

class AirportUtil {
    
    static func getAirportCode(airport: String) -> String {
        var a = ""
        if (airport != Default.arrival_text.rawValue) {
            let arrival = airport.substring(from:airport.index(airport.endIndex, offsetBy: -3))
            a = arrival
        }
        else {
            a = ""
        }
        return a
    }
}
