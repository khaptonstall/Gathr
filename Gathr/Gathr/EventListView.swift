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

class EventListView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate{
    
    
    
     override func viewDidLoad(){
        super.viewDidLoad()
        
        PFAnonymousUtils.logInWithBlock {
            (user: PFUser?, error: NSError?) -> Void in
            if error != nil || user == nil {
                print("Anonymous login failed.")
            } else {
                print("Anonymous user logged in.")
            }
        }


    }
    
    
    
    // Function: numberOfSectionsInCollectionView
    // Input: UICollectionView
    // Output: Int
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Function: collectionView
    // Input: UICollectionView, Int
    // Output: Int
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    // Function: collectionView
    // Input: UICollectionView, NSIndexPath
    // Output: UICollecitonViewCell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("EventCell", forIndexPath: indexPath) as! EventCell
       
        
        return cell
    }
    
    
    
    
    // Function: collectionView
    // Input: UICollectionView, UICollectionViewLayout, NSIndexPath
    // Output: CGSize
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        
        return CGSize(width: self.view.bounds.width ,height: 80) 
    }
    
   
   
    

}