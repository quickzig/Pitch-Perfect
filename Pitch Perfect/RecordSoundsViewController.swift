//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Brian Quick on 6/7/15.
//  Copyright (c) 2015 Brian Quick. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    ///Object that stores the fileURL and title
    var recordedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(animated: Bool) {
        //Set the view so that it is ready to record
        stopButton.hidden = true
        recordButton.enabled = true
        recordingLabel.text = "Tap to Record"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    ///Action that is ran when the 'microphone' button is pressed
    @IBAction func recordAudio(sender: UIButton) {
        //Set the view so that users know it is recording and give them a stop button
        recordingLabel.text = "Recording in Progress"
        stopButton.hidden = false
        recordButton.enabled = false

        //Get the file name and path
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)

        //Set the audioRecorder setting and start recording.
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)

        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        //Check if the recording is successful. If so, send the recordedAudio object to the next view
        if(flag){
            recordedAudio =  RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }else{
            println("Recording was not successful")
            recordButton.enabled = true
            stopButton.hidden = true
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //Set the destination viewController for the segue and what data to send to it.
        if (segue.identifier == "stopRecording"){
            let playSoundsVC:PlaySoundViewController = segue.destinationViewController as! PlaySoundViewController
            let data = sender as! RecordedAudio!
            playSoundsVC.receivedAudio = data
        }
    }
    
    ///Action that is ran when the 'stop' button is pressed
    @IBAction func recordingStop(sender: UIButton) {
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
}

