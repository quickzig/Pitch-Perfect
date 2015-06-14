//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Brian Quick on 6/10/15.
//  Copyright (c) 2015 Brian Quick. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    /// RecoredAudio object sent from the viewController segue
    var receivedAudio:RecordedAudio!
    var audioPlayer:AVAudioPlayer!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set the audioPlayer and audioFile using the sound file sent to this view
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    ///Action that is ran when the slow 'snail' button is pressed
    @IBAction func playSlowSound(sender: UIButton) {
        playSound(0.5)
    }
    
    ///Action that is ran when the fast 'rabbit' button is pressed
    @IBAction func playFastSound(sender: UIButton) {
        playSound(2.0)
    }
    
    ///Action that is ran when the 'chipmunk' button is pressed
    @IBAction func playChipmunkSound(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    ///Action that is ran when the 'darth' button is pressed
    @IBAction func playDarthvaderSound(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    ///Action that is ran when the echo 'parrot' button is pressed
    @IBAction func playEchoSound(sender: UIButton) {
        playAudioWithEcho(0.5)
    }
    
    ///Action that is ran when the 'stop' button is pressed
    @IBAction func stopSound(sender: UIButton) {
        audioPlayer.stop()
    }
    
    //Set the speed of the playback and play the audio
    func playSound(speed: Float ){
        setAudioPlayerAndEngine()
        audioPlayer.rate = speed
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    //Set the echo delay and play the audio
    func playAudioWithEcho(delay: NSTimeInterval){
        var changeDelayEffect = AVAudioUnitDelay()
        changeDelayEffect.delayTime = delay
        audioEngine.attachNode(changeDelayEffect)
        playEffectAudio(changeDelayEffect)
    }
    
    //Set the time pitch and play the audio
    func playAudioWithVariablePitch(pitch: Float){
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        playEffectAudio(changePitchEffect)
    }
    
    ///Used to stop and reset the audioPlayer and audioEngine
    func setAudioPlayerAndEngine(){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    ///Plays audio with special effects
    func playEffectAudio(effect: AVAudioNode!){
        setAudioPlayerAndEngine()
        //Attach the sound effect to the audioEngine play the sound
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        audioEngine.connect(audioPlayerNode, to: effect, format: nil)
        audioEngine.connect(effect, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
}
