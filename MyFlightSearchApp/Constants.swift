//
//  Constants.swift
//  MyFlightSearchApp
//
//  Created by Christophe Foucan on 25/04/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import Foundation

let URL_API = "https://www.googleapis.com/qpxExpress/v1/trips/search?key="
let API_KEY = "YOUR_API_KEY"

enum Default : String {
    case departure_text = "aéroport de départ"
    case arrival_text = "aéroport d'arrivée"
    case departureDate_text = "Date de départ"
    case arrivalDate_text = "Date de retour"
    case air_antilles = "3S"
}
