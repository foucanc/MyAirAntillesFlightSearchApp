//
//  Request.swift
//  MyFlightSearchApp
//
//  Created by Christophe Foucan on 06/06/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import UIKit
import Alamofire

class RequestProvider: NSObject {
    
    var request: URLRequest!
    
    init(pathURL: String, requestHttpType: String, parameters: Parameters) {
        super.init()
        
        let urlStr = pathURL

        let url = URL(string: urlStr)!
        self.request = URLRequest(url: url)
        self.request.httpMethod = requestHttpType
        if(self.isKind(of: RequestFlightSearch.self)) {
            self.request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
            self.request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}

class RequestFlightSearch: RequestProvider {
    init(flightsearch: FlightSearch) {
        let pathURL = URL_API + API_KEY

        let parameters: Parameters = [
            "request": [
                "slice": [
                    [
                        "origin": flightsearch.origin,
                        "destination": flightsearch.destination,
                        "date": flightsearch.departureDate
                    ]
                ],
                "passengers": [
                    "adultCount": flightsearch.adult,
                    "infantInLapCount": 0,
                    "infantInSeatCount": 0,
                    "childCount": 0,
                    "seniorCount": 0
                ],
                "solutions": 100,
                "refundable": false
            ]
        ]
        
        super.init(pathURL: pathURL, requestHttpType: "POST", parameters: parameters)
    }
}
