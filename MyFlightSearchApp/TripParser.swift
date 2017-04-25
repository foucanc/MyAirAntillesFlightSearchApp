//
//  TripParser.swift
//  MyFlightSearchApp
//
//  Created by Christophe Foucan on 18/04/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import Foundation
import SwiftyJSON

struct TripParser: Parser {
    
    static var shared = TripParser()
    
    func parseObjects(jsonDic: JSON) -> [NSObject] {
        var infos = [Trip]()
        for index in jsonDic["trips"]["tripOption"] {
            let trip = self.tripObj(dic: index.1)
            infos.append(trip)
        }
        return infos
    }
    
    func tripObj(dic: JSON) -> Trip {
        let trip = Trip()
        trip.salePrice = dic["saleTotal"].stringValue
        
        for index in dic["slice"][0]["segment"] {
            let segment = Segment()
            segment.departureTime = index.1["leg"][0]["departureTime"].stringValue
            segment.arrivalTime = index.1["leg"][0]["arrivalTime"].stringValue
            segment.origin = index.1["leg"][0]["origin"].stringValue
            segment.destination = index.1["leg"][0]["destination"].stringValue
            segment.company = index.1["flight"]["carrier"].stringValue
            
            trip.segments.append(segment)
        }
        return trip
    }
    
}
