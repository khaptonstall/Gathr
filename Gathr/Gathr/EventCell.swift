//
//  EventCell.swift
//  Gathr
//
//  Created by Kyle Haptonstall on 9/26/15.
//  Copyright © 2015 Kyle Haptonstall. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import Parse

class EventCell: UITableViewCell{
    //let map = mapView
    var eventTitle:String?
    var eventLocation:PFGeoPoint? //change to map variable for location
    var eventStartDate:String?
    var eventEndDate:String?
    var eventTime:String?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
}