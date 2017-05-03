//
//  MainViewController.swift
//  MyFlightSearchApp
//
//  Created by Christophe Foucan on 18/04/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import UIKit
import Foundation
import RxCocoa
import RxSwift

class MainViewController: UIViewController {

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var departureAirportLabel: UILabel!
    @IBOutlet weak var arrivalAirportLabel: UILabel!
    @IBOutlet weak var departureAirportDeleteButton: UIButton!

    var viewModel = MainViewModel()
    
    class func mainViewController() -> MainViewController
    {
        let ctrl:MainViewController = MainViewController.init(nibName: "MainView", bundle:nil)
        return ctrl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.searchView.backgroundColor = UIColor(red: 78/255.0, green: 205/255.0, blue: 196/255.0, alpha: 1.0)
        self.searchButton.tintColor = UIColor.white
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchTrips(_ sender: Any) {
        let flightSearchVC = FlightSearchViewController(nibName: "FlightSearchView", bundle: nil)
        self.navigationController?.pushViewController(flightSearchVC, animated: true)
    }
    
    @IBAction func searchDepartureAirport(_ sender: Any) {
        searchAirport(index: 0)
    }
    
    @IBAction func searchArrivalAirport(_ sender: Any) {
        searchAirport(index: 1)
    }
    
    @IBAction func deleteDepartureAirport(_ sender: Any) {
        setEntry(text: "aéroport de départ", index: 2)
    }

    @IBAction func deleteArrivalAirport(_ sender: Any) {
        setEntry(text: "aéroport d'arrivée", index: 3)
    }

    func setEntry(text: String, index: Int) {
        switch index {
        case 0:
            departureAirportLabel.textColor = UIColor.black
            departureAirportLabel.text = text
            break
        case 1:
            arrivalAirportLabel.textColor = UIColor.black
            arrivalAirportLabel.text = text
            break
        case 2:
            departureAirportLabel.textColor = UIColor.lightGray
            departureAirportLabel.text = text
            break
        case 3:
            arrivalAirportLabel.textColor = UIColor.lightGray
            arrivalAirportLabel.text = "aéroport d'arrivée"
            break
        default:
            break
        }
    }
    
    func searchAirport(index: Int) {
        let airportSearchVC = AirportSearchViewController(nibName: "AirportSearchView", bundle: Bundle.main)
        airportSearchVC.delegate = self
        airportSearchVC.tag = index
        self.present(airportSearchVC, animated: true,completion: nil)
    }

}

extension MainViewController: AirportSearchViewControllerProtocol {
    func close(_ controller: UIViewController,airport: String, index: Int) {
        controller.dismiss(animated: true, completion: nil)
        setEntry(text: airport, index: index)
    }
}
