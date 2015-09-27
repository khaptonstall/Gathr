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

class EventListView: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, EventDetailViewDelegate{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let eventQuery = PFQuery(className: "Events")
    var eventList = [EventCell]()
    
    
     override func viewDidLoad(){
        super.viewDidLoad()
        //self.tableView.rowHeight = 60
        self.view.backgroundColor = UIColor.lightGrayColor()
        //Set up table view
        self.tableView.backgroundColor = UIColor.clearColor()
        tableView!.dataSource = self
        tableView!.delegate = self
        self.view.addSubview(tableView!)

        
        PFAnonymousUtils.logInWithBlock {
            (user: PFUser?, error: NSError?) -> Void in
            if error != nil || user == nil {
                print("Anonymous login failed.")
            } else {
                print("Anonymous user logged in.")
            }
        }
        
        self.getEvents()


    }
    
    func getEvents(){
        self.eventQuery.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil{
                for obj in objects!{
                    var event = EventCell()
                    event.eventTitle = obj["title"] as! String
                    event.eventStartDate = obj["startDate"] as! String
                    event.eventTime = obj["time"] as! String
                    self.eventList.append(event)
                }
                self.tableView.reloadData()
            }
            else{
                print(error)
            }
            
        })
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


        //cell.timeLabel.text = self.eventList[indexPath.row].event
       // cell.textLabel?.text = self.items[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showEventDetail" {
            let destination = segue.destinationViewController as? EventDetailView
            let cell = sender as! UITableViewCell
            // let selectedRow = collectionView.indexPathForCell(cell)!.row
            //destination!.eTitle =  events[selectedRow].summary
            
            /*destination!.networkConnection = self.networkConnection
            if((events[selectedRow].endTime) != nil){
            /// destination!.time = events[selectedRow].startTime! + " - " + events[selectedRow].endTime!
            }else{
            // destination!.time = events[selectedRow].startTime
            }*/
            
            
            
            destination!.delegate = self;
        }
    }

   
    

}