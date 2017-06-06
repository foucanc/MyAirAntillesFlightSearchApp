//
//  FlightSearchViewController.swift
//  MyFlightSearchApp
//
//  Created by Christophe Foucan on 18/04/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import UIKit

class FlightSearchViewController: UIViewController {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var flightSearchTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var viewModel = FlightSearchViewModel()
    var mainViewModel = MainViewModel()
    
    var origin: String = ""
    var destination: String = ""
    var adult: String = ""
    var child: String = ""
    var baby: String = ""
    var date: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.backgroundColor = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0)
        flightSearchTableView.backgroundColor = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0)

        initialize()

        viewModel.getTrips() {updated in
            if(updated) {
                
                self.flightSearchTableView.reloadData()
                self.activityIndicatorView.stopAnimating()
                self.activityIndicatorView.isHidden = true
                if(self.viewModel.tripArray.count == 0) {
                    self.messageLabel.text = "Aucun vol trouvé."
                }
            }
            else {
                print("error")
                self.activityIndicatorView.stopAnimating()
                self.activityIndicatorView.isHidden = true
                self.messageLabel.text = "Erreur."
                
            }
        }

        flightSearchTableView.delegate = self
        flightSearchTableView.dataSource = self
        flightSearchTableView.register(UINib(nibName: "FlightSearchCell", bundle: nil), forCellReuseIdentifier: "flightSearchCell")
        flightSearchTableView.separatorStyle = .none
    }
    
    override func viewDidAppear(_ animated: Bool) {
        activityIndicatorView.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initialize() {
        viewModel.origin = origin
        viewModel.destination = destination
        viewModel.adult = adult
        viewModel.child = child
        viewModel.baby = baby
        viewModel.date = date
        
    }

}

extension FlightSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfTrips()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.viewModel.cellForRow(tableView: tableView, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
//    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }

}
