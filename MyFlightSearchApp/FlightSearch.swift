//
//  FlightSearch.swift
//  MyFlightSearchApp
//
//  Created by Christophe Foucan on 06/06/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import UIKit
import RealmSwift

class FlightSearch: Object {
    dynamic var origin = ""
    dynamic var destination = ""
    dynamic var adult = ""
    dynamic var child = ""
    dynamic var baby = ""
    dynamic var departureDate = ""
    dynamic var arrivalDate = ""
    
}
