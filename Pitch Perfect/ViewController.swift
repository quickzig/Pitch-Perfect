//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Brian Quick on 6/7/15.
//  Copyright (c) 2015 Brian Quick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        recordButton.enabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        //TODO: Record the user's voice
        recordingLabel.hidden = false
        stopButton.hidden = false
        recordButton.enabled = false
        
        println("In recordAudio")
        
    }

    @IBAction func recordingStop(sender: UIButton) {
        recordingLabel.hidden = true
    }
    
   
    
}

