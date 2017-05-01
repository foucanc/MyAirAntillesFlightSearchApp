//
//  AirportSearchViewCell.swift
//  MyFlightSearchApp
//
//  Created by Christophe Foucan on 01/05/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import UIKit

class AirportSearchViewCell: UITableViewCell {
    
    @IBOutlet weak var airportLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
