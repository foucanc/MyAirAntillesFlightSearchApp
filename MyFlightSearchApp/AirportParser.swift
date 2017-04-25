//
//  AirportParser.swift
//  MyFlightSearchApp
//
//  Created by Christophe Foucan on 23/04/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import Foundation
import SwiftyJSON

class AirportParser: NSObject {

    static var shared = AirportParser()
    
    func parseObjects(jsonDic: JSON) -> [NSObject] {
        var infos = [Airport]()
        for index in jsonDic["trips"]["data"]["airport"] {
            //print(index.1)
            let airport = self.airportObj(dic: index.1)
            infos.append(airport)
        }
        //print(infos)
        return infos
    }
    
    func airportObj(dic: JSON) -> Airport {
        let airport = Airport()
        
        airport.city = dic["city"].stringValue
        airport.name = dic["name"].stringValue
        airport.code = dic["code"].stringValue
        
        return airport
    }
}
