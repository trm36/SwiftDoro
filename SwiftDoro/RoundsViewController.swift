//
//  FirstViewController.swift
//  SwiftDoro
//
//  Created by TRM on 6/17/15.
//  Copyright (c) 2015 MottApplications. All rights reserved.
//

import UIKit

let resueID = "reuseID"

class RoundsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.registerForNotifications()
    }
    
    deinit {
        self.unregisterForNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: - Table View Delegate Methods
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        RoundsController.sharedInstance.currentRound = indexPath.row
        RoundsController.sharedInstance.roundSelected()
        
        Timer.sharedInstance.cancelTimer()
    }
    
//MARK: - Table View DataSource Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RoundsController.sharedInstance.roundTimes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(resueID) as! UITableViewCell
        
        let roundsArray = RoundsController.sharedInstance.roundTimes
        let minutes = roundsArray[indexPath.row] / 60
        let seconds = roundsArray[indexPath.row] - minutes * 60
        
        var timeString = "\(minutes) "
        
        if minutes == 1 {
            timeString += "minute"
        } else {
            timeString += "minutes"
        }
        
        if seconds == 1 {
            timeString += ", \(seconds) second"
        } else if seconds > 1 {
            timeString += ", \(seconds) seconds"
        }
        
        cell.textLabel?.text = timeString
        cell.imageView?.image = UIImage(named: RoundsController.imageNames()[indexPath.row])
        
        return cell
    }
    
//MARK: - Notification Methods
    func registerForNotifications() {
        NSNotificationCenter.defaultCenter() .addObserver(self, selector: "roundComplete", name: kTimerCompleteNotification, object: nil)
    }
    
    func unregisterForNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func roundComplete() {
        if let currentRound = RoundsController.sharedInstance.currentRound {
            if RoundsController.sharedInstance.currentRound < RoundsController.sharedInstance.roundTimes.count - 1 {
                if let currentRound = RoundsController.sharedInstance.currentRound {
                    let newCurrentRound = currentRound + 1
                    RoundsController.sharedInstance.currentRound = newCurrentRound
                    self.tableView.selectRowAtIndexPath(NSIndexPath(forRow: newCurrentRound, inSection: 0), animated: true, scrollPosition: .None)
                    
                }
                
            } else {
                RoundsController.sharedInstance.currentRound = 0
                self.tableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: true, scrollPosition: .None)
            }
            RoundsController.sharedInstance.roundSelected()
        }
        
    }


}

