//
//  EventDetailView.swift
//  Gathr
//
//  Created by Kyle Haptonstall on 9/26/15.
//  Copyright © 2015 Kyle Haptonstall. All rights reserved.
//

import Foundation
import UIKit
import Parse
import MapKit
import EventKit

protocol EventDetailViewDelegate {
    //func EventViewIsAttending(value: Int)
    //func EventViewIsNotAttending(value: Int)
}

class EventDetailView: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    var delegate : EventDetailViewDelegate?

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var hostLabel: UILabel!
    @IBAction func remindButton(sender: AnyObject) {
        self.setCalReminder()

    }
   
    
    var eTitle:String?
    var eTime:String?
    var eDate:String?
    var eLocation:String?
    var lat:Double?
    var long:Double?
    var eHost:String?
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.hidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var lat: CLLocationDegrees = self.lat!
        let long: CLLocationDegrees = self.long!
        let latitude = lat//userLocation.coordinate.latitude
        let longitude = long //userLocation.coordinate.longitude
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
      //  let latDelta:CLLocationDegrees = 0.1
      //  let lonDelta:CLLocationDegrees = 0.1
   //     var theSpan: MKCoordinateSpan = MKCoordinateSpanMake(latDelta,lonDelta)
    //    var mypos: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat,long)
     //   var region:MKCoordinateRegion = MKCoordinateRegionMake(mypos, theSpan)
     //   self.mapView.setRegion(region, animated: true)
        
        
        
        var loc = CLLocation(latitude: lat, longitude: long)
        
        
        let latDelta:CLLocationDegrees = 0.0009
        let longDelta:CLLocationDegrees = 0.0009
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(loc.coordinate.latitude, loc.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        self.mapView.setRegion(region, animated: true)
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = eTitle
        self.mapView.addAnnotation(annotation)
        
        
        
        
        titleLabel.text = eTitle
      
        timeLabel.text = eTime
        dateLabel.text = eDate
        locationLabel.text = eLocation
        hostLabel.text = eHost
        
    }
    
    func setCalReminder(){
        
        var eventStore : EKEventStore = EKEventStore()
        eventStore.requestAccessToEntityType(EKEntityType.Event, completion: {
            granted, error in
            if (granted) && (error == nil) {
                //Add event to user calendar
                
              //  if #available(iOS 8.0, *) {
                   /* let addEventToCalendar = UIAlertController(title: "Would you like to set a reminder?", message:
                        "", preferredStyle: UIAlertControllerStyle.Alert)
                    addEventToCalendar.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction) in*/
                        var event:EKEvent = EKEvent(eventStore: eventStore)
                        event.title = self.eTitle!
                        var alarm:EKAlarm = EKAlarm(relativeOffset: -3600)
                        event.alarms = [alarm]
                        event.startDate = NSDate()
                        event.endDate = event.startDate.dateByAddingTimeInterval(60*60) //1 hour long meeting
                        event.calendar = eventStore.defaultCalendarForNewEvents
                        do {
                            try  eventStore.saveEvent(event, span: .ThisEvent)
                        } catch _ {
                        }
                       // addEventToCalendar.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default,handler: nil))
                        
                        //self.presentViewController(addEventToCalendar, animated: true, completion: nil)
                        
                        //Create a display for the user
                        let alertController = UIAlertController(title: "A reminder has been set!", message:
                            "We'll see you there!", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                        //Present display informing user the event was added
                        self.presentViewController(alertController, animated: true, completion: nil)
                   // }))
               // }
                
                
            }
            else{
                print(error)
            }
        })
    }
    
    
    
}



    