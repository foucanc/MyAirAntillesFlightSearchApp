//
//  Util.swift
//  MyFlightSearchApp
//
//  Created by Christophe Foucan on 24/04/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import Foundation

class DateUtil {
    
    static func hourToString(date: String) -> String {
        let index = date.index(date.startIndex, offsetBy: 16)
        let tmp = date.substring(to: index)
        let index2 = tmp.index((tmp.startIndex), offsetBy: 11)
        let str = tmp.substring(from: index2)
        return str
    }
}

class Conversion {
    
    static func getSymbol(price: String) -> String {
        var str = ""
        let index = price.index(price.startIndex, offsetBy: 3)
        str = price.substring(to: index)
        return str
    }
    
    static func getSalePrice(price: String, currency :String) -> String {
        var str = ""
        
        let index = price.index(price.startIndex, offsetBy: 3)
        str = price.substring(from: index) + " " + currency
        
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
