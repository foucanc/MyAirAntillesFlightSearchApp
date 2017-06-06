//
//  NetworkHelper.swift
//  MyFlightSearchApp
//
//  Created by Christophe Foucan on 06/06/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import Alamofire

class NetworkHelper: NSObject {
    
    static var shared = NetworkHelper()
    
    func performRequest(requestProvider: RequestProvider, completion: @escaping (_ data: Data?) -> Void) {
        
        Alamofire.request(requestProvider.request)
            .responseJSON { response in
                //print(parameters)
                //print(response.data!)
                //print(response.request)
                if response.data != nil {
                    let data: Data = response.data!

                    completion(data)
                }
                else {
                    print("Failed to load: \(String(describing: response.error?.localizedDescription))")
                    completion(nil)
                }
        }
    }

}
