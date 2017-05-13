//
//  FlightSearchViewModel.swift
//  MyFlightSearchApp
//
//  Created by Christophe Foucan on 18/04/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import Alamofire
import SwiftyJSON

class FlightSearchViewModel {
    
    var tripArray = [Trip]()
    var airportArray = [Airport]()
    var currencyArray = [Currency]()
    
    var origin: String = ""
    var destination: String = ""
    var adult: String = ""
    var child: String = ""
    var baby: String = ""
    
    func getTrips(completion: @escaping (Bool) -> Void) {
        
        let url = URL_API + API_KEY
        
        let parameters: Parameters = [
            //"key": API_KEY,
            "request": [
                "slice": [
                    [
                        "origin": origin,
                        "destination": destination,
                        "date": "2017-05-21"
                    ]
                ],
                "passengers": [
                    "adultCount": adult,
                    "infantInLapCount": baby,
                    "infantInSeatCount": 0,
                    "childCount": child,
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
                    print(json)
                    let datas = TripParser.shared.parseObjects(jsonDic: json) as! [Trip]
                    let airports = AirportParser.shared.parseObjects(jsonDic: json) as! [Airport]
                    
                    let companyArray = datas.filter(){$0.segments[0].company == Default.air_antilles.rawValue}
                    let companyArrayFiltered = companyArray.filter(){$0.segments.last?.destination == self.destination}
                    for data in companyArrayFiltered {
                        self.tripArray.append(data)
                    }
                    //print(self.tripArray)
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
            
            //Saleprice
            currencyArray.removeAll()
            for index in CurrencyService.shared.currency {
                currencyArray.append(index)
            }
            let currency = currencyArray.filter(){$0.code == Conversion.getSymbol(price: self.tripArray[indexPath.row].salePrice)}.first?.symbol
            
            cell.salePriceLabel.text = Conversion.getSalePrice(price: self.tripArray[indexPath.row].salePrice, currency: currency!)
            
            if((cell.salePriceLabel.text?.characters.count)! > 8) {
                cell.salePriceLabel.font = cell.salePriceLabel.font.withSize(23)
            }
            cell.departureAirportCodeLabel.text = tripArray[indexPath.row].segments.first?.origin
            cell.arrivalAirportCodeLabel.text = tripArray[indexPath.row].segments.last?.destination
            cell.departureAirportLabel.text = airportArray.filter(){$0.code == tripArray[indexPath.row].segments.first?.origin}.first?.name
            cell.arrivalAirportLabel.text = airportArray.filter(){$0.code == tripArray[indexPath.row].segments.last?.destination}.first?.name

            let departureTimeStr = tripArray[indexPath.row].segments.first?.departureTime
            let arrivalTimeStr = tripArray[indexPath.row].segments.last?.arrivalTime
            cell.departureHourLabel.text = DateHourUtil.hourToString(date: departureTimeStr!)
            cell.arrivalHourLabel.text = DateHourUtil.hourToString(date: arrivalTimeStr!)
            
            cell.backgroundColor = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0)
            cell.tripView.backgroundColor = UIColor.white
            cell.salePriceView.backgroundColor = UIColor.white
            cell.salePriceLabel.textColor = UIColor(red: 78/255.0, green: 205/255.0, blue: 196/255.0, alpha: 1.0)
        }
        return cell
    }
    
    func numberOfTrips() -> Int {
        return tripArray.count
    }

}
