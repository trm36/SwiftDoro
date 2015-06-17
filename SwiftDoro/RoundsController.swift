//
//  RoundsController.swift
//  SwiftDoro
//
//  Created by TRM on 6/17/15.
//  Copyright (c) 2015 MottApplications. All rights reserved.
//

import UIKit

class RoundsController: NSObject {
    
    var currentRound: Int?
    let roundTimes = [1500, 300, 1500, 300, 1500, 300, 1500, 900]
//    let roundTimes = [15, 3, 15, 3, 15, 3, 15, 9]  //For Testing
//    let roundTimes = [61, 120, 121, 15, 60, 62, 0] //For Testing

    static let sharedInstance = RoundsController()
    
    func roundSelected() {
        if let round = self.currentRound {
            Timer.sharedInstance.seconds = self.roundTimes[round]
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName(kNewRoundNotification, object: nil)
    }
    
    class func imageNames() -> [String] {
        return ["work", "play", "work", "play", "work", "play", "work", "nap"]
    }
    
    
//     (RoundsController *)sharedInstance;
//    - (void)roundSelected;
//    + (NSArray *)imageNames;
   
}