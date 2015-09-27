//
//  AddEventViewController.swift
//  Gathr
//
//  Created by Navya Myneni on 9/26/15.
//  Copyright © 2015 Kyle Haptonstall. All rights reserved.
//

import UIKit
import Parse


class AddEventViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var eventTitle: UITextField!
    @IBOutlet weak var hostName: UITextField!
    @IBOutlet weak var sTime: UITextField!
    @IBOutlet weak var eTime: UITextField!
    @IBOutlet weak var sDate: UITextField!
    @IBOutlet weak var eDate: UITextField!
    @IBOutlet weak var location: UITextField!
    
    
    @IBAction func addEvent(sender: AnyObject) {
        
        var etitle = eventTitle.text
        var ehost = hostName.text
        var stime  = sTime.text
        var etime = eTime.text
        var sdate = sDate.text
        var edate = eDate.text
        var loc = location.text
    
        func send_datatoparse(){
            
            
            //
            
            
            var add_Event = PFObject(className:"Events")
            add_Event["eTitle"] = etitle
            add_Event["ehost"] = ehost
            add_Event["etime"] = etime
            add_Event["stime"] = stime
            add_Event["sdate"] = sdate
            add_Event["edate"] = edate
            add_Event["loc"] = loc
            add_Event.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // The object has been saved.
                } else {
                    // There was a problem, check error.description
                }
            }
            
            
            
            //
            

            
        }
        
        
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
