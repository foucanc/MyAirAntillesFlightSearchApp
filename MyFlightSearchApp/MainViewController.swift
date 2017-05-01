//
//  MainViewController.swift
//  MyFlightSearchApp
//
//  Created by Christophe Foucan on 18/04/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import UIKit
import Foundation

class MainViewController: UIViewController {

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var departureAirportLabel: UILabel!
    @IBOutlet weak var arrivalAirportLabel: UILabel!
    
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
        let airportSearchVC = AirportSearchViewController(nibName: "AirportSearchView", bundle: Bundle.main)
        airportSearchVC.delegate = self
        self.present(airportSearchVC, animated: true,completion: nil)
    }
    
    func setEntry() {
        
    }

}

extension MainViewController: AirportSearchViewControllerProtocol {
    func close(_ controller: UIViewController,airport: String) {
        controller.dismiss(animated: true, completion: nil)
        //print(airport)
        setEntry()
    }
}
