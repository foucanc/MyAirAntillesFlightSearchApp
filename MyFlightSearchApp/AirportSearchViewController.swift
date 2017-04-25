//
//  AirportSearchViewController.swift
//  MyFlightSearchApp
//
//  Created by Christophe Foucan on 24/04/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import UIKit

protocol AirportSearchViewControllerProtocol{
    func close(_ controller: UIViewController)
}

class AirportSearchViewController: UIViewController {
    
    var delegate: AirportSearchViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func close(_ sender: UIBarButtonItem) {
        self.delegate?.close(self)
    }
}
