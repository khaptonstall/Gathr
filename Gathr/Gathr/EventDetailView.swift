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

protocol EventDetailViewDelegate {
    //func EventViewIsAttending(value: Int)
    //func EventViewIsNotAttending(value: Int)
}

class EventDetailView: UIViewController{
    
    var delegate : EventDetailViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
}



    