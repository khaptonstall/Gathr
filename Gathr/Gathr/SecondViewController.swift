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
        //manager.startUpdatingLocation()
        var loc = CLLocation(latitude: 41.934307, longitude: -88.773546)
       
        
        let latDelta:CLLocationDegrees = 0.045
        let longDelta:CLLocationDegrees = 0.045

        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(loc.coordinate.latitude, loc.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        self.map.setRegion(region, animated: true)
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "You Are Here!"
    
        self.map.addAnnotation(annotation)
        /*
        let mapCenter = map.userLocation.coordinate
        var mapCamera = MKMapCamera(lookingAtCenterCoordinate: mapCenter, fromEyeCoordinate: mapCenter, eyeAltitude: 100000)
        map.setCamera(mapCamera, animated: true)
        */
        let point:PFGeoPoint =  PFGeoPoint(location: CLLocation(latitude: location.latitude, longitude: location.longitude))
        query.whereKey("Location", nearGeoPoint: point, withinKilometers: 50.0)
        query.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                for obj in objects! {
                    var dLocation = obj["Location"] as! PFGeoPoint
                    
                    var annotation = MKPointAnnotation()
                    var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(dLocation.latitude, dLocation.longitude)
                    
                    annotation.coordinate = location
                    annotation.title = obj["title"] as! String
                    annotation.subtitle = obj["startDate"] as! String
                    self.map.addAnnotation(annotation)
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
        self.map.setRegion(region, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

