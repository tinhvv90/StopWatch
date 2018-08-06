//
//  ViewController.swift
//  Time
//
//  Created by TinhVV on 8/6/18.
//  Copyright © 2018 TinhVV. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeDisplay: UILabel!
    
    weak var timer: Timer?
    var startTime: Double = 0
    var time: Double = 0
    var elapsed: Double = 0
    var status: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        resetBtn.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func stopAction(_ sender: UIButton) {
        // Invalidate timer
        timer?.invalidate()
        
        // Reset timer variables
        startTime = 0
        time = 0
        elapsed = 0
        status = false
        
        // Reset all three labels to 00
        let strReset = String("00:00.00")
        timeDisplay.text = strReset
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        // If button status is true use stop function, relabel button and enable reset button
        if (status) {
            stop()
            sender.setTitle("START", for: .normal)
//            resetBtn.isEnabled = true
            
            // If button status is false use start function, relabel button and disable reset button
        } else {
            start()
            sender.setTitle("STOP", for: .normal)
//            resetBtn.isEnabled = false
        }
    }
    
    func start() {
        
        startTime = Date().timeIntervalSinceReferenceDate - elapsed
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
        // Set Start/Stop button to true
        status = true
        
    }
    
    func stop() {
        
        elapsed = Date().timeIntervalSinceReferenceDate - startTime
        timer?.invalidate()
        
        // Set Start/Stop button to false
        status = false
        
    }
    
    @objc func updateCounter() {
        
        // Calculate total time since timer started in seconds
        time = Date().timeIntervalSinceReferenceDate - startTime
        
        // Calculate minutes
        let minutes = UInt8(time / 60.0)
        time -= (TimeInterval(minutes) * 60)
        
        // Calculate seconds
        let seconds = UInt8(time)
        time -= TimeInterval(seconds)
        
        // Calculate milliseconds
        let milliseconds = UInt8(time * 100)
        
        // Format time vars with leading zero
        let strMinutes = String(format: "%02d", minutes)
        var strSeconds = String(format: "%02d", seconds)
        var strMilliseconds = String(format: "%02d", milliseconds)
        
        let array = strSeconds.characters.flatMap{Int(String($0))}
        
        let array2 = strMilliseconds.characters.flatMap{Int(String($0))}
        
        if array.first! % 2 == 0 {
            if array2.last! % 2 == 0 {
                strMilliseconds = String(format: "%02d", Int(strMilliseconds)! + 1)
                
            }
        } else {
            if array2.last! % 2 != 0 {
                strMilliseconds = String(format: "%02d", Int(strMilliseconds)! + 1)
            }
        }
        
        // Add time vars to relevant labels
        timeDisplay.text = "\(strMinutes):\(strSeconds).\(strMilliseconds)"
       
    }
    
}

extension Int {
    var array: [Int] {
        return String(self).flatMap{ Int(String($0)) }
    }
}


