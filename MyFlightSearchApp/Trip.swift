//
//  Trip.swift
//  MyFlightSearchApp
//
//  Created by Christophe Foucan on 18/04/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import Foundation

class Trip: NSObject {
    var code = ""
    var id = ""
    var country = ""
    var salePrice = ""
    var segments = Array<Segment>()
}

class Segment: NSObject {
    var arrivalTime = ""
    var departureTime = ""
    var origin = ""
    var destination = ""
    var company = ""
}
