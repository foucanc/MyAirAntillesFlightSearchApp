//
//  CurrencyParser.swift
//  MyFlightSearchApp
//
//  Created by Christophe Foucan on 13/05/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift


class CurrencyParser: NSObject {
    
    static var shared = CurrencyParser()
    
    func parseObjects(jsonDic: JSON) -> [Object] {
        var infos = [Currency]()
        for index in jsonDic {
            let currency = self.currencyObj(dic: index.1, code: index.0)
            infos.append(currency)
        }
        //print(infos)
        return infos
    }
    
    func currencyObj(dic: JSON, code: String) -> Currency {
        let currency = Currency()
        
        currency.code = code
        currency.symbol = dic["symbol"]["grapheme"].stringValue
        
        return currency
    }
}
