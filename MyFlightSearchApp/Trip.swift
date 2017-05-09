//
//  Trip.swift
//  MyFlightSearchApp
//
//  Created by Christophe Foucan on 18/04/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import Foundation
import RealmSwift

class Trip: Object {
    dynamic var code = ""
    dynamic var id = ""
    dynamic var country = ""
    dynamic var salePrice = ""
    let segments = List<Segment>()
}

class Segment: Object {
    dynamic var arrivalTime = ""
    dynamic var departureTime = ""
    dynamic var origin = ""
    dynamic var destination = ""
    dynamic var company = ""
}
