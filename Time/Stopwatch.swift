//
//  Stopwatch.swift
//  Time
//
//  Created by TinhVV on 8/6/18.
//  Copyright © 2018 TinhVV. All rights reserved.
//

import Foundation
import UIKit

class Stopwatch {
    private var startTime : NSDate?
    
    var elapsdTime: TimeInterval {
        if let startTime = self.startTime {
            return -startTime.timeIntervalSinceNow
        } else {
            return 0
        }
    }
    
    var isRunning : Bool {
        return startTime != nil
    }
    
    func start() {
        startTime = NSDate()
    }
    
    func stop() {
        startTime = nil
    }
}
