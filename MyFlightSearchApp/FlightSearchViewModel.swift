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
    var date: String = ""
    
    var tag: Int = 0
    
    func getTrips(completion: @escaping (Bool) -> Void) {
        
        let flightsearch = FlightSearch()
        
        flightsearch.origin = origin
        flightsearch.destination = destination
        flightsearch.adult = adult
        flightsearch.child = child
        flightsearch.baby = baby
        flightsearch.departureDate = date
        
        NetworkHelper.shared.performRequest(requestProvider: RequestFlightSearch(flightsearch: flightsearch)) { (data) in
            if let data = data {
                let json = JSON(data: data)

                let datas = TripParser.shared.parseObjects(jsonDic: json) as! [Trip]
                let airports = AirportParser.shared.parseObjects(jsonDic: json) as! [Airport]

                let companyArray = datas.filter(){$0.segments[0].company == Default.air_antilles.rawValue}
                let companyArrayFiltered = companyArray.filter(){$0.segments.last?.destination == self.destination}
                print(companyArrayFiltered)
                for data in companyArrayFiltered {
                    self.tripArray.append(data)
                }
                for airport in airports {
                    self.airportArray.append(airport)
                }
                completion(true)
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
            cell.departureHourLabel.text = DateUtil.hourToString(date: departureTimeStr!)
            cell.arrivalHourLabel.text = DateUtil.hourToString(date: arrivalTimeStr!)
            
            cell.backgroundColor = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0)
            cell.tripView.backgroundColor = UIColor.white
            cell.salePriceView.backgroundColor = UIColor.white
            cell.salePriceLabel.textColor = Color.MYAPPCOLOR
        }
        return cell
    }
    
    func numberOfTrips() -> Int {
        return tripArray.count
    }

}
