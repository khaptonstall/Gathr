//
//  AddEventViewController.swift
//  Gathr
//
//  Created by Navya Myneni on 9/26/15.
//  Copyright © 2015 Kyle Haptonstall. All rights reserved.
//

import UIKit
import Parse
import MapKit

class AddEventViewController: UIViewController {

    var startDate:NSDate?
    var endDate:NSDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        //Looks for single or multiple taps.
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
   @IBOutlet weak var eventTitle: UITextField!
    @IBOutlet weak var hostName: UITextField!
  
    @IBOutlet weak var dateTextField: UITextField!
    
   
 
  
    @IBOutlet weak var location: UITextField!
    
    @IBOutlet weak var dateEndField: UITextField!

    
    //End date picker function envoker
    @IBAction func endTimeEditing(sender: UITextField) {
        var datePickerView1:UIDatePicker = UIDatePicker()
        
        datePickerView1.datePickerMode = UIDatePickerMode.DateAndTime
        
        sender.inputView = datePickerView1
        
        datePickerView1.addTarget(self, action: Selector("date2PickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    //start date picker function envoker
    
    @IBAction func textFieldEditing(sender: UITextField) {
        
        var datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.DateAndTime
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    //end date picker function catcher..--method imp
    func date2PickerValueChanged(sender1:UIDatePicker) {
        
        var dateFormatter1 = NSDateFormatter()
        
        dateFormatter1.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter1.timeStyle = NSDateFormatterStyle.MediumStyle
        self.endDate = sender1.date
        
        dateEndField.text = dateFormatter1.stringFromDate(sender1.date)
        
    }
    
    //start date picker function catcher..--method imp
    func datePickerValueChanged(sender:UIDatePicker) {
        
        var dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
        
        self.startDate = sender.date
        
        dateTextField.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    @IBAction func addEvent(sender: AnyObject) {
        
//        var etitle = eventTitle.text
//        var ehost = hostName.text
//        var stime  = sTime.text
//        var etime = eTime.text
//        var sdate = sDate.text
//        var edate = eDate.text
//        var loc = location.text
        
        
               
     
        
        if eventTitle.text!.isEmpty || hostName.text!.isEmpty || dateTextField.text!.isEmpty ||  dateEndField.text!.isEmpty || location.text!.isEmpty{
            print("enter something")
            let alert = UIAlertView()
            alert.title = "Oops"
            alert.message = "You must enter all fields!"
            alert.addButtonWithTitle("Now")
            alert.show()
            
        }
        else{
        send_datatoparse()
        }
    }
    
    
        func send_datatoparse(){
            
            
            //
            
            
            var add_Event = PFObject(className:"Events")
            add_Event["title"] = eventTitle.text
            add_Event["hostname"] = hostName.text
            add_Event["startDate"] = dateTextField.text
            add_Event["endDate"] = dateEndField.text
            add_Event["startDates"] = self.startDate
            add_Event["endDates"] = self.endDate
            var address = location.text
            print(location.text)
            var geocoder = CLGeocoder()
            geocoder.geocodeAddressString(address!) { (placemarks, error) -> Void in
                
                if let firstPlacemark = placemarks?[0] {
                    let loc:CLLocation = firstPlacemark.location!
                    var geo = PFGeoPoint(latitude: (loc.coordinate.latitude), longitude: (loc.coordinate.longitude))
                    add_Event["Location"] =  PFGeoPoint(location: loc)
                    do{
                        try add_Event.save()
                    }catch _{
                        
                    }
                    
                }
            }
            
            add_Event.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // The object has been saved.
                    let alert = UIAlertView()
                    alert.title = "Message"
                    alert.message = "Event Created"
                    alert.addButtonWithTitle("Check Events")
                    alert.show()
                    
                    
                    
                    
                } else {
                    // There was a problem, check error.description
                }
            }
            
            
            
            
            
            //
            

            
        }
        
        
    
   
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
