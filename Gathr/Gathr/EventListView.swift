//
//  EventListView.swift
//  Gathr
//
//  Created by Kyle Haptonstall on 9/26/15.
//  Copyright © 2015 Kyle Haptonstall. All rights reserved.
//

import Foundation
import Parse
import UIKit
import MapKit

class EventListView: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate,EventDetailViewDelegate{
    
    var manager: CLLocationManager!
    
    @IBOutlet weak var tableView: UITableView!
    var refreshCtrl = UIRefreshControl()

    let eventQuery = PFQuery(className: "Events")
    var eventList = [EventCell]()
    var region:MKCoordinateRegion?

    
     override func viewDidLoad(){
        super.viewDidLoad()
        
      /*  manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation() */
        var lat: CLLocationDegrees = 41.934068
        var long: CLLocationDegrees = -88.773857
        let latitude = lat//userLocation.coordinate.latitude
        
        let longitude = long //userLocation.coordinate.longitude
        
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        
        let latDelta:CLLocationDegrees = 0.1
        
        let lonDelta:CLLocationDegrees = 0.1
        
        var theSpan: MKCoordinateSpan = MKCoordinateSpanMake(latDelta,lonDelta)
        
        var mypos: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat,long)
  
        self.region = MKCoordinateRegionMake(mypos, theSpan)
        
        
        
        self.view.backgroundColor = UIColor.lightGrayColor()
        //Set up table view
        self.tableView.backgroundColor = UIColor.clearColor()
        tableView!.dataSource = self
        tableView!.delegate = self
        self.view.addSubview(tableView!)

        
        self.refreshCtrl.addTarget(self, action: "pullToRefresh", forControlEvents: .ValueChanged)
        self.refreshCtrl.tintColor = UIColor.whiteColor()
        self.tableView.addSubview(self.refreshCtrl)
        
    /*    PFAnonymousUtils.logInWithBlock {
            (user: PFUser?, error: NSError?) -> Void in
            if error != nil || user == nil {
                print("Anonymous login failed.")
            } else {
                print("Anonymous user logged in.")
            }
        }*/
        
        self.getEvents()


    }
    
    
    
    func pullToRefresh(){
       // if refreshCtrl.refreshing == false {
           self.getEvents()
       // }
        
        refreshCtrl.endRefreshing()
    }
    
    
    
    
    
   /* func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation:CLLocation = locations[0]
        var lat: CLLocationDegrees = -23.527096772791133
        var long: CLLocationDegrees = -46.48964569157911
        let latitude = lat//userLocation.coordinate.latitude
        
        let longitude = long //userLocation.coordinate.longitude
        
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        
        let latDelta:CLLocationDegrees = 0.01
        
        let lonDelta:CLLocationDegrees = 0.01
        
        var theSpan: MKCoordinateSpan = MKCoordinateSpanMake(latDelta,lonDelta)
        
        var mypos: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat,long)
        
        self.region = MKCoordinateRegionMake(mypos, theSpan)
        
        //let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        //let region:MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
        //self.region = MKCoordinateRegionMake(coordinate, span)
        //self.map.setRegion(region, animated: true)

    } */

    
    
    func getEvents(){
        self.eventQuery.orderByAscending("startDates")
        self.eventQuery.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil{
                self.eventList.removeAll(keepCapacity: false)
                for obj in objects!{
                    
                    let title = obj["title"] as! String
                    let endDate = obj["endDate"] as! String
                    let startDate = obj["startDate"] as! String
                    var loc =  obj["Location"] as! PFGeoPoint
                    var host = obj["hostname"] as! String
                    self.storeObject(title, start: startDate, end: endDate, loc: loc, host: host)
       
                }
                self.tableView.reloadData()
            }
            else{
                print(error)
            }
            
        })
    }
    
    func storeObject(title:String, start:String, end:String, loc:PFGeoPoint, host:String){
        var event = EventCell()
        event.eventTitle = title
        
        event.eventStartDate = end
        
        event.eventTime = start
            
        event.eventLocation = loc
        event.eventHost = host
        
        self.eventList.append(event)
    }
    

    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCellWithIdentifier("EventCell") as! EventCell
        cell.titleLabel.text = self.eventList[indexPath.row].eventTitle
        cell.timeLabel.text = self.eventList[indexPath.row].eventTime
        cell.dateLabel.text = self.eventList[indexPath.row].eventStartDate
        cell.hostLabel.text = self.eventList[indexPath.row].eventHost
        if self.region != nil{
            cell.mapView.setRegion(self.region!, animated: true)

        }

      
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showEventDetail" {
            let destination = segue.destinationViewController as? EventDetailView
            let cell = sender as! UITableViewCell
            
             let selectedRow = tableView.indexPathForCell(cell)!.row
            destination?.eTitle = eventList[selectedRow].eventTitle
            destination?.eTime = eventList[selectedRow].eventTime
            destination?.eDate = eventList[selectedRow].eventStartDate
            
            destination?.lat = eventList[selectedRow].eventLocation?.latitude
            destination?.long = eventList[selectedRow].eventLocation?.longitude
            destination!.eHost = eventList[selectedRow].eventHost
            
            destination!.delegate = self;
        }
    }

   
    

}