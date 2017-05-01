//
//  FlightSearchCell.swift
//  MyFlightSearchApp
//
//  Created by Christophe Foucan on 18/04/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import UIKit

class FlightSearchCell: UITableViewCell {

    @IBOutlet weak var airplaneImageView: UIImageView!
    @IBOutlet weak var departureAirportCodeLabel: UILabel!
    @IBOutlet weak var arrivalAirportCodeLabel: UILabel!
    @IBOutlet weak var departureAirportLabel: UILabel!
    @IBOutlet weak var arrivalAirportLabel: UILabel!
    @IBOutlet weak var salePriceLabel: UILabel!
    @IBOutlet weak var departureHourLabel: UILabel!
    @IBOutlet weak var arrivalHourLabel: UILabel!
    
    @IBOutlet weak var tripView: UIView!
    @IBOutlet weak var salePriceView: UIView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
