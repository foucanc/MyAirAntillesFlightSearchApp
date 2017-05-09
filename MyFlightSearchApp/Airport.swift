//
//  Airport.swift
//  MyFlightSearchApp
//
//  Created by Christophe Foucan on 23/04/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import UIKit
import RealmSwift

class Airport: Object {
    dynamic var code = ""
    dynamic var city = ""
    dynamic var name = ""
}
