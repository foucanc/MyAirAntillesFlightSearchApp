//
//  AirportSearchViewController.swift
//  MyFlightSearchApp
//
//  Created by Christophe Foucan on 24/04/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SwiftyJSON

protocol AirportSearchViewControllerProtocol{
    func close(_ controller: UIViewController, airport : String, index: Int)
}

class AirportSearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var delegate: AirportSearchViewControllerProtocol?
    
    var shownAirports = [String]()
    var airportsList = [String]()
    var tag = Int()
    
    let disposeBag = DisposeBag() // Bag of disposables to release them when view is being deall
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initList()
   
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AirportSearchViewCell", bundle: nil), forCellReuseIdentifier: "airportSearchViewCell")

        searchBar
            .rx.text // Observable property thanks to RxCocoa
            .orEmpty // Make it non-optional
            .subscribe(onNext: { [unowned self] query in // Here we will be notified of every new value
                if(query != "") {
                    self.shownAirports = self.airportsList.filter { $0.capitalized.contains(query) }
                }
                else {
                    self.shownAirports = self.airportsList
                }
                self.tableView.reloadData() // And reload table view data.
            })
            .addDisposableTo(disposeBag)
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initList() {
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "airports", ofType: "json")!)
        let data = try! Data(contentsOf: url)
        let json = JSON(data: data)
        
        for index in json {
            airportsList.append(index.1.stringValue)
        }
    }

    @IBAction func close(_ sender: UIBarButtonItem) {
        self.delegate?.close(self, airport: "", index: tag)
    }
}

extension AirportSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownAirports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "airportSearchViewCell", for: indexPath) as! AirportSearchViewCell
        cell.airportLabel.text = shownAirports[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as? AirportSearchViewCell
        self.delegate?.close(self, airport: (selectedCell?.airportLabel.text)!, index: tag)
    }
 
}
