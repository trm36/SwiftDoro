//
//  SecondViewController.swift
//  SwiftDoro
//
//  Created by TRM on 6/17/15.
//  Copyright (c) 2015 MottApplications. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.registerForNotifications()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.updateTimerLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        self.unregisterForNotification()
    }
    
    @IBAction func timerButtonTapped(sender: UIButton) {
        sender.enabled = false;
        Timer.sharedInstance.startTimer()
    }
    
    func newRound() {
        self.updateTimerLabel()
        self.timerButton?.enabled = true;
    }
    
    func updateTimerLabel() {
        let seconds = Timer.sharedInstance.seconds
        
        self.timerLabel?.text = self.timerStringWithSeconds(seconds)
    }
    
    func timerStringWithSeconds(seconds: Int) -> String {
        var timerString = String()
        
        let minutes = seconds / 60
        let secondsMinusMinutes = seconds - minutes * 60
        
        if minutes >= 10 {
            timerString = "\(minutes):"
        } else {
            timerString = "0\(minutes):"
        }
        
        if secondsMinusMinutes >= 10 {
            timerString += "\(secondsMinusMinutes)"
        } else {
            timerString += "0\(secondsMinusMinutes)"
        }
        
        return timerString
    }
    
    
    
    //MARK: - Notifications Methods
    
    func registerForNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateTimerLabel", name: kSecondTickNotifcation, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "newRound", name: kNewRoundNotification, object: nil)
    }
    
    func unregisterForNotification() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }


}

