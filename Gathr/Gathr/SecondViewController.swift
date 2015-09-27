//
//  SecondViewController.swift
//  Gathr
//
//  Created by Kyle Haptonstall on 9/26/15.
//  Copyright © 2015 Kyle Haptonstall. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Parse

class SecondViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var manager: CLLocationManager!
    var locations: [CLLocation] = []
    
    var desLocation: PFGeoPoint = PFGeoPoint()
    var query = PFQuery(className: "Events")
    
    @IBOutlet weak var map: MKMapView!
    
    
    var places = [Dictionary<String, String>()]

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
        let point:PFGeoPoint =  PFGeoPoint(location: locations[0])
        query.whereKey("Location", nearGeoPoint: point, withinKilometers: 5.0)
        query.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                for obj in objects! {
                    self.desLocation = obj["Location"] as! PFGeoPoint
                }
            } else {
                print("Error")
            }
            
        })
   
    }
    

    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        let userLocation:CLLocation = locations[0]
        
        let latitude = userLocation.coordinate.latitude
        
        let longitude = userLocation.coordinate.longitude
        
        //let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        
        let latDelta:CLLocationDegrees = 0.1
        
        let lonDelta:CLLocationDegrees = 0.1
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        self.map.setRegion(region, animated: false)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

