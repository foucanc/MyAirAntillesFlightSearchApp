//
//  Parser.swift
//  MyFlightSearchApp
//
//  Created by Christophe Foucan on 18/04/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import SwiftyJSON

protocol Parser {
    func parseObjects(jsonDic: JSON) -> [NSObject]
}
