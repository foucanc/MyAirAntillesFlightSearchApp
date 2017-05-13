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

    @IBOutlet weak var adultPlusButton: UIButton!
    @IBOutlet weak var adultMinusButton: UIButton!
    @IBOutlet weak var childPlusButton: UIButton!
    @IBOutlet weak var childMinusButton: UIButton!
    @IBOutlet weak var babyPlusButton: UIButton!
    @IBOutlet weak var babyMinusButton: UIButton!
    
    @IBOutlet weak var adultNumberLabel: UILabel!
    @IBOutlet weak var childNumberLabel: UILabel!
    @IBOutlet weak var babyNumberLabel: UILabel!
    
    var viewModel = MainViewModel()
    var disposeBag = DisposeBag()
    
    class func mainViewController() -> MainViewController
    {
        let ctrl:MainViewController = MainViewController.init(nibName: "MainView", bundle:nil)
        return ctrl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Rechercher un vol"

        let backButton = UIBarButtonItem(
            title: "Retour",
            style: UIBarButtonItemStyle.plain,
            target: nil,
            action: nil
        )
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        // Do any additional setup after loading the view.
        self.searchView.backgroundColor = UIColor(red: 78/255.0, green: 205/255.0, blue: 196/255.0, alpha: 1.0)
        
        self.viewModel.adultNumber
            .asObservable()
            .map { "\($0)"}
            .bind(to: self.adultNumberLabel.rx.text)
            .addDisposableTo(self.disposeBag)
        
        self.viewModel.childNumber
            .asObservable()
            .map { "\($0)"}
            .bind(to: self.childNumberLabel.rx.text)
            .addDisposableTo(self.disposeBag)
        
        self.viewModel.babyNumber
            .asObservable()
            .map { "\($0)"}
            .bind(to: self.babyNumberLabel.rx.text)
            .addDisposableTo(self.disposeBag)
        
        initialize()
        
    }
    
    func initialize() {
        enableButton(entryNumber: self.viewModel.adultNumber.value, minusButton: self.adultMinusButton, plusButton: self.adultPlusButton)
        enableButton(entryNumber: self.viewModel.childNumber.value, minusButton: self.childMinusButton, plusButton: self.childPlusButton)
        enableButton(entryNumber: self.viewModel.babyNumber.value, minusButton: self.babyMinusButton, plusButton: self.babyPlusButton)
        
        self.viewModel.getCurrencySymbol()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchAirport(index: Int) {
        let airportSearchVC = AirportSearchViewController(nibName: "AirportSearchView", bundle: Bundle.main)
        airportSearchVC.delegate = self
        airportSearchVC.tag = index
        self.present(airportSearchVC, animated: true,completion: nil)
    }
    
    @IBAction func searchTrips(_ sender: Any) {
        let flightSearchVC = FlightSearchViewController(nibName: "FlightSearchView", bundle: nil)
    
        flightSearchVC.origin = AirportUtil.getAirportCode(airport: departureAirportLabel.text!)
        flightSearchVC.destination = AirportUtil.getAirportCode(airport: arrivalAirportLabel.text!)
        flightSearchVC.adult = String(self.viewModel.adultNumber.value)
        flightSearchVC.child = String(self.viewModel.childNumber.value)
        flightSearchVC.baby = String(self.viewModel.babyNumber.value)

        self.navigationController?.pushViewController(flightSearchVC, animated: true)
    }
    
    @IBAction func searchDepartureAirport(_ sender: Any) {
        searchAirport(index: 0)
    }
    
    @IBAction func searchArrivalAirport(_ sender: Any) {
        searchAirport(index: 1)
    }
    
    @IBAction func deleteDepartureAirport(_ sender: Any) {
        setEntry(text: Default.departure_text.rawValue, index: 2)
    }

    @IBAction func deleteArrivalAirport(_ sender: Any) {
        setEntry(text: Default.arrival_text.rawValue, index: 3)
    }
    
    @IBAction func addAdult(_ sender: Any) {
        self.viewModel.addAdultNumber()
        enableButton(entryNumber: self.viewModel.adultNumber.value, minusButton: self.adultMinusButton, plusButton: self.adultPlusButton)
    }
    
    @IBAction func removeAdult(_ sender: Any) {
        self.viewModel.removeAdultNumber()
        enableButton(entryNumber: self.viewModel.adultNumber.value, minusButton: self.adultMinusButton, plusButton: self.adultPlusButton)
    }
    
    @IBAction func addChild(_ sender: Any) {
        self.viewModel.addChildNumber()
        enableButton(entryNumber: self.viewModel.childNumber.value, minusButton: self.childMinusButton, plusButton: self.childPlusButton)
    }
    
    @IBAction func removeChild(_ sender: Any) {
        self.viewModel.removeChildNumber()
        enableButton(entryNumber: self.viewModel.childNumber.value, minusButton: self.childMinusButton, plusButton: self.childPlusButton)
    }

    @IBAction func addBaby(_ sender: Any) {
        self.viewModel.addBabyNumber()
        enableButton(entryNumber: self.viewModel.babyNumber.value, minusButton: self.babyMinusButton, plusButton: self.babyPlusButton)
    }

    @IBAction func removeBaby(_ sender: Any) {
        self.viewModel.removeBabyNumber()
        enableButton(entryNumber: self.viewModel.babyNumber.value, minusButton: self.babyMinusButton, plusButton: self.babyPlusButton)
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
        default:
            break
        }
    }
    
    func enableButton(entryNumber: Int, minusButton: UIButton, plusButton: UIButton) {
        switch entryNumber {
        case 0:
            minusButton.isEnabled = false
        case 9:
            plusButton.isEnabled = false
        default:
            plusButton.isEnabled = true
            minusButton.isEnabled = true
        }
    }

}

extension MainViewController: AirportSearchViewControllerProtocol {
    func close(_ controller: UIViewController,airport: String, index: Int) {
        if(airport != "") {
            setEntry(text: airport, index: index)
        }
        controller.dismiss(animated: true, completion: nil)
    }
}
