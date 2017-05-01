//
//  FlightSearchViewModel.swift
//  MyFlightSearchApp
//
//  Created by Christophe Foucan on 18/04/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import Alamofire
import SwiftyJSON

class FlightSearchViewModel: NSObject {
    
    var tripArray = [Trip]()
    var airportArray = [Airport]()
    
    func getTrips(completion: @escaping (Bool) -> Void) {
        
        let url = URL + API_KEY
        
        let parameters: Parameters = [
            //"key": API_KEY,
            "request": [
                "slice": [
                    [
                        "origin": "FDF",
                        "destination": "PTP",
                        "date": "2017-05-20"
                    ]
                ],
                "passengers": [
                    "adultCount": 1,
                    "infantInLapCount": 0,
                    "infantInSeatCount": 0,
                    "childCount": 0,
                    "seniorCount": 0
                ],
                "solutions": 100,
                "refundable": false
            ]
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                //print(response.data!)
                //print(response.request)
                if response.data != nil {
                    let data: Data = response.data!
                    let json = JSON(data: data)
                    let datas = TripParser.shared.parseObjects(jsonDic: json) as! [Trip]
                    let airports = AirportParser.shared.parseObjects(jsonDic: json) as! [Airport]
                    
                    let companyArray = datas.filter(){$0.segments[0].company == "3S"}
                    for data in companyArray {
                        self.tripArray.append(data)
                    }
                    for airport in airports {
                        self.airportArray.append(airport)
                    }
                    completion(true)
                }
                else {
                    print("Failed to load: \(String(describing: response.error?.localizedDescription))")
                    completion(false)
                }
        }
    }
    
    func cellForRow(tableView: UITableView, indexPath: IndexPath) -> FlightSearchCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flightSearchCell", for: indexPath) as! FlightSearchCell
        if(indexPath.row < tripArray.count){
            let imageName = "Airplane.png"
            let image = UIImage(named: imageName)
            cell.airplaneImageView.image = image
            cell.salePriceLabel.text = Conversion.eurCurrency(price: tripArray[indexPath.row].salePrice) 
                
            cell.departureAirportCodeLabel.text = tripArray[indexPath.row].segments.first?.origin
            cell.arrivalAirportCodeLabel.text = tripArray[indexPath.row].segments.first?.destination
            cell.departureAirportLabel.text = airportArray.filter(){$0.code == tripArray[indexPath.row].segments.first?.origin}.first?.name
            cell.arrivalAirportLabel.text = airportArray.filter(){$0.code == tripArray[indexPath.row].segments.first?.destination}.first?.name

            let departureTimeStr = tripArray[indexPath.row].segments.first?.departureTime
            let arrivalTimeStr = tripArray[indexPath.row].segments.first?.arrivalTime
            cell.departureHourLabel.text = DateHourUtil.hourToString(date: departureTimeStr!)
            cell.arrivalHourLabel.text = DateHourUtil.hourToString(date: arrivalTimeStr!)
            
            cell.tripView.backgroundColor = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0)
            cell.salePriceView.backgroundColor = UIColor(red: 78/255.0, green: 205/255.0, blue: 196/255.0, alpha: 1.0)

        }
        return cell
    }
    
    func numberOfTrips() -> Int {
        return tripArray.count
    }

}
