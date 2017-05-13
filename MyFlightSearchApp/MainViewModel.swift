//
//  MainViewModel.swift
//  MyFlightSearchApp
//
//  Created by Christophe Foucan on 18/04/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RxCocoa
import RxSwift

class MainViewModel {
    
    var currencyArray = [Currency]()
    var adultNumber = Variable<Int>(0)
    var childNumber = Variable<Int>(0)
    var babyNumber = Variable<Int>(0)
    
    func getCurrencySymbol() {
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "currencies", ofType: "json")!)
        let data = try! Data(contentsOf: url)
        let json = JSON(data: data)
        let currencies = CurrencyParser.shared.parseObjects(jsonDic: json) as! [Currency]
        CurrencyService.shared.updateServiceMessage(currencyObject: currencies) { (update, error) in }
        for index in currencies {
            currencyArray.append(index)
        }
        
    }
    
    func addAdultNumber() {
        if (adultNumber.value < 9){
            adultNumber.value = adultNumber.value + 1
        }
    }
    
    func addChildNumber() {
        if (childNumber.value < 9){
            childNumber.value = childNumber.value + 1
        }
    }
    
    func addBabyNumber() {
        if (babyNumber.value < 9){
            babyNumber.value = babyNumber.value + 1
        }
    }
    
    func removeAdultNumber() {
        if (adultNumber.value > 0){
            adultNumber.value = adultNumber.value - 1
        }
    }
    
    func removeChildNumber() {
        if (childNumber.value > 0){
            childNumber.value = childNumber.value - 1
        }
    }
    
    func removeBabyNumber() {
        if (babyNumber.value > 0){
            babyNumber.value = babyNumber.value - 1
        }
    }

}
