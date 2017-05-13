//
//  CurrencyService.swift
//  MyFlightSearchApp
//
//  Created by Christophe Foucan on 13/05/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import RealmSwift
import Bond

class CurrencyService: NSObject {
    
    static var shared = CurrencyService()

    var currency: Results<Currency>!

    override init() {
        super.init()
        let realm = try! Realm()
        self.currency = realm.objects(Currency.self)

    }
    
    func updateServiceMessage(currencyObject: [Currency], completion: (Bool, Error?) -> Void) {
        do {
            
            let realm = try Realm()
            
            realm.beginWrite()
            realm.delete(realm.objects(Currency.self))
            realm.add(currencyObject)
            
            try realm.commitWrite()
            
            completion(true, nil)
        }
        catch {
            completion(false, error)
        }
        
    }
    
}
