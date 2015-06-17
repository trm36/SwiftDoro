//
//  Timer.swift
//  SwiftDoro
//
//  Created by TRM on 6/17/15.
//  Copyright (c) 2015 MottApplications. All rights reserved.
//

import UIKit

let kSecondTickNotifcation = "secondTickNotification"
let kTimerCompleteNotification = "TimerCompleteNotification"
let kNewRoundNotification = "newRoundNotification"
let kExpirationDateKey = "expiryDate"

class Timer: NSObject {
    
    var seconds: Int = 0
    private var isOn = false
    private var expiryDate: NSDate?
    var timer = NSTimer()
    
    static let sharedInstance = Timer()
    
    func startTimer() {
        self.isOn = true;
        let timerInterval = NSTimeInterval(seconds)
        self.expiryDate = NSDate(timeIntervalSinceNow: timerInterval)
        
        let timerExpiredNotification = UILocalNotification()
        timerExpiredNotification.fireDate = self.expiryDate
        timerExpiredNotification.timeZone = NSTimeZone.defaultTimeZone()
        timerExpiredNotification.soundName = UILocalNotificationDefaultSoundName
        timerExpiredNotification.alertBody = "Round Complete. Continue with next round?"
        
        UIApplication.sharedApplication().scheduleLocalNotification(timerExpiredNotification)
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "decreaseSecond", userInfo: nil, repeats: true)
    }
    
    func cancelTimer() {
        self.isOn = false;
        self.timer.invalidate()
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }
    
    func endTimer() {
        self.isOn = false;
        self.timer.invalidate()
        NSNotificationCenter.defaultCenter().postNotificationName(kTimerCompleteNotification, object: nil)
    }
    
    func decreaseSecond() {
        if self.seconds > 0 {
            self.seconds--
            NSNotificationCenter.defaultCenter().postNotificationName(kSecondTickNotifcation, object: nil)
        } else {
            self.endTimer()
        }
    }
    
    func prepareForBackground() {
        NSUserDefaults.standardUserDefaults().setObject(self.expiryDate, forKey: kExpirationDateKey)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func loadFromBackground() {
        self.expiryDate = NSUserDefaults.standardUserDefaults().objectForKey(kExpirationDateKey) as? NSDate
        let remainingTime = self.expiryDate?.timeIntervalSinceNow
        if let time = remainingTime {
            self.seconds = Int(time)
        }
    }
    
   
}
